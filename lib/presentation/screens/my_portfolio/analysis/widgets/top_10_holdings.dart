import 'package:flutter/material.dart';

import '../../../../../data/models/import_external_funds/portfolio_analysis_response.dart';
import 'analysis_section_card.dart';
import 'progress_bar_with_title.dart';

class TopTenHolding extends StatelessWidget {
  const TopTenHolding({
    super.key,
    required this.topHoldings,
  });
  final List<TopHoldings> topHoldings;

  @override
  Widget build(BuildContext context) {
    return AnalysisSessionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Top 10 Stock Holdings',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const Divider(),
          ...topHoldings
              .map<Widget>(
                (e) => ProgressBarWithTitle(
                  percent: e.holdingsPercentage ?? 0,
                  title: e.holdingName ?? '',
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
