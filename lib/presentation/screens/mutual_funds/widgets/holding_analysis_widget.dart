import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/extensions.dart';
import '../../../cubits/mutual_funds/holding_analysis/holding_analysis_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';

class HoldingAnalysisWidget extends StatefulWidget {
  final String schemeCode;
  final String exitLoadRemarks;

  const HoldingAnalysisWidget({
    Key? key,
    required this.schemeCode,
    required this.exitLoadRemarks,
  }) : super(key: key);

  @override
  State<HoldingAnalysisWidget> createState() => _HoldingAnalysisWidgetState();
}

class _HoldingAnalysisWidgetState extends State<HoldingAnalysisWidget>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      initiallyExpanded: true,
      title: Text(
        'Holding Analysis',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.neutral[400],
        ),
      ),
      children: [
        BlocBuilder<HoldingAnalysisCubit, HoldingAnalysisState>(
          builder: (context, state) {
            if (state is HoldingAnalysisLoading) {
              return const Center(child: CustomLoader());
            }
            if (state is HoldingAnalysisLoadError) {
              return AppErrorWidget(
                errorType: state.appErrorType,
                error: state.errorMessage,
                onRetry: () => context
                    .read<HoldingAnalysisCubit>()
                    .getHoldingAnalysis(schemeCode: widget.schemeCode),
              );
            }
            if (state is HoldingAnalysisLoaded) {
              final assetBreakup = state.holdingAnalysis.assetBreakUp;
              final sectorAllocation = state.sectorAllocationList;
              return Column(
                children: [
                  TabBar(
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: AppColors.primary[500],
                    indicator: UnderlineTabIndicator(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColors.primary[500]!,
                        width: 4,
                      ),
                    ),
                    onTap: (value) {},
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Assets',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Sector',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        _PieChartData(
                          subTitles: assetBreakup.assetTitles,
                          percent: assetBreakup.assetPercent,
                          colors: assetBreakup.assetColors,
                          dataCount: assetBreakup.assetTitles.length,
                          totalMarketCap:
                              '${sectorAllocation.totalMarketValue.toCurrency(decimalDigits: 2)} Cr.',
                        ),
                        _PieChartData(
                          subTitles: sectorAllocation.sectorNames,
                          percent: sectorAllocation.sectorPercentList,
                          colors: sectorAllocation.top5SectorColors,
                          dataCount: sectorAllocation.sectorNames.length,
                          totalMarketCap:
                              '${sectorAllocation.totalMarketValue.toCurrency(decimalDigits: 2)} Cr.',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }
}

class _PieChartData extends StatelessWidget {
  final int dataCount;
  final List<String> subTitles;
  final List<double> percent;
  final List<Color> colors;
  final String totalMarketCap;

  const _PieChartData({
    Key? key,
    required this.subTitles,
    required this.percent,
    required this.colors,
    required this.dataCount,
    required this.totalMarketCap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 150,
            width: 150,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 6,
                    centerSpaceRadius: 60,
                    sections: List.generate(
                      dataCount,
                      (index) => PieChartSectionData(
                        value: percent[index],
                        color: colors[index % 12],
                        title: subTitles[index],
                        showTitle: false,
                        radius: 20,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '₹ $totalMarketCap',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                ...List.generate(
                  dataCount,
                  (index) => _SpiltPercent(
                    color: colors[index % 12],
                    title: subTitles[index],
                    percent: percent[index],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SpiltPercent extends StatelessWidget {
  final Color color;
  final String title;
  final double percent;

  const _SpiltPercent(
      {Key? key,
      required this.color,
      required this.title,
      required this.percent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const Gap(4),
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(fontSize: 10),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Text(
              '${percent.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
