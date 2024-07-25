import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../common/custom_styles.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../../widgets/amount_widget.dart';

class SmartWatchlistChart extends StatefulWidget {
  final List<LineChartBarData> lineBarsData;
  final LineChartBarData tooltipsOnBar;
  final List<int> spotIndexies;
  final double avgValue;
  final List<DateTime> dateIndex;

  const SmartWatchlistChart({
    super.key,
    required this.lineBarsData,
    required this.dateIndex,
    required this.tooltipsOnBar,
    required this.spotIndexies,
    required this.avgValue,
  });

  @override
  State<SmartWatchlistChart> createState() => _SmartWatchlistChartState();
}

class _SmartWatchlistChartState extends State<SmartWatchlistChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(
              show: true,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary[100]!,
                  width: 1,
                ),
                left: BorderSide(
                  color: AppColors.primary[100]!,
                  width: 1,
                ),
                right: BorderSide(
                  color: AppColors.primary[100]!,
                  width: 1,
                ),
                top: BorderSide(
                  color: AppColors.primary[100]!,
                  width: 1,
                ),
              ),
            ),
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value == meta.max || value == meta.min) {
                      return const SizedBox.shrink();
                    }

                    var date = widget.dateIndex[value.toInt()];
                    String dateFormat = 'MMM';

                    return Text(
                      DateFormat(dateFormat).format(date),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: AppColors.neutral[400],
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    if (value == meta.max || value == meta.min) {
                      return const SizedBox.shrink();
                    }

                    return AmountWidget(
                      amount: value,
                      style: baseTextStyle12700.copyWith(
                        color: AppColors.neutral[400],
                        fontSize: 10,
                      ),
                    );
                  },
                ),
              ),
            ),
            extraLinesData: ExtraLinesData(
              horizontalLines: [
                HorizontalLine(
                  y: widget.avgValue,
                  color: AppColors.primaryColor.withOpacity(0.5),
                  strokeWidth: 1,
                  dashArray: [5, 2],
                  label: HorizontalLineLabel(
                    alignment: Alignment.centerRight,
                    show: true,
                    style:
                        baseTextStyle10400.copyWith(color: AppColors.mainBlack),
                    labelResolver: (line) => 'Avg.price ${widget.avgValue} ',
                  ),
                )
              ],
            ),
            lineTouchData: LineTouchData(
              enabled: true,
              getTouchedSpotIndicator: (barData, spotIndexes) {
                return spotIndexes.map((spotIndex) {
                  if (widget.spotIndexies.contains(spotIndex)) {
                    return TouchedSpotIndicatorData(
                      FlLine(
                        color: AppColors.primary[100]!,
                        strokeWidth: 1,
                      ),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 5,
                            color: AppColors.primaryColor,
                            strokeWidth: 2,
                            strokeColor: AppColors.textGrey,
                          );
                        },
                      ),
                    );
                  } else {
                    return TouchedSpotIndicatorData(
                      FlLine(
                        color: AppColors.primary[100]!,
                        strokeWidth: 1,
                      ),
                      const FlDotData(
                        show: false,
                      ),
                    );
                  }
                }).toList();
              },
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                tooltipRoundedRadius: 20,
                tooltipPadding: const EdgeInsets.all(5),
                tooltipBorder: const BorderSide(
                    color: AppColors.primaryColor, style: BorderStyle.solid),
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    final flSpot = barSpot;
                    if (!widget.spotIndexies.contains(flSpot.x.toInt())) {
                      return null;
                    }
                    return LineTooltipItem(
                      flSpot.y.toStringAsFixed(2),
                      const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.transparent),
                      textAlign: TextAlign.center,
                    );
                  }).toList();
                },
              ),
              getTouchLineEnd: (barData, spotIndex) {
                return barData.spots[spotIndex].y;
              },
              getTouchLineStart: (barData, spotIndex) {
                return barData.spots[spotIndex].y;
              },
            ),
            lineBarsData: widget.lineBarsData,
          ),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }
}
