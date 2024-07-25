import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../common/common.dart';
import '../../../../domain/entities/enums.dart';
import '../../../cubits/digital_gold/gold_chart_cubit/gold_chart_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/time_frame_select_widget.dart';

class GoldChart extends StatelessWidget {
  const GoldChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<GoldChartCubit, GoldChartState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _onTap(GoldSilverTimePeriod.sixMonth, context),
                  child: TimeFrameSelectWidget(
                    title: '6M',
                    isSelected: state.goldSilverTimePeriod ==
                        GoldSilverTimePeriod.sixMonth,
                    backgroundColor: AppColors.alert[100],
                    foregroundColor: AppColors.alert[700],
                  ),
                ),
                GestureDetector(
                  onTap: () => _onTap(GoldSilverTimePeriod.oneYear, context),
                  child: TimeFrameSelectWidget(
                    title: '1Y',
                    isSelected: state.goldSilverTimePeriod ==
                        GoldSilverTimePeriod.oneYear,
                    backgroundColor: AppColors.alert[100],
                    foregroundColor: AppColors.alert[700],
                  ),
                ),
                GestureDetector(
                  onTap: () => _onTap(GoldSilverTimePeriod.threeYear, context),
                  child: TimeFrameSelectWidget(
                    title: '3Y',
                    isSelected: state.goldSilverTimePeriod ==
                        GoldSilverTimePeriod.threeYear,
                    backgroundColor: AppColors.alert[100],
                    foregroundColor: AppColors.alert[700],
                  ),
                ),
                GestureDetector(
                  onTap: () => _onTap(GoldSilverTimePeriod.fiveYear, context),
                  child: TimeFrameSelectWidget(
                    title: '5Y',
                    isSelected: state.goldSilverTimePeriod ==
                        GoldSilverTimePeriod.fiveYear,
                    backgroundColor: AppColors.alert[100],
                    foregroundColor: AppColors.alert[700],
                  ),
                ),
                GestureDetector(
                  onTap: () => _onTap(GoldSilverTimePeriod.all, context),
                  child: TimeFrameSelectWidget(
                    title: 'All',
                    isSelected:
                        state.goldSilverTimePeriod == GoldSilverTimePeriod.all,
                    backgroundColor: AppColors.alert[100],
                    foregroundColor: AppColors.alert[700],
                  ),
                ),
              ],
            );
          },
        ),
        const Gap(16),
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 8.0, color: Colors.black.withOpacity(0.08))
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: BlocBuilder<GoldChartCubit, GoldChartState>(
            buildWhen: (previous, current) => current is! GoldChartLoading,
            builder: (context, state) {
              if (state is GoldChartLoading) {
                return const Center(
                    child: CustomLoader(
                  color: AppColors.yellowPrimary,
                ));
              }
              if (state is GoldChartLoaded) {
                return LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    clipData: const FlClipData.all(),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: state.dates.length / 5.0,
                          getTitlesWidget: (value, meta) {
                            if (value == meta.max || value == meta.min) {
                              return const SizedBox.shrink();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "${state.dates[value.toInt()].substring(3, 6)} "
                                "'${state.dates[value.toInt()].substring(9, 11)}",
                                style: baseTextStyle10500.copyWith(
                                    color: AppColors.neutral[400]),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 46,
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value == meta.max || value == meta.min) {
                              return const SizedBox.shrink();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: AmountWidget(
                                amount: value,
                                style: baseTextStyle10400.copyWith(
                                  color: AppColors.neutral[500],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBorder: const BorderSide(
                          color: AppColors.yellowPrimary,
                        ),
                        fitInsideHorizontally: true,
                        tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                        tooltipBgColor: Colors.white,
                        tooltipPadding: const EdgeInsets.all(8),
                        tooltipRoundedRadius: 12,
                        getTooltipItems: (List<LineBarSpot> touchedSpots) {
                          List<LineTooltipItem> items = List.generate(
                            touchedSpots.length,
                            (index) => LineTooltipItem(
                              NumberFormat.currency(
                                      locale: 'en_IN',
                                      symbol: '₹',
                                      decimalDigits: 2)
                                  .format(touchedSpots[index].y),
                              GoogleFonts.hind(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkYellow),
                              children: [
                                TextSpan(
                                  text:
                                      '\n${state.dates[touchedSpots[index].x.toInt()]}',
                                )
                              ],
                            ),
                          );
                          return items;
                        },
                      ),
                      getTouchedSpotIndicator:
                          (LineChartBarData barData, List<int> indicators) {
                        return indicators.map(
                          (int index) {
                            const line = FlLine(
                              color: Colors.grey,
                              strokeWidth: 2,
                              dashArray: [2, 4],
                            );
                            return const TouchedSpotIndicatorData(
                              line,
                              FlDotData(show: true),
                            );
                          },
                        ).toList();
                      },
                      getTouchLineEnd: (_, __) => double.infinity,
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        isStrokeCapRound: true,
                        isStrokeJoinRound: true,
                        shadow: const Shadow(
                          blurRadius: 8.0,
                          color: AppColors.yellowPrimary,
                        ),
                        isCurved: true,
                        preventCurveOverShooting: true,
                        color: AppColors.yellowPrimary,
                        dotData: const FlDotData(show: false),
                        spots: state.goldChartData,
                      ),
                    ],
                  ),
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 500),
                );
              }
              if (state is GoldChartLoadError) {
                return SingleChildScrollView(
                  child: AppErrorWidget(
                    errorType: state.errorType,
                    error: state.errorMessage,
                    onRetry: () => context
                        .read<GoldChartCubit>()
                        .fetchGoldData(GoldSilverTimePeriod.sixMonth),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  void _onTap(GoldSilverTimePeriod timePeriod, BuildContext context) {
    HapticFeedback.selectionClick();
    context.read<GoldChartCubit>().fetchGoldData(timePeriod);
  }
}
