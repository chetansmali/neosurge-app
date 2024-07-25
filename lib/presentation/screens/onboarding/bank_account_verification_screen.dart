import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../common/custom_styles.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/onboarding/onboarding_page_cubit.dart';
import '../../cubits/onboarding/verify_bank_account/verify_bank_account_cubit.dart';
import '../../theme/app_colors.dart';

class BankAccountVerificationScreen extends StatelessWidget {
  const BankAccountVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                BlocConsumer<VerifyBankAccountCubit, VerifyBankAccountState>(
                  listener: (context, state) {
                    if (state is VerifyBankAccountSuccess) {
                      Future.delayed(
                        const Duration(seconds: 2),
                        () {
                          Navigator.of(context, rootNavigator: true).pop();
                          context.read<OnboardingPageCubit>().goToNextPage();
                        },
                      );
                      return;
                    }
                  },
                  builder: (context, state) {
                    if (state is VerifyBankAccountLoading) {
                      return Column(
                        children: [
                          const Text(
                            'We are depositing ₹1 in your bank account. Please do not close the app.',
                            textAlign: TextAlign.center,
                          ),
                          const Gap(60),
                          Assets.animations.bankDepositeLoading.lottie()
                        ],
                      );
                    }
                    if (state is VerifyBankAccountSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Assets.animations.bankDepositeSuccess.lottie(),
                          const Gap(24),
                          Text(
                            'Bank Account Verified!',
                            style:
                                baseTextStyle.copyWith(color: AppColors.green),
                          ),
                          const Gap(5),
                          const Text(
                            'Redirecting to the next screen in a few seconds...',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                    if (state is VerifyBankAccountFailed) {
                      if (state.errorMessage != null &&
                          state.errorMessage!
                              .contains('invalid bank details')) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Assets.animations.bankDepositeError.lottie(),
                            Text(
                              'Bank Account Verification failed!',
                              style: baseTextStyle.copyWith(
                                  color: AppColors.errorRed),
                            ),
                            const Gap(5),
                            const Text(
                              'We are facing some trouble in connecting with your bank account. Please wait for sometime or add your bank account by trying again.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Assets.animations.bankDepositeError.lottie(),
                            Text(
                              'Something went wrong while verifying bank account',
                              style: baseTextStyle.copyWith(
                                  color: AppColors.errorRed),
                            ),
                          ],
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const Spacer(),
                BlocBuilder<VerifyBankAccountCubit, VerifyBankAccountState>(
                  builder: (context, state) {
                    if (state is VerifyBankAccountFailed) {
                      if (state.errorMessage != null &&
                          state.errorMessage!
                              .contains('invalid bank details')) {
                        return Center(
                          child: ElevatedButton(
                            onPressed: () =>
                                Navigator.of(context, rootNavigator: true)
                                    .pop(),
                            child: const Text('Update Bank Details'),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            Center(
                              child: ElevatedButton(
                                onPressed: () => context
                                    .read<VerifyBankAccountCubit>()
                                    .verifyBankAccount(),
                                child: const Text('Try Again'),
                              ),
                            ),
                            const Gap(20),
                            Center(
                              child: TextButton(
                                onPressed: () =>
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(),
                                child: const Text('I will do it later'),
                              ),
                            ),
                          ],
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
