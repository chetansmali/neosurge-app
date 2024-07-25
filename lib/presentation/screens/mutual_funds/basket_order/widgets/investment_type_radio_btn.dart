import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../domain/entities/enums.dart';

class InvestmentTypeRadioButtons extends StatelessWidget {
  const InvestmentTypeRadioButtons({
    Key? key,
    required this.onSelect,
    required this.selectedInvestmentType,
    required this.value,
    required this.label,
  }) : super(key: key);

  final VoidCallback onSelect;
  final BasketInvestmentType value;
  final BasketInvestmentType selectedInvestmentType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Row(
        children: [
          Radio<BasketInvestmentType>.adaptive(
            value: value,
            groupValue: selectedInvestmentType,
            onChanged: null,
          ),
          const Gap(4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF47586E),
            ),
          ),
        ],
      ),
    );
  }
}
