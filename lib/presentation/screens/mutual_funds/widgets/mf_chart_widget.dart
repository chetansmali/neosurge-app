import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/enums.dart';
import '../../../cubits/mutual_funds/mf_chart/mf_chart_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/widgets.dart';

class MfChartWidget extends StatelessWidget {
  final String schemeCode;

  const MfChartWidget({Key? key, required this.schemeCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.28,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              BlocBuilder<MFChartCubit, MFChartState>(
                buildWhen: (previous, current) => current is! MFChartLoading,
                builder: (context, state) {
                  if (state is MFChartLoaded) {
                    return LineChart(
                      LineChartData(
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 30,
                              getTitlesWidget: (value, meta) {
                                if (value.toInt() == state.dates.length - 1) {
                                  return const SizedBox.shrink();
                                }

                                return Text(
                                  DateFormat('MMM').format(
                                    DateFormat('dd MMM yyyy').parse(
                                      state.dates[value.toInt()],
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: AppColors.neutral[400],
                                    fontSize: 10,
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              getTitlesWidget: (value, meta) {
                                if (value.round() == meta.min.round() ||
                                    value.round() == meta.max.round()) {
                                  return const SizedBox.shrink();
                                }

                                return Text(
                                  NumberFormat.currency(
                                    locale: 'en_IN',
                                    symbol: '₹',
                                    decimalDigits: 0,
                                  ).format(value),
                                  style: TextStyle(
                                    color: AppColors.neutral[400],
                                    fontSize: 10,
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                        ),
                        clipData: const FlClipData(
                          top: false,
                          bottom: false,
                          left: false,
                          right: false,
                        ),
                        lineTouchData: LineTouchData(
                          getTouchLineEnd: (_, __) => 0,
                          getTouchedSpotIndicator: (barData, spotIndexes) =>
                              spotIndexes.map(
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
                          ).toList(),
                          touchTooltipData: LineTouchTooltipData(
                            fitInsideHorizontally: true,
                            tooltipBgColor: Colors.white70,
                            tooltipPadding: const EdgeInsets.all(8),
                            tooltipRoundedRadius: 4,
                            getTooltipItems: (List<LineBarSpot> touchedSpots) {
                              List<LineTooltipItem> items = List.generate(
                                touchedSpots.length,
                                (index) => LineTooltipItem(
                                  NumberFormat.currency(
                                    locale: 'en_IN',
                                    symbol: '₹',
                                    decimalDigits: 2,
                                  ).format(touchedSpots[index].y),
                                  const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
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
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: false,
                            color: AppColors.primaryColor,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFFBFD1FD),
                                  const Color(0xFFBFD1FD).withOpacity(0),
                                ],
                              ),
                            ),
                            aboveBarData: BarAreaData(show: false),
                            dotData: const FlDotData(show: false),
                            preventCurveOverShooting: true,
                            spots: state.mfChartData,
                          )
                        ],
                      ),
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500),
                    );
                  }
                  if (state is MfChartLoadError) {
                    return Center(
                        child: AppErrorWidget(
                      errorType: state.errorType,
                      error: state.errorMessage,
                      onRetry: () => context
                          .read<MFChartCubit>()
                          .fetchMFChartData(
                              MutualFundTimePeriod.sixMonth, schemeCode),
                    ));
                  }
                  return const SizedBox.shrink();
                },
              ),
              BlocBuilder<MFChartCubit, MFChartState>(
                builder: (context, state) {
                  if (state is MFChartLoading) {
                    return const Center(
                      child: CustomLoader(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
        const Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: BlocBuilder<MFChartCubit, MFChartState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _onTap(
                        MutualFundTimePeriod.oneMonth, schemeCode, context),
                    child: TimeFrameSelectWidget(
                        title: '1M',
                        isSelected: state.mutualFundTimePeriod ==
                            MutualFundTimePeriod.oneMonth),
                  ),
                  GestureDetector(
                    onTap: () => _onTap(
                        MutualFundTimePeriod.sixMonth, schemeCode, context),
                    child: TimeFrameSelectWidget(
                        title: '6M',
                        isSelected: state.mutualFundTimePeriod ==
                            MutualFundTimePeriod.sixMonth),
                  ),
                  GestureDetector(
                    onTap: () => _onTap(
                        MutualFundTimePeriod.oneYear, schemeCode, context),
                    child: TimeFrameSelectWidget(
                        title: '1Y',
                        isSelected: state.mutualFundTimePeriod ==
                            MutualFundTimePeriod.oneYear),
                  ),
                  GestureDetector(
                    onTap: () => _onTap(
                        MutualFundTimePeriod.threeYear, schemeCode, context),
                    child: TimeFrameSelectWidget(
                        title: '3Y',
                        isSelected: state.mutualFundTimePeriod ==
                            MutualFundTimePeriod.threeYear),
                  ),
                  GestureDetector(
                    onTap: () => _onTap(
                        MutualFundTimePeriod.fiveYear, schemeCode, context),
                    child: TimeFrameSelectWidget(
                        title: '5Y',
                        isSelected: state.mutualFundTimePeriod ==
                            MutualFundTimePeriod.fiveYear),
                  ),
                  GestureDetector(
                    onTap: () =>
                        _onTap(MutualFundTimePeriod.all, schemeCode, context),
                    child: TimeFrameSelectWidget(
                        title: 'ALL',
                        isSelected: state.mutualFundTimePeriod ==
                            MutualFundTimePeriod.all),
                  ),
                ],
              );
            },
          ),
        ),
        const Gap(20),
      ],
    );
  }

  void _onTap(MutualFundTimePeriod timePeriod, String schemeCode,
      BuildContext context) {
    HapticFeedback.selectionClick();
    context.read<MFChartCubit>().fetchMFChartData(timePeriod, schemeCode);
  }
}
