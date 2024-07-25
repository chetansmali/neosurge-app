import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../cubits/onboarding/kyc_create_account/kyc_create_account_cubit.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_colors.dart';

class KycAccountCreationDialog extends StatefulWidget {
  const KycAccountCreationDialog({super.key});

  @override
  State<KycAccountCreationDialog> createState() =>
      _KycAccountCreationDialogState();
}

class _KycAccountCreationDialogState extends State<KycAccountCreationDialog> {
  @override
  void initState() {
    final user = context.read<AuthCubit>().state.user!;
    super.initState();
    context.read<KycCreateAccountCubit>().createInvestorAccountFunc(
          retakeKyc: user.retakeKyc,
          userId: user.id,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KycCreateAccountCubit, KycCreateAccountState>(
      listener: (context, state) {
        if (state is KycCreateAccountSuccess) {
          final user = context.read<AuthCubit>().state.user!;
          context.read<AuthCubit>().updateUser(
                user.copyWith(isOnBoardingCompleted: true),
              );

          Future.delayed(
            const Duration(seconds: 3),
            () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.dashboard,
                (route) => false,
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: const Color(0xFF050C1B),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state is KycCreateAccountLoading) ...[
                  Assets.animations.loading.lottie(
                    height: 64,
                    width: 64,
                  ),
                ],
                if (state is KycCreateAccountFailure) ...[
                  Assets.animations.bankDepositeSuccess.lottie(
                    height: 64,
                    width: 64,
                  ),
                  const Gap(16),
                  const Text(
                    'Something went wrong!',
                    style: TextStyle(
                      color: AppColors.errorRed,
                      fontSize: 16,
                    ),
                  ),
                ],
                if (state is KycCreateAccountSuccess) ...[
                  Assets.animations.bankDepositeSuccess.lottie(
                    height: 64,
                    width: 64,
                  ),
                  const Gap(16),
                  const Text(
                    'Your All Set to Invest!',
                    style: TextStyle(
                      color: Color(0xFF00B967),
                      fontSize: 16,
                    ),
                  ),
                  const Gap(16),
                  const Text(
                    'Redirecting you in just a few seconds.',
                    style: TextStyle(
                      color: Color(0xFFB0B0B0),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
