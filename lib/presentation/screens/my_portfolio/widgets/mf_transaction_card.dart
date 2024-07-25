import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/mutual_funds/mf_transaction.dart';
import '../../../theme/app_colors.dart';

class MFTransactionCard extends HookWidget {
  final TransactionHistory transaction;

  const MFTransactionCard({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inrFormatter = useMemoized(() => NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 2));
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.textGreySilver, width: 0.5))),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.type.toString(),
                  style: _textStyle,
                ),
                const Gap(20),
                Text(DateFormat('dd MMM yyyy').format(transaction.tradedOn), style: _valueStyle),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Units',
                      style: _textStyle,
                    )),
                    Expanded(
                      child: Text(
                        transaction.units.toString(),
                        style: _valueStyle,
                      ),
                    )
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'NAV',
                      style: _textStyle,
                    )),
                    Expanded(
                      child: Text(
                        transaction.nav.toStringAsFixed(4),
                        style: _valueStyle,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  inrFormatter.format(transaction.amount),
                  style: _valueStyle,
                ),
                const Gap(20),
                Text(
                  'Completed',
                  style: _textStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _textStyle => const TextStyle(
        fontSize: 12,
        color: AppColors.textGreySilver,
      );

  TextStyle get _valueStyle => const TextStyle(
        fontSize: 12,
      );
}
