import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';

class InvestAmountWidget extends StatelessWidget {
  final double amount;
  final TextEditingController amountController;

  const InvestAmountWidget({
    Key? key,
    required this.amount,
    required this.amountController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inrFormatter = NumberFormat.currency(
      locale: 'en_IN',
      decimalDigits: 0,
      symbol: '',
    );

    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      onTap: () {
        final double initialAmount = double.tryParse(
              amountController.text.replaceAll(
                ',',
                '',
              ),
            ) ??
            0;
        final double totalAmount = initialAmount + amount;
        amountController.text = inrFormatter.format(totalAmount);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary[500]!,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: AmountWidget(
          amount: amount,
          style: TextStyle(
            color: AppColors.primary[500]!,
          ),
          isCompact: false,
          isDecimal: false,
        ),
      ),
    );
  }
}
