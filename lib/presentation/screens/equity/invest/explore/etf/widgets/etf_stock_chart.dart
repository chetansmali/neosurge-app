import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../common/common.dart';
import '../../../../../../../domain/entities/enums.dart';
import '../../../../../../cubits/equity/equity_explore/stock_chart_cubit.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../../widgets/amount_widget.dart';
import '../../../../../../widgets/widgets.dart';
import '../../../../component/stock_time_frame.dart';

class ETFStockChart extends StatelessWidget {
  final String sybName;
  const ETFStockChart({super.key, required this.sybName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<StockChartCubit, StockChartState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _onTap(EquityChartTimePeriod.oneDay, context),
                  child: StockTimeFrame(
                      title: '1D',
                      isSelected: state.equityTimePeriod ==
                          EquityChartTimePeriod.oneDay),
                ),
                GestureDetector(
                  onTap: () => _onTap(EquityChartTimePeriod.oneWeek, context),
                  child: StockTimeFrame(
                      title: '1W',
                      isSelected: state.equityTimePeriod ==
                          EquityChartTimePeriod.oneWeek),
                ),
                GestureDetector(
                  onTap: () => _onTap(EquityChartTimePeriod.oneMonth, context),
                  child: StockTimeFrame(
                      title: '1M',
                      isSelected: state.equityTimePeriod ==
                          EquityChartTimePeriod.oneMonth),
                ),
                GestureDetector(
                  onTap: () => _onTap(EquityChartTimePeriod.oneYear, context),
                  child: StockTimeFrame(
                      title: '1Y',
                      isSelected: state.equityTimePeriod ==
                          EquityChartTimePeriod.oneYear),
                ),
                GestureDetector(
                  onTap: () => _onTap(EquityChartTimePeriod.fiveYear, context),
                  child: StockTimeFrame(
                      title: '5Y',
                      isSelected: state.equityTimePeriod ==
                          EquityChartTimePeriod.fiveYear),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary[50],
                    borderRadius: BorderRadius.circular(70),
                    border: Border.all(
                      color: AppColors.primary[500]!,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 13.0, right: 13, top: 4, bottom: 4),
                    child: Text(
                      'BSE',
                      style: baseTextStyle12700.copyWith(
                          color: AppColors.primaryColor),
                    ),
                  ),
                )
              ],
            );
          },
        ),
        const Gap(24),
        SizedBox(
          height: 200.0,
          child: BlocBuilder<StockChartCubit, StockChartState>(
            buildWhen: (previous, current) => current is! StockChartLoading,
            builder: (context, state) {
              {
                if (state is StockChartLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is StockChartFailure) {
                  return AppErrorWidget(
                    errorType: state.errorType,
                    error: state.errorMessage,
                    onRetry: () => context.read<StockChartCubit>()
                      ..fetchChartData(EquityChartTimePeriod.oneDay, sybName),
                  );
                }
                if (state is StockChartSuccess) {
                  return LineChart(
                    LineChartData(
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            width: 1, color: AppColors.primary[100]!),
                      ),
                      gridData: const FlGridData(show: false),
                      backgroundColor: AppColors.primary[50],
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value == meta.max || value == meta.min) {
                                return const SizedBox.shrink();
                              }

                              var date = DateTime.fromMillisecondsSinceEpoch(
                                value.toInt(),
                              );

                              String dateFormat = 'dd MMM';

                              if (state.equityTimePeriod ==
                                  EquityChartTimePeriod.oneDay) {
                                dateFormat = 'HH:mm';
                              } else if (state.equityTimePeriod ==
                                  EquityChartTimePeriod.oneWeek) {
                                dateFormat = 'EEE';
                              } else if (state.equityTimePeriod ==
                                  EquityChartTimePeriod.oneMonth) {
                                dateFormat = 'dd MMM';
                              } else if (state.equityTimePeriod ==
                                  EquityChartTimePeriod.oneYear) {
                                dateFormat = 'MMM yy';
                              } else {
                                dateFormat = 'yyyy';
                              }

                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  state.equityTimePeriod ==
                                          EquityChartTimePeriod.oneWeek
                                      ? DateFormat(dateFormat).format(
                                          state.dates[value.toInt()],
                                        )
                                      : DateFormat(dateFormat).format(date),
                                  style: baseTextStyle10500.copyWith(
                                      color: AppColors.neutral[400]),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 42,
                            getTitlesWidget: (value, meta) {
                              if (value == meta.max || value == meta.min) {
                                return const SizedBox.shrink();
                              }

                              return AmountWidget(
                                amount: value,
                                style: baseTextStyle10400.copyWith(
                                  color: AppColors.neutral[500],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          tooltipBorder:
                              const BorderSide(color: AppColors.primaryColor),
                          fitInsideHorizontally: true,
                          tooltipHorizontalAlignment:
                              FLHorizontalAlignment.right,
                          tooltipBgColor: Colors.white,
                          tooltipPadding: const EdgeInsets.all(8),
                          tooltipRoundedRadius: 30,
                          getTooltipItems: (List<LineBarSpot> touchedSpots) {
                            List<LineTooltipItem> items = [
                              LineTooltipItem(
                                NumberFormat.currency(
                                  locale: 'en_IN',
                                  symbol: '₹ ',
                                  decimalDigits: 2,
                                ).format(
                                  touchedSpots[0].y,
                                ),
                                GoogleFonts.hind(
                                  color: AppColors.textLightGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: _getLineToolTip(
                                      state,
                                      state.equityTimePeriod,
                                      touchedSpots[0].spotIndex,
                                    ),
                                    style: baseTextStyle12500,
                                  ),
                                ],
                              ),
                            ];
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
                          // shadow: Shadow(
                          //   blurRadius: 10.0,
                          //   color: AppColors.primaryColor.withOpacity(0.2),
                          // ),
                          isCurved: true,
                          preventCurveOverShooting: true,
                          color: AppColors.primaryColor,
                          dotData: const FlDotData(show: false),
                          spots: state.stockChartData,
                        ),
                      ],
                    ),
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 500),
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  void _onTap(EquityChartTimePeriod timePeriod, BuildContext context) {
    HapticFeedback.selectionClick();
    context.read<StockChartCubit>().fetchChartData(timePeriod, sybName);
  }

  String? _getLineToolTip(
    StockChartSuccess state,
    EquityChartTimePeriod timePeriod,
    int spotIndex,
  ) {
    if (timePeriod == EquityChartTimePeriod.oneDay) {
      return ' • Today, ${DateFormat.jm().format(state.dates[spotIndex])}';
    } else if (timePeriod == EquityChartTimePeriod.oneWeek) {
      return ' • ${DateFormat('MMM dd, HH:mm a').format(state.dates[spotIndex])}';
    } else if (timePeriod == EquityChartTimePeriod.oneMonth) {
      return ' • ${DateFormat('MMM dd').format(state.dates[spotIndex])}';
    } else if (timePeriod == EquityChartTimePeriod.oneYear) {
      return ' • ${DateFormat('MMM dd, yyyy').format(state.dates[spotIndex])}';
    } else if (timePeriod == EquityChartTimePeriod.fiveYear) {
      return ' • ${DateFormat('MMM, yyyy').format(state.dates[spotIndex])}';
    }

    return null;
  }
}
