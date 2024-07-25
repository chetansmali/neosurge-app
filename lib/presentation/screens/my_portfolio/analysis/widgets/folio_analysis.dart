import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'progress_bar_with_title.dart';

import 'analysis_section_card.dart';

class FolioAnalysis extends StatelessWidget {
  const FolioAnalysis({
    super.key,
    required this.holdingsCount,
    required this.equityPercentage,
    required this.debtPercentage,
    required this.hybridPercentage,
  });

  final int holdingsCount;
  final double equityPercentage;
  final double debtPercentage;
  final double hybridPercentage;

  @override
  Widget build(BuildContext context) {
    return AnalysisSessionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You have invested in $holdingsCount Folios',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(12),
          ProgressBarWithTitle(
            title: 'Equity',
            percent: equityPercentage,
          ),
          ProgressBarWithTitle(
            title: 'Debt',
            percent: debtPercentage,
          ),
          ProgressBarWithTitle(
            title: 'Hybrid',
            percent: hybridPercentage,
          ),
        ],
      ),
    );
  }
}
