import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../../../common/common.dart';
import '../../../constants/constants.dart';
import '../../../data/data_sources/remote/kyc_remote_data_source.dart';
import '../../../data/models/kyc/get_kyc_data_model.dart';
import '../../../data/models/kyc/verify_pan_response_model.dart';
import '../../../di/get_it.dart';
import '../../../gen/assets.gen.dart';
import '../../../logger.dart';
import '../../cubits/authentication/auth/auth_cubit.dart';
import '../../cubits/onboarding/retake_kyc/retake_kyc_cubit.dart';
import '../../routes/routes.dart';
import '../../widgets/banner_container.dart';

class KycStatusBanner extends HookWidget {
  const KycStatusBanner({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isOnBoardingCompleted = context
        .select((AuthCubit bloc) => bloc.state.user!.isOnBoardingCompleted);
    late final future = useMemoized(
      () => getIt<KycRemoteDataSource>().getKycData(),
    );

    return !isOnBoardingCompleted
        ? FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return BannerContainer(
                  image: Assets.svgs.kycPending.svg(),
                  title: 'Complete your KYC',
                  subtitle: AppStrings.completeKycMessage,
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.kycRoutingScreen,
                  ),
                  buttonText: 'Complete KYC',
                );
              }

              if (snapshot.hasData) {
                log('snapshot: ${(snapshot.data as GetKycDataModel).toJson()}');
                final String? fpKycStatus =
                    (snapshot.data as GetKycDataModel).fpKycStatus;
                switch (fpKycStatus) {
                  case 'submitted':
                    return BannerContainer(
                      image: Assets.svgs.kycUnderProcess.svg(),
                      title: 'KYC Under Review',
                      subtitle: AppStrings.kycUnderReviewMessage,
                    );

                  ///If is onBoardingCompleted false and status is successful indicates the cron is yet to be run
                  case 'successful':
                    return BannerContainer(
                      image: Assets.svgs.kycUnderProcess.svg(),
                      title: 'KYC Under Review',
                      subtitle: AppStrings.kycUnderReviewMessage,
                    );
                  case 'rejected':
                    return BannerContainer(
                      image: Assets.svgs.kycRejectAndExpiry.svg(),
                      title: 'KYC Rejected',
                      subtitle: AppStrings.kycRejectedMessage,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          builder: (_) => BlocProvider(
                            create: (_) => getIt<RetakeKycCubit>(),
                            child: const _KycRejectedBottomSheet(),
                          ),
                        );
                      },
                      buttonText: 'Know More',
                    );
                  default:
                    return BannerContainer(
                      image: Assets.svgs.kycPending.svg(),
                      title: 'Complete your KYC',
                      subtitle: AppStrings.completeKycMessage,
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.kycRoutingScreen,
                        arguments: VerifyPanResponseModel(
                          fullName:
                              (snapshot.data as GetKycDataModel).panFullName,
                          isCompliant: (snapshot.data as GetKycDataModel)
                              .initialKycStatus,
                          panNumber: (snapshot.data as GetKycDataModel).panNum,
                        ),
                      ),
                      buttonText: 'Complete KYC',
                    );
                }
              }
              return const SizedBox.shrink();
            },
          )
        : const SizedBox.shrink();
  }
}

class _KycRejectedBottomSheet extends StatelessWidget {
  const _KycRejectedBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'KYC Rejected',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Dear ${context.read<AuthCubit>().state.user!.userName ?? 'User'},\nYour KYC application has been rejected. We request you to undergo the KYC application process.',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          const Gap(20),
          BlocListener<RetakeKycCubit, RetakeKycState>(
            listener: (context, state) {
              if (state is RetakeKycSuccess) {
                final user = context.read<AuthCubit>().state.user!;
//Update the status of retake kyc to true since user is retaking kyc
                context.read<AuthCubit>().updateUser(
                      user.copyWith(
                        retakeKyc: true,
                      ),
                    );
                // Navigator.pushNamedAndRemoveUntil(
                //     context, Routes.verifyPan, (route) => false);
              }
              if (state is RetakeKycError) {
                Utils.showErrorAlert(
                  context,
                  Utils.getErrorMessage(
                      errorType: state.errorType, msg: state.error),
                );
              }
            },
            child: ElevatedButton(
                onPressed: () {
                  context.read<RetakeKycCubit>().retakeKyc();
                },
                child: const Text('Retake KYC')),
          ),
        ],
      ),
    );
  }
}
