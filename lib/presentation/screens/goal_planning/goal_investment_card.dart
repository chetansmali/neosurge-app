import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../theme/app_colors.dart';
import '../../widgets/amount_widget.dart';

class GoalInvestmentCard extends StatefulWidget {
  const GoalInvestmentCard({
    super.key,
    required this.schemeName,
    required this.image,
    required this.currentValue,
    required this.investedValue,
    required this.returnPercentage,
  });

  final String image;
  final String schemeName;
  final double currentValue;
  final double investedValue;
  final double? returnPercentage;

  @override
  State<GoalInvestmentCard> createState() => _GoalInvestmentCardState();
}

class _GoalInvestmentCardState extends State<GoalInvestmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.image.isNotEmpty) ...[
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    height: 48,
                    width: 48,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
              const Gap(10),
              Expanded(
                child: Text(
                  widget.schemeName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),
          const Divider(
            color: AppColors.lightGrey,
            thickness: 1,
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _GoalInvestCardTail(
                title: 'Invested value',
                value: widget.investedValue,
                isPersentage: false,
              ),
              _GoalInvestCardTail(
                title: 'Current Value',
                value: widget.currentValue,
                isPersentage: false,
              ),
              _GoalInvestCardTail(
                title: 'Returns',
                value: widget.returnPercentage ?? 0,
                isPersentage: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GoalInvestCardTail extends StatelessWidget {
  final String title;
  final double value;
  final bool isPersentage;
  const _GoalInvestCardTail(
      {required this.title, required this.value, required this.isPersentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFFB0B0B0),
          ),
        ),
        const Gap(2),
        isPersentage
            ? value > 0
                ? Text(
                    '${value.toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.green,
                    ),
                  )
                : Text(
                    '${value.toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.green,
                    ),
                  )
            : AmountWidget(
                amount: value,
                isCompact: false,
                isDecimal: false,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
      ],
    );
  }
}
