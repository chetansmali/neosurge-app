import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../data/models/mutual_funds/fund.dart';
import '../../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../cubits/mutual_funds/mf_transactions/mf_transactions_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import 'widgets/mf_transaction_card.dart';

class FundTransactionScreen extends StatelessWidget {
  final UserMfScheme scheme;
  final Fund fund;

  const FundTransactionScreen(
      {Key? key, required this.scheme, required this.fund})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fund Transactions'),
      ),
      body: BlocBuilder<MfTransactionsCubit, MfTransactionsState>(
        builder: (context, state) {
          if (state is MfTransactionsLoading) {
            return const Center(child: CustomLoader());
          }
          if (state is MfTransactionsError) {
            return Center(
              child: AppErrorWidget(
                  errorType: state.errorType,
                  error: state.errorMessage,
                  onRetry: () => context
                      .read<MfTransactionsCubit>()
                      .fetchMfTransactions(
                          isin: scheme.isin, folioNumber: scheme.folioNumber)),
            );
          }
          if (state is MfTransactionsLoaded) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CurrentInvestmentFundCard(
                            scheme: scheme,
                            fund: fund,
                            avgNav: state.mfTransaction.avgNav),
                        const Gap(20),
                        _CurrentInvestmentInfo(scheme: scheme),
                        const Gap(30),
                        const Text('TRANSACTION HISTORY',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textGreySilver)),
                      ],
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => MFTransactionCard(
                            transaction:
                                state.mfTransaction.transactionHistory[index]),
                        childCount:
                            state.mfTransaction.transactionHistory.length)),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _TwoColText extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? valueStyle;

  const _TwoColText(
      {Key? key, required this.title, required this.value, this.valueStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: AppColors.textGreySilver),
        ),
        const Gap(20),
        Text(
          value,
          style: valueStyle ??
              const TextStyle(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

class _CurrentInvestmentInfo extends HookWidget {
  final UserMfScheme scheme;

  const _CurrentInvestmentInfo({Key? key, required this.scheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inrFormatter = useMemoized(() =>
        NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 2));
    return Row(
      children: [
        Expanded(
          child: _TwoColText(
            title: 'Invested',
            value: inrFormatter.format(scheme.investedAmount),
          ),
        ),
        Expanded(
          child: _TwoColText(
            title: 'Current',
            value: inrFormatter.format(scheme.currentValue),
          ),
        ),
        Expanded(
          child: _TwoColText(
            title: 'Returns',
            value: inrFormatter.format(scheme.returns),
            valueStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color:
                    scheme.returns > 0 ? AppColors.green : AppColors.textRed),
          ),
        )
      ],
    );
  }
}

class _CurrentInvestmentFundCard extends StatelessWidget {
  final UserMfScheme scheme;
  final Fund fund;
  final double avgNav;

  const _CurrentInvestmentFundCard(
      {Key? key,
      required this.scheme,
      required this.fund,
      required this.avgNav})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              onTap: () => Navigator.pushNamed(
                context,
                Routes.detailedFundView,
                arguments: DetailedFundViewArgs(schemeCode: fund.schemeCode),
              ),
              title: Text(
                scheme.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.primaryColor),
              ),
              dense: true,
              trailing: const Icon(
                Icons.chevron_right,
              ),
            ),
            const Gap(10),
            const Divider(),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _FundInfoText(
                          title: 'Current Nav',
                          value: scheme.nav.toStringAsFixed(2)),
                      const Gap(20),
                      _FundInfoText(
                          title: 'Avg Nav', value: avgNav.toStringAsFixed(2)),
                    ],
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: Column(
                    children: [
                      _FundInfoText(
                          title: 'Folio No.', value: scheme.folioNumber),
                      const Gap(20),
                      _FundInfoText(
                          title: 'Units',
                          value: scheme.holdingUnits.toString()),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _FundInfoText extends StatelessWidget {
  final String title;
  final String value;

  const _FundInfoText({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style:
                const TextStyle(color: AppColors.textGreySilver, fontSize: 12),
          ),
        ),
        const Gap(10),
        Text(
          value,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
