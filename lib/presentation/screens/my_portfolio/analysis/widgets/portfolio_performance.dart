import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../theme/app_colors.dart';

import 'analysis_section_card.dart';

class PortfolioPerformance extends StatelessWidget {
  const PortfolioPerformance({
    super.key,
    required this.xirr,
    required this.benchmark,
  });

  final double xirr;
  final double benchmark;

  @override
  Widget build(BuildContext context) {
    return AnalysisSessionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Portfolio Performance',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const Gap(12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: 'XIRR',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF47586E),
                  ),
                  children: [
                    TextSpan(
                      text: '\n${xirr.toStringAsFixed(2)}%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  text: 'Benchmark (NIFTY 500)',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF47586E),
                  ),
                  children: [
                    TextSpan(
                      text: '\n${benchmark.toStringAsFixed(2)}%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
