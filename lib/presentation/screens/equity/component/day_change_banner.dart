import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../common/common.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';

class DayChangeBanner extends StatefulWidget {
  final String name;
  final double close;
  final double? day;
  final double? dayPercentage;
  final double? week;
  final double? weekPercentage;
  final double? month;
  final double? monthPercentage;
  final double? year;
  final double? yearPercentage;
  const DayChangeBanner(
      {super.key,
      required this.name,
      required this.close,
      required this.day,
      required this.week,
      required this.month,
      required this.year,
      required this.dayPercentage,
      required this.weekPercentage,
      required this.monthPercentage,
      required this.yearPercentage});

  @override
  State<DayChangeBanner> createState() => _DayChangeBannerState();
}

class _DayChangeBannerState extends State<DayChangeBanner> {
  EquityExploreBannerTimePeriod currentTimePeriod =
      EquityExploreBannerTimePeriod.daily;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGrey.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: baseTextStyle14500.copyWith(
                      color: AppColors.textLightGrey),
                ),
                const Gap(55),
                Row(
                  children: [
                    InkWell(
                      child: Assets.icons.dayChangeIcon
                          .image(height: 16, width: 16),
                      onTap: () {
                        if (currentTimePeriod ==
                            EquityExploreBannerTimePeriod.daily) {
                          setState(() {
                            currentTimePeriod =
                                EquityExploreBannerTimePeriod.weekly;
                          });
                        } else if (currentTimePeriod ==
                            EquityExploreBannerTimePeriod.weekly) {
                          setState(() {
                            currentTimePeriod =
                                EquityExploreBannerTimePeriod.monthly;
                          });
                        } else if (currentTimePeriod ==
                            EquityExploreBannerTimePeriod.monthly) {
                          setState(() {
                            currentTimePeriod =
                                EquityExploreBannerTimePeriod.yearly;
                          });
                        } else if (currentTimePeriod ==
                            EquityExploreBannerTimePeriod.yearly) {
                          setState(() {
                            currentTimePeriod =
                                EquityExploreBannerTimePeriod.daily;
                          });
                        }
                      },
                    ),
                    const Gap(8),
                    Text(
                      _getIndexFrame(),
                      style: baseTextStyle14500.copyWith(
                          color: AppColors.textLightGrey),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '₹${widget.close.toStringAsFixed(2)}',
                  style: baseTextStyle12400,
                ),
                const Gap(8),
                Row(
                  children: [
                    Text(
                      _getIndexchange()! > 0
                          ? '+${_getIndexchange()?.toStringAsFixed(2)}'
                          : '${_getIndexchange()?.toStringAsFixed(2)}',
                      style: baseTextStyle10400.copyWith(
                          color: _getIndexchange()! > 0
                              ? AppColors.green
                              : AppColors.green),
                    ),
                    const Gap(5),
                    Text(
                      '(${_getIndexPercentage()?.toStringAsFixed(2)}%)',
                      style: baseTextStyle10400.copyWith(
                          color: _getIndexPercentage()! > 0
                              ? AppColors.green
                              : AppColors.errorRed),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  double? _getIndexchange() {
    switch (currentTimePeriod) {
      case EquityExploreBannerTimePeriod.daily:
        return (widget.day);
      case EquityExploreBannerTimePeriod.weekly:
        return (widget.week);
      case EquityExploreBannerTimePeriod.monthly:
        return (widget.month);
      case EquityExploreBannerTimePeriod.yearly:
        return (widget.year);
    }
  }

  double? _getIndexPercentage() {
    switch (currentTimePeriod) {
      case EquityExploreBannerTimePeriod.daily:
        return (widget.dayPercentage);
      case EquityExploreBannerTimePeriod.weekly:
        return (widget.weekPercentage);
      case EquityExploreBannerTimePeriod.monthly:
        return (widget.monthPercentage);
      case EquityExploreBannerTimePeriod.yearly:
        return (widget.yearPercentage);
    }
  }

  String _getIndexFrame() {
    switch (currentTimePeriod) {
      case EquityExploreBannerTimePeriod.daily:
        return ('1D');
      case EquityExploreBannerTimePeriod.weekly:
        return ('1W');
      case EquityExploreBannerTimePeriod.monthly:
        return ('1M');
      case EquityExploreBannerTimePeriod.yearly:
        return ('1Y');
    }
  }
}
