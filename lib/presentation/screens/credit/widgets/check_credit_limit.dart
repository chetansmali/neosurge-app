import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';
import '../../../../common/utils.dart';
import '../../../../di/get_it.dart';
import '../../../cubits/lamf/lamf_avail_loans/lamf_avail_loan_cubit.dart';
import '../../../cubits/lamf/lamf_get_credit_limit/lamf_get_credit_limit_cubit.dart';
import '../../../cubits/lamf/lamf_get_loan_data/lamf_get_loan_data_cubit.dart';
import '../../../cubits/lamf/lamf_initiate_payment/lamf_initiate_payment_cubit.dart';
import '../../../cubits/lamf/lamf_initiate_withdrawl/lamf_initiate_withdrawal_cubit.dart';
import '../../../cubits/lamf/lamf_update_loan_status/lamf_update_loan_status_cubit.dart';
import '../../../widgets/widgets.dart';
import '../all_transactions_screen.dart';
import '../functions/sdk_functions.dart';
import '../pledged_mfs_screen.dart';
import 'consent_bottom_sheet.dart';
import 'lamf_banner_total.dart';
import 'percentage_circle.dart';

import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';
import 'lamf_banner.dart';
import 'transaction_widgets.dart';

class CheckCreditLimit extends StatefulWidget {
  const CheckCreditLimit(
      {super.key, required this.creditPulled, required this.creditLimit});
  final bool creditPulled;
  final String creditLimit;

  @override
  CheckCreditLimitState createState() => CheckCreditLimitState();
}

