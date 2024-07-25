import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../data/models/import_external_funds/portfolio_analysis_response.dart';
import 'chart_legend_row.dart';

class SectorTab extends StatefulWidget {
  const SectorTab({
    super.key,
    required this.sector,
  });

  final List<SectorsPercentage> sector;

  @override
  State<SectorTab> createState() => _SectorTabState();
}

class _SectorTabState extends State<SectorTab> {
  int sectorSelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 240,
          child: _buildSectorPieChart(),
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
            itemCount: widget.sector.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ChartLegendRow(
                index: index,
                selectedIndex: sectorSelectedIndex,
                color: Color(widget.sector[index].color!),
                title: widget.sector[index].sector!,
                percentage:
                    '${widget.sector[index].percentage?.toStringAsFixed(2)}%',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectorPieChart() {
    return Stack(
      children: [
        PieChart(
          PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sections: _getSectorPieChartSectionsData(),
            centerSpaceRadius: 50,
            pieTouchData: PieTouchData(
              touchCallback: (event, pieTouchResponse) {
                setState(
                  () {
                    if (pieTouchResponse?.touchedSection?.touchedSectionIndex ==
                        null) {
                      return;
                    }

                    sectorSelectedIndex =
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

  _getSectorPieChartSectionsData() {
    return widget.sector
        .map(
          (e) => PieChartSectionData(
            color: sectorSelectedIndex == -1
                ? Color(
                    e.color!,
                  )
                : widget.sector.indexOf(e) == sectorSelectedIndex
                    ? Color(
                        e.color!,
                      )
                    : Colors.grey.withOpacity(0.1),
            value: e.percentage,
            title: widget.sector.length <= 8
                ? '[${e.percentage?.toStringAsFixed(2)}%]'
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
