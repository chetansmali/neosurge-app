import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../common/extensions.dart';
import '../../../../../data/models/assisted_service/suggested_fund.dart';
import '../../../../theme/app_colors.dart';

class FundSuggestionChart extends StatelessWidget {
  final List<SuggestedFund> funds;
  final double totalAmount;

  const FundSuggestionChart({Key? key, required this.funds, required this.totalAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fund Allocations',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: List.generate(
                    funds.length,
                    (index) => _FundInfo(
                      fundName: funds[index].name,
                      fundPercentage: funds[index].amount / totalAmount * 100,
                      fundColor: AppColors.assistedServiceFundColors[index % 12],
                    ),
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 46,
                          sections: List.generate(
                            funds.length,
                            (index) => PieChartSectionData(
                              showTitle: false,
                              radius: 18,
                              color: AppColors.assistedServiceFundColors[index % 12],
                              value: funds[index].amount / totalAmount,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '₹${(totalAmount).toCurrency()}',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _FundInfo extends StatelessWidget {
  final String fundName;
  final double fundPercentage;
  final Color fundColor;

  const _FundInfo({Key? key, required this.fundName, required this.fundPercentage, required this.fundColor}) : super(key: key);

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
              color: fundColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              fundName,
              style: const TextStyle(fontSize: 10),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${fundPercentage.toStringAsFixed(2)}%',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