class CheckCreditLimitState extends State<CheckCreditLimit> {
  bool isAvailLoanButtonPressed = true;
  bool hasExistingLoan = false;
  bool agreeToTerms = false;
  late bool creditPulled;
  @override
  void initState() {
    creditPulled = widget.creditPulled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LamfGetLoanDataCubit, LamfGetLoanDataState>(
      builder: (context, state) {
        if (state is LamfGetLoanDataLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is LamfGetLoanDataFailure) {
          return BlocBuilder<LamfGetCreditLimitCubit, LamfGetCreditLimitState>(
            builder: (_, state) {
              if (creditPulled) {
                context.read<LamfGetCreditLimitCubit>().lamfGetCreditLimit();
                creditPulled = false;
              }
              if (state is LamfGetCreditLimitFailure) {
                return AppErrorWidget(
                    errorType: state.errorType,
                    error: state.errorMessage,
                    onRetry: () => context
                        .read<LamfGetCreditLimitCubit>()
                        .lamfGetCreditLimit());
              }
              if (state is LamfGetCreditLimitSuccess) {
                final creditUser = state.getCreditLimitDetails;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Loan Against Mutual Funds',
                      style: baseTextStyle16500,
                    ),
                    const Gap(24),
                    LamfBanner(
                        title: 'Credit limit',
                        value: creditUser.creditLimit ?? 0.0,
                        small: false),
                    const Gap(20),
                    if (creditUser.loanPercentage == 100)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const PercentageCircle(percentage: 1),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      style: baseTextStyle12400.copyWith(
                                          color: const Color(
                                              0xFF9EA0A3)), // Apply the base style
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text:
                                                'You are all set! Please wait till your loan is '),
                                        TextSpan(text: 'approved in the '),
                                        TextSpan(
                                          text: 'next hour or two',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: '.'),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    else if (creditUser.loanInitiated!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PercentageCircle(
                                  percentage:
                                      creditUser.loanPercentage! / 100.ceil()),
                              const Gap(8),
                              MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) =>
                                        getIt<LamfAvailLoanCubit>(),
                                  ),
                                  BlocProvider(
                                    create: (context) =>
                                        getIt<LamfUpdateLoanStatusCubit>(),
                                  ),
                                ],
                                child: BlocConsumer<LamfAvailLoanCubit,
                                    LamfAvailLoanState>(
                                  listener: (context, state) async {
                                    if (state is LamfAvailLoanSuccess) {
                                      final availLoanUser =
                                          state.availLoanDetails;

                                      try {
                                        String? response = await callApplySDK(
                                          availLoanUser.interactionToken,
                                        );
                                        if (context.mounted) {
                                          context
                                              .read<LamfUpdateLoanStatusCubit>()
                                              .updateLoanUserStatus(response!);
                                        }
                                      } on ScLoanError catch (e) {
                                        if (context.mounted) {
                                          Utils.showErrorAlert(
                                            context,
                                            '${e.message} \n ${e.code} \n ${e.data} ',
                                            duration: 10,
                                            barrierDismissible: true,
                                          );
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          Utils.showErrorAlert(
                                            context,
                                            'Something went wrong',
                                          );
                                        }
                                      }
                                    }
                                  },
                                  builder: (context, state) {
                                    return Expanded(
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            context
                                                .read<LamfAvailLoanCubit>()
                                                .availLoans();
                                          },
                                          child: state is LamfAvailLoanLoading
                                              ? Assets.animations.loading
                                                  .lottie()
                                              : const Text('Continue')),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Gap(8),
                          Center(
                              child: Text(
                            'Continue your loan application - from where you left off',
                            style: baseTextStyle12400.copyWith(
                                color: const Color(0xFF9EA0A3)),
                          ))
                        ],
                      )
                    else if (creditUser.loanInitiated == false)
                      creditUser.loanPercentage == null
                          ? ElevatedButton(
                              onPressed: () async {
                                context.read<LamfAvailLoanCubit>().availLoans();
                                try {
                                  const config = ScLoanConfig(
                                      ScLoanEnvironment.PRODUCTION,
                                      'bullsurge');
                                  await ScLoan.setup(config);
                                } on ScLoanError {
                                  if (context.mounted) {
                                    Utils.showErrorAlert(
                                      context,
                                      'Something went wrong',
                                    );
                                  }
                                }
                                if (context.mounted) {
                                  context
                                      .read<LamfGetCreditLimitCubit>()
                                      .lamfGetCreditLimit();
                                }
                              },
                              child: const Text('Avail Loan'))
                          : const SizedBox.shrink()
                    else
                      Text(
                        'You already have an existing loan. Come back once it is closed.',
                        style: baseTextStyle10400,
                      )
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          const Gap(5),
                          Text(
                            'Introducing Loan Against Mutual Funds',
                            style: baseTextStyle16500,
                          ),
                        ],
                      ),
                      RotatedBox(
                          quarterTurns: 1,
                          child: Assets.animations.sparkle.lottie())
                    ],
                  ),
                  const Gap(8),
                  Text(
                    'With Neosurge, you can now liquidate your mutual funds',
                    style: baseTextStyle12400.copyWith(
                        color: const Color(0xFF9EA0A3)),
                  ),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0))),
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: context.read<LamfGetCreditLimitCubit>(),
                            child: const ConsentBottomSheet(),
                          );
                        },
                      );
                    },
                    child: const Text('Check credit limit'),
                  ),
                  const Gap(8),
                  Center(
                    child: Text(
                      'Minimum requirement to take a loan: ₹25,000 ',
                      style: baseTextStyle10400.copyWith(
                        color: const Color(0xFF9EA0A3),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        }
        if (state is LamfGetLoanDataSuccess) {
          final lamfLoanData = state.getLoanDataDetails;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Loan Against Mutual Funds',
                style: baseTextStyle16500,
              ),
              const Gap(24),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: LamfBannerTotal(
                        cashSanctioned: lamfLoanData.creditLimit,
                        cashWithdrawn: lamfLoanData.cashWithdrawn,
                        cashAvailable: lamfLoanData.cashAvailable),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LamfBanner(
                          title: 'Credit limit',
                          value: lamfLoanData.creditLimit,
                          small: true,
                        ),
                        const Gap(8),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const PledgedMFsScreen()));
                          },
                          child: LamfBanner(
                            title: 'Pledged MFs',
                            value: lamfLoanData.pledgedCount.toDouble(),
                            small: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(28),
              Row(
                children: [
                  Expanded(
                    child: BlocConsumer<LamfInitiatePaymentCubit,
                        LamfInitiatePaymentState>(
                      listener: (context, state) async {
                        if (state is LamfInitiatePaymentFailure) {
                          Utils.showErrorAlert(context,
                              state.errorMessage ?? 'Something went wrong');
                        }
                        if (state is LamfInitiatePaymentSuccess) {
                          try {
                            await callRepaySDK(
                              state.initiatePaymentDetails.interactionToken,
                            );
                            if (context.mounted) {
                              Utils.showSuccessAlert(
                                context,
                                'Request accepted',
                              );
                            }
                          } on ScLoanError catch (e) {
                            if (context.mounted) {
                              Utils.showErrorAlert(
                                context,
                                '${e.message} \n ${e.code} \n ${e.data} ',
                                duration: 10,
                                barrierDismissible: true,
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              Utils.showErrorAlert(
                                context,
                                'Something went wrong',
                              );
                            }
                          }
                        }
                      },
                      builder: (context, state) => ElevatedButton(
                        onPressed: () async {
                          context
                              .read<LamfInitiatePaymentCubit>()
                              .initiatePayment();
                        },
                        child: (state is LamfInitiatePaymentLoading)
                            ? const Center(
                                child: SizedBox(
                                    height: 20.0,
                                    width: 20.0,
                                    child: CustomLoader(color: Colors.white)))
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Assets.pngs.repay
                                      .image(height: 24.0, width: 24.0),
                                  const Gap(8.0),
                                  Text('Repay',
                                      style: baseTextStyle14500.copyWith(
                                          color: Colors.white)),
                                ],
                              ),
                      ),
                    ),
                  ),
                  const Gap(20.0),
                  Expanded(
                    child: BlocConsumer<LamfInitiateWithdrawalCubit,
                        LamfInitiateWithdrawalState>(
                      listener: (context, state) async {
                        if (state is LamfInitiateWithdrawalFailure) {
                          Utils.showErrorAlert(context,
                              state.errorMessage ?? 'Something went wrong');
                        }
                        if (state is LamfInitiateWithdrawalSuccess) {
                          try {
                            await callWithdrawSDK(
                              state.initiateWithdrawalDetails.interactionToken,
                            );
                            if (context.mounted) {
                              Utils.showSuccessAlert(
                                  context, 'Request accepted');
                            }
                          } on ScLoanError catch (e) {
                            if (context.mounted) {
                              Utils.showErrorAlert(
                                context,
                                '${e.message} \n ${e.code} \n ${e.data} ',
                                duration: 10,
                                barrierDismissible: true,
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              Utils.showErrorAlert(
                                context,
                                'Something went wrong',
                              );
                            }
                          }
                        }
                      },
                      builder: (context, state) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF12C863)),
                        onPressed: () async {
                          context
                              .read<LamfInitiateWithdrawalCubit>()
                              .initiateWithdrawal();
                        },
                        child: (state is LamfInitiateWithdrawalLoading)
                            ? const Center(
                                child: SizedBox(
                                    height: 20.0,
                                    width: 20.0,
                                    child: CustomLoader(color: Colors.white)))
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Assets.pngs.withdraw
                                      .image(height: 24.0, width: 24.0),
                                  const Gap(8.0),
                                  Text(
                                    'Withdraw',
                                    style: baseTextStyle14500.copyWith(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AllTransactionScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Transactions'),
                    Text(
                      'View all',
                      style: baseTextStyle12500.copyWith(
                          color: const Color(0xFF2E8EFF)),
                    )
                  ],
                ),
              ),
              const Gap(16),
              Column(
                children: [
                  for (int i = 0; i < lamfLoanData.transactions.length; i++)
                    lamfLoanData.transactions[i].amount < 0
                        ? negativeTransaction(
                            lamfLoanData.transactions[i].description,
                            lamfLoanData.transactions[i].date,
                            lamfLoanData.transactions[i].amount)
                        : positiveTransaction(
                            lamfLoanData.transactions[i].description,
                            lamfLoanData.transactions[i].date,
                            lamfLoanData.transactions[i].amount),
                ],
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
