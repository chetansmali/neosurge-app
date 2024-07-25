import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../cubits/assisted_service/assited_holdings_cubit/assisted_holdings_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/investment_returns/investment_returns_cubit.dart';
import '../../../cubits/mutual_funds/mf_user_holdings/mf_user_holdings_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/empty_portfolio_view.dart';
import '../../../widgets/widgets.dart';

class MFPortfolioInfoCard extends StatelessWidget {
  final bool isAssisted;

  const  MFPortfolioInfoCard({Key? key, this.isAssisted = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isAssisted ? const _AssistedCard() : const _NonAssistedCard();
  }
}

class _NonAssistedCard extends HookWidget {
  const _NonAssistedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inrFormatter = useMemoized(() => NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 2));
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverToBoxAdapter(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: BlocBuilder<MfUserHoldingsCubit, MfUserHoldingsState>(
              builder: (context, state) {
                if (state is MfUserHoldingsLoading) {
                  return CustomShimmer(
                    child: Column(
                      children: [
                        const Gap(10),
                        Text(
                          inrFormatter.format(0),
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                        const Gap(30),
                        Row(
                          children: [
                            Expanded(
                                child: TwoColText(
                              title: 'Invested Amount',
                              subtitle: inrFormatter.format(0),
                              subtitleStyle: const TextStyle(fontSize: 11, color: AppColors.green),
                            )),
                            const Gap(20),
                            Expanded(
                                child: TwoColText(
                              title: 'Total Returns',
                              subtitle: '${inrFormatter.format(0)} (0 %)',
                              subtitleStyle: const TextStyle(fontSize: 11, color: AppColors.green),
                            )),
                          ],
                        ),
                        const Gap(20),
                      ],
                    ),
                  );
                }
                if (state is MfUserHoldingsError) {
                  return AppErrorWidget(
                    errorType: state.errorType,
                    error: state.error,
                    onRetry: () => context.read<InvestmentReturnsCubit>().fetchInvestmentReturns(userId: context.read<AuthCubit>().state.user!.id),
                  );
                }
                if (state is MfUserHoldingsLoaded) {
                  if (state.userMfHoldings == null) {
                    return const EmptyPortfolioView();
                  }
                  final iR = state.userMfHoldings!;
                  return Column(
                    children: [
                      const Gap(10),
                      Text(
                        inrFormatter.format(iR.currentValue),
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                      ),
                      const Gap(30),
                      Row(
                        children: [
                          Expanded(
                              child: TwoColText(
                            title: 'Invested Amount',
                            subtitle: inrFormatter.format(iR.investedValue),
                            subtitleStyle: const TextStyle(
                              fontSize: 11,
                            ),
                          )),
                          const Gap(20),
                          Expanded(
                              child: TwoColText(
                            title: 'Total Returns',
                            subtitle: '${iR.totalReturns > 0 ? '+ ' : ''}${inrFormatter.format(iR.totalReturns)} (${iR.returnsPercentage.toStringAsFixed(2)} %)',
                            subtitleStyle: TextStyle(
                                fontSize: 11,
                                color: iR.totalReturns < 0
                                    ? AppColors.textRed
                                    : iR.totalReturns == 0
                                        ? AppColors.mainBlack
                                        : AppColors.green),
                          )),
                        ],
                      ),
                      const Gap(20),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _AssistedCard extends HookWidget {
  const _AssistedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inrFormatter = useMemoized(() => NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 2));
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverToBoxAdapter(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: BlocBuilder<AssistedHoldingsCubit, AssistedHoldingsState>(
              builder: (context, state) {
                if (state is AssistedHoldingsLoading) {
                  return CustomShimmer(
                    child: Column(
                      children: [
                        const Gap(10),
                        Text(
                          inrFormatter.format(0),
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                        const Gap(30),
                        Row(
                          children: [
                            Expanded(
                                child: TwoColText(
                              title: 'Invested Amount',
                              subtitle: inrFormatter.format(0),
                              subtitleStyle: const TextStyle(fontSize: 11, color: AppColors.green),
                            )),
                            const Gap(20),
                            Expanded(
                                child: TwoColText(
                              title: 'Total Returns',
                              subtitle: '${inrFormatter.format(0)} (0 %)',
                              subtitleStyle: const TextStyle(fontSize: 11, color: AppColors.green),
                            )),
                          ],
                        ),
                        const Gap(20),
                      ],
                    ),
                  );
                }
                if (state is AssistedHoldingsError) {
                  return AppErrorWidget(
                    errorType: state.errorType,
                    error: state.error,
                    onRetry: () => context.read<InvestmentReturnsCubit>().fetchInvestmentReturns(userId: context.read<AuthCubit>().state.user!.id),
                  );
                }
                if (state is AssistedHoldingsLoaded) {
                  if (state.userMfHoldings == null) {
                    return const EmptyPortfolioView();
                  }
                  final iR = state.userMfHoldings!;
                  return Column(
                    children: [
                      const Gap(10),
                      Text(
                        inrFormatter.format(iR.currentValue),
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                      ),
                      const Gap(30),
                      Row(
                        children: [
                          Expanded(
                              child: TwoColText(
                            title: 'Invested Amount',
                            subtitle: inrFormatter.format(iR.investedValue),
                            subtitleStyle: const TextStyle(
                              fontSize: 11,
                            ),
                          )),
                          const Gap(20),
                          Expanded(
                              child: TwoColText(
                            title: 'Total Returns',
                            subtitle: '${iR.totalReturns > 0 ? '+ ' : ''}${inrFormatter.format(iR.totalReturns)} (${iR.returnsPercentage.toStringAsFixed(2)} %)',
                            subtitleStyle: TextStyle(
                                fontSize: 11,
                                color: iR.totalReturns < 0
                                    ? AppColors.textRed
                                    : iR.totalReturns == 0
                                        ? AppColors.mainBlack
                                        : AppColors.green),
                          )),
                        ],
                      ),
                      const Gap(20),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
