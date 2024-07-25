import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../common/utils.dart';
import '../../../theme/app_colors.dart';

class PortfolioCard extends StatefulWidget {
  final double invested;
  final double current;
  final double returns;
  final double percentageReturn;

  const PortfolioCard(
      {super.key,
      required this.invested,
      required this.current,
      required this.returns,
      required this.percentageReturn});

  @override
  State<PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Current',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Gap(8),
                Text(
                  '(as on ${DateFormat('dd MMM yyyy').format(DateTime.now())})',
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textLightGrey),
                ),
              ],
            ),
            Text(
              Utils.compactCurrency(widget.current),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            _buildInvestedAndReturn(
                'Invested',
                Utils.compactCurrency(widget.invested),
                'Returns',
                widget.returns.toStringAsFixed(2))
          ],
        ),
      ),
    );
  }

  Widget _buildInvestedAndReturn(
    String titleOne,
    String valueOne,
    String titleTwo,
    String valueTwo,
  ) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleOne,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              valueOne,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        const Gap(32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleTwo,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Text(
                  valueTwo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.green,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: widget.percentageReturn < 0
                        ? AppColors.textRed.withOpacity(
                            0.1,
                          )
                        : AppColors.green.withOpacity(
                            0.1,
                          ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.percentageReturn.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: widget.percentageReturn < 0
                              ? AppColors.textRed
                              : AppColors.green,
                        ),
                      ),
                      const Gap(6),
                      Icon(
                        widget.percentageReturn < 0
                            ? CupertinoIcons.arrowtriangle_down_fill
                            : CupertinoIcons.arrowtriangle_up_fill,
                        size: 12,
                        color: widget.percentageReturn < 0
                            ? AppColors.textRed
                            : AppColors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
