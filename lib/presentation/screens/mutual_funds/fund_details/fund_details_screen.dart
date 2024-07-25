import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/mutual_funds/fund.dart';
import '../../../../data/models/mutual_funds/fund_detail.dart';
import '../../../../data/models/user/user.dart';
import '../../../../di/get_it.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/all_funds/all_funds_cubit.dart';
import '../../../cubits/mutual_funds/fp_fund_details/fp_fund_details_cubit.dart';
import '../../../cubits/mutual_funds/fund_details/fund_details_cubit.dart';
import '../../../cubits/mutual_funds/fund_holdings/fund_holdings_cubit.dart';
import '../../../cubits/mutual_funds/get_fund/get_fund_cubit.dart';
import '../../../cubits/mutual_funds/holding_analysis/holding_analysis_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_shimmer.dart';
import '../widgets/alternative_funds_widget.dart';
import '../widgets/holding_analysis_widget.dart';
import '../widgets/holdings_widget.dart';
import '../widgets/mf_chart_widget.dart';
import '../widgets/returns_calculator_widget.dart';
import 'fund_card.dart';

class FundDetailsScreen extends HookWidget {
  // final Fund fund;

  const FundDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<GetFundCubit, GetFundState>(
          builder: (context, state) {
            if (state is GetFundLoaded) {
              final fund = state.fund;
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: BlocBuilder<FundDetailsCubit, FundDetailsState>(
                  builder: (context, state) {
                    if (state is FundDetailsLoading) {
                      return CustomShimmer(
                        child: _RowButton(fund: fund),
                      );
                    }
                    if (state is FundDetailsLoaded) {
                      return _RowButton(
                        fund: fund,
                        fundDetail: state.fundDetail,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      appBar: AppBar(
        title: const Text('Fund Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<GetFundCubit, GetFundState>(
          listener: (context, state) {
            if (state is GetFundLoaded) {
              context.read<FpFundDetailsCubit>().fetchFpFundDetails(
                    isin: state.fund.isin,
                  );
            }
          },
          builder: (context, state) {
            if (state is GetFundLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (state is GetFundLoadFailure) {
              return AppErrorWidget(
                errorType: state.errorType,
                error: state.error,
              );
            }

            if (state is GetFundLoaded) {
              final fund = state.fund;
              return Column(
                children: [
                  FundCard(fund: fund),
                  Expanded(
                    child: SlidingUpPanel(
                      panelBuilder: (sc) {
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  height: 4,
                                  width: 68,
                                  decoration: BoxDecoration(
                                    color: AppColors.neutral[50],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                controller: sc,
                                child: Column(
                                  children: [
                                    _FundDetailsCard(
                                      fund: fund,
                                    ),
                                    BlocBuilder<FundDetailsCubit,
                                            FundDetailsState>(
                                        builder: (context, state) {
                                      if (state is FundDetailsLoaded) {
                                        return Column(
                                          children: [
                                            if (fund.performance.oneY != 0.0 ||
                                                fund.performance.threeY !=
                                                    0.0) ...[
                                              ReturnsCalculatorWidget(
                                                fund: fund,
                                              ),
                                            ],
                                            BlocProvider(
                                              create: (context) =>
                                                  getIt<HoldingAnalysisCubit>()
                                                    ..getHoldingAnalysis(
                                                      schemeCode:
                                                          fund.schemeCode,
                                                    ),
                                              child: HoldingAnalysisWidget(
                                                schemeCode: fund.schemeCode,
                                                exitLoadRemarks:
                                                    fund.exitLoadPeriodRemark,
                                              ),
                                            ),
                                            BlocProvider(
                                              create: (context) =>
                                                  getIt<FundHoldingsCubit>()
                                                    ..getHoldings(
                                                      schemeCode:
                                                          fund.schemeCode,
                                                    ),
                                              child: HoldingsWidget(
                                                schemeCode: fund.schemeCode,
                                              ),
                                            ),
                                            BlocProvider(
                                              create: (context) =>
                                                  getIt<AllFundsCubit>()
                                                    ..getFunds(
                                                      assetSubCategory: [
                                                        state.fundDetail
                                                            .assetSubCategory
                                                      ],
                                                    ),
                                              child: AlternativeFundsWidget(
                                                fundDetail: state.fundDetail,
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                      if (state is FundDetailsLoading) {
                                        return Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            children: List.generate(
                                              4,
                                              (index) => const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15.0),
                                                child: CustomShimmer(
                                                  height: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      if (state is FundDetailsLoadFailure) {
                                        return AppErrorWidget(
                                          errorType: state.errorType,
                                          error: state.error,
                                          onRetry: () => context
                                              .read<FundDetailsCubit>()
                                              .getFundDetails(
                                                  schemeCode: fund.schemeCode),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    }),
                                    const Gap(100),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      parallaxEnabled: true,
                      body: MfChartWidget(schemeCode: fund.schemeCode),
                      minHeight: MediaQuery.of(context).size.height * 0.27,
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _RowButton extends StatelessWidget {
  final Fund fund;
  final FundDetail? fundDetail;

  const _RowButton({
    Key? key,
    required this.fund,
    this.fundDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<AuthCubit>().state.user!;
    return BlocConsumer<FpFundDetailsCubit, FpFundDetailsState>(
      listener: (context, fpState) {
        if (fpState is FpFundDetailsError) {
          Utils.showErrorAlert(
              context, fpState.error ?? 'something went wrong with Fp.');
        }
      },
      builder: (context, fpState) {
        if (fpState is FpFundDetailsError) {
          return Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: null,
                  style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            color: AppColors.lightGrey,
                            width: 1.5,
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          AppColors.lightGrey,
                        ),
                      ),
                  child: const Text('LUMPSUM'),
                ),
              ),
              const Gap(20),
              Expanded(
                child: OutlinedButton(
                  onPressed: null,
                  style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            color: AppColors.lightGrey,
                            width: 1.5,
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          AppColors.lightGrey,
                        ),
                      ),
                  child: const Text('MONTHLY SIP'),
                ),
              ),
            ],
          );
        }

        if (fpState is FpFundDetailsLoaded) {
          return Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                onPressed: () {
                  if (!user.eSignSubmitDone && !user.isOnBoardingCompleted) {
                    Fluttertoast.showToast(
                        msg: 'Please complete your kyc to start investing');
                    return;
                  } else if (!user.isOnBoardingCompleted) {
                    Fluttertoast.showToast(
                        msg:
                            'Your kyc is under review. Once approved, you will be able to invest');
                    return;
                  }
                  Navigator.pushNamed(
                    context,
                    Routes.investLumpsum,
                    arguments: PurchaseFundArgs(
                      purchaseType: 'Lumpsum',
                      fund: fund,
                      fundDetail: fundDetail!,
                      fpFundDetails: fpState.fpFundDetails,
                    ),
                  );
                },
                child: const Text('LUMPSUM'),
              )),
              if (fpState.fpFundDetails.isSipAllowed!) ...[
                const Gap(20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (!user.eSignSubmitDone &&
                          !user.isOnBoardingCompleted) {
                        Fluttertoast.showToast(
                            msg: 'Please complete your kyc to start investing');
                        return;
                      } else if (!user.isOnBoardingCompleted) {
                        Fluttertoast.showToast(
                            msg:
                                'Your kyc is under review. Once approved, you will be able to invest');
                        return;
                      }
                      Navigator.pushNamed(
                        context,
                        Routes.investSIP,
                        arguments: PurchaseFundArgs(
                          purchaseType: 'SIP',
                          fund: fund,
                          fundDetail: fundDetail!,
                          fpFundDetails: fpState.fpFundDetails,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: null, maximumSize: null),
                    child: const Text(
                      'MONTHLY SIP',
                    ),
                  ),
                ),
              ],
            ],
          );
        }
        if (fpState is FpFundDetailsLoading) {
          return CustomShimmer(
            child: Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('LUMPSUM'),
                )),
                const Gap(20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: null, maximumSize: null, elevation: 0),
                    child: const Text(
                      'MONTHLY SIP',
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: null,
                child: Text('LUMPSUM'),
              ),
            ),
            Gap(20),
            Expanded(
              child: OutlinedButton(
                onPressed: null,
                child: Text('MONTHLY SIP'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FundDetailsCard extends StatelessWidget {
  final Fund fund;

  const _FundDetailsCard({Key? key, required this.fund}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 8.0,
      ),
      child: BlocBuilder<FundDetailsCubit, FundDetailsState>(
        builder: (context, state) {
          if (state is FundDetailsLoading) {
            return Column(
                children: List.generate(
              2,
              (index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomShimmer(
                      width: 100,
                      height: 20,
                    ),
                    CustomShimmer(
                      width: 100,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ));
          }
          if (state is FundDetailsLoaded) {
            final fundDetails = state.fundDetail;
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.alert[50],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(
                        fundDetails.assetSubCategory,
                        style: TextStyle(
                          color: AppColors.alert[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (fundDetails.riskProfile != null) ...[
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.error[50],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Text(
                          fundDetails.riskProfile!,
                          style: TextStyle(
                            color: AppColors.error[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                const Gap(32),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nav (${DateFormat('dd MMM yyyy').format(
                              fundDetails.navDate,
                            )})',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.neutral[300],
                            ),
                          ),
                          const Gap(2),
                          Text(
                            NumberFormat.currency(
                              locale: 'en_IN',
                              symbol: '₹',
                              decimalDigits: 2,
                            ).format(fundDetails.nav),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AUM',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.neutral[300],
                            ),
                          ),
                          const Gap(2),
                          AmountWidget(
                            amount: fundDetails.fundSize,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expense Ratio',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.neutral[300],
                            ),
                          ),
                          const Gap(2),
                          Text(
                            fundDetails.expenseRatio.toStringAsFixed(2),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Min. SIP',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.neutral[300],
                            ),
                          ),
                          const Gap(2),
                          AmountWidget(
                            amount: fundDetails.minSipAmount,
                            isCompact: false,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Min. Lumpsum',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.neutral[300],
                            ),
                          ),
                          const Gap(2),
                          AmountWidget(
                            amount: fundDetails.minInitialInvestment,
                            isCompact: false,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '5Y CAGR',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.neutral[300],
                            ),
                          ),
                          const Gap(2),
                          Text(
                            fundDetails.performance.fiveY.toStringAsFixed(2),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
