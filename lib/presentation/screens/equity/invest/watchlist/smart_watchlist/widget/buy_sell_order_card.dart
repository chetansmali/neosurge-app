import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../../common/custom_styles.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../../widgets/amount_widget.dart';

class BuySellOrderCard extends StatelessWidget {
  final String symbol;
  final int qty;
  final double close;
  final String companyName;
  final DateTime date;
  final String type;

  const BuySellOrderCard({
    super.key,
    required this.symbol,
    required this.qty,
    required this.close,
    required this.companyName,
    required this.date,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              symbol,
                              style: baseTextStyle14500,
                            ),
                            const Gap(8),
                            Container(
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(
                                color: AppColors.textGrey,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            const Gap(8),
                            Text(
                              qty.toString(),
                              style: baseTextStyle12500.copyWith(
                                  color: AppColors.textGrey),
                            )
                          ],
                        ),
                      ),
                      AmountWidget(
                        amount: close,
                        style: baseTextStyle14500.copyWith(
                            color: type == 'buy'
                                ? AppColors.green
                                : AppColors.errorRed),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        companyName,
                        style: baseTextStyle12400,
                      ),
                      Text(
                        _dateTime(),
                        style: baseTextStyle10400,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _dateTime() {
    int milliseconds = date.millisecondsSinceEpoch;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String formattedDate =
        "${_getMonth(dateTime.month)} ${dateTime.day}, ${dateTime.year}";
    return formattedDate;
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }
}
