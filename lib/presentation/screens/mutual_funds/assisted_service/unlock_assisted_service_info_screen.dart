import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../common/extensions.dart';
import '../../../../data/models/user/assisted_service_user_details.dart';
import '../../../cubits/assisted_service/get_assisted_service_details_cubit/get_assisted_service_details_cubit.dart';
import '../../../cubits/assisted_service/unlock_assisted_service_cubit/unlock_assisted_service_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/neo_logo.dart';
import '../../loading_screen.dart';

class UnlockAssistedServiceInfoScreen extends StatelessWidget {
  const UnlockAssistedServiceInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AssistedServiceUserDetails? assistedService =
        context.watch<AuthCubit>().state.user!.assistedServiceUserDetails;
    return LoadingScreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(assistedService != null
              ? 'Renew Assisted Service'
              : 'Unlock Assisted Service'),
        ),
        body: BlocBuilder<GetAssistedServiceDetailsCubit,
            GetAssistedServiceDetailsState>(
          builder: (context, state) {
            if (state is GetAssistedServiceDetailsLoading) {
              return const Center(child: CustomLoader());
            }
            if (state is GetAssistedServiceDetailsFailure) {
              return Center(
                child: AppErrorWidget(
                    errorType: state.appErrorType,
                    error: state.errorMessage,
                    onRetry: () => context
                        .read<GetAssistedServiceDetailsCubit>()
                        .getAssistedServiceDetails()),
              );
            }
            if (state is GetAssistedServiceDetailsSuccess) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const NeoLogo(
                      height: 60,
                    ),
                    const Gap(20),
                    Text(
                      '${assistedService == null ? 'Start' : 'Continue'} your Investment Journey with Neosurge',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Gap(20),
                    Text(
                        'To ${assistedService == null ? 'Unlock' : 'Continue using'} Assisted Services, Please make the payment'),
                    const Gap(20),
                    _InfoCard(amount: state.response.amount),
                    const Spacer(),
                    Center(
                      child: BlocListener<UnlockAssistedServiceCubit,
                          UnlockAssistedServiceState>(
                        listener: (context, state) {
                          if (state is UnlockAssistedServiceSuccess) {
                            Navigator.pushNamed(
                                context, Routes.assistedServicePaymentWebView,
                                arguments: state.response);
                          }
                          if (state is UnlockAssistedServiceFailure) {
                            Utils.showErrorAlert(
                              context,
                              Utils.getErrorMessage(
                                  errorType: state.appErrorType,
                                  msg: state.errorMessage),
                            );
                          }
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<UnlockAssistedServiceCubit>()
                                .createOrder(amount: state.response.amount);
                          },
                          child: const Text('Proceed to Pay'),
                        ),
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final double amount;

  const _InfoCard({Key? key, required this.amount}) : super(key: key);

  final List<String> features = const [
    'Invest Advisory from Top Investment experts ',
    'Timely Exit Triggers for Best Returns',
    'Active rebalancing to ensure calibration with goals & criteria',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${amount.toCurrencyWithSymbol(decimalDigits: 0)} /-',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const Gap(20),
          ...List.generate(
            features.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.green,
                  ),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      features[index],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
