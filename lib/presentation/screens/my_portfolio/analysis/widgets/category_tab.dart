import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../data/models/import_external_funds/portfolio_analysis_response.dart';
import 'chart_legend_row.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({
    super.key,
    required this.category,
  });

  final List<SubcategoriesPercentage>? category;

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  int categorySelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    log('CategoryTab: 0xFF${widget.category![0].color}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 240,
          child: _buildCategoryPieChart(),
        ),
        const Gap(24),
        const Text(
          'Legend',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(16),
        Container(
          constraints: const BoxConstraints(
            maxHeight: 140,
          ),
          child: ListView.builder(
            itemCount: widget.category?.length ?? 0,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ChartLegendRow(
                index: index,
                selectedIndex: categorySelectedIndex,
                color: Color(
                  widget.category![index].color!,
                ),
                title: widget.category![index].subcatgeory!,
                percentage:
                    '${widget.category![index].percentage?.toStringAsFixed(2)}%',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryPieChart() {
    return Stack(
      children: [
        PieChart(
          PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sections: _getCategoryPieChartSectionsData(),
            centerSpaceRadius: 50,
            pieTouchData: PieTouchData(
              touchCallback: (event, pieTouchResponse) {
                setState(
                  () {
                    if (pieTouchResponse?.touchedSection?.touchedSectionIndex ==
                        null) {
                      return;
                    }

                    categorySelectedIndex =
                        pieTouchResponse!.touchedSection!.touchedSectionIndex;
                  },
                );
              },
            ),
          ),
          swapAnimationDuration: const Duration(
            milliseconds: 150,
          ),
          swapAnimationCurve: Curves.linear,
        ),
        const Center(
          child: Text(
            '100%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF47586E),
            ),
          ),
        ),
      ],
    );
  }

  _getCategoryPieChartSectionsData() {
    return widget.category!
        .map(
          (e) => PieChartSectionData(
            color: categorySelectedIndex == -1
                ? Color(
                    e.color!,
                  )
                : widget.category!.indexOf(e) == categorySelectedIndex
                    ? Color(
                        e.color!,
                      )
                    : Colors.grey.withOpacity(0.1),
            value: e.percentage,
            title: widget.category!.length <= 8
                ? '${e.percentage?.toStringAsFixed(2)}%'
                : '',
            titlePositionPercentageOffset: 1.7,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        )
        .toList();
  }
}
