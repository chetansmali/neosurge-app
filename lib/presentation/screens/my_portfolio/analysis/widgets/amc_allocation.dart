import 'package:flutter/material.dart';

import '../../../../../core/api/api_constants.dart';
import '../../../../../data/models/import_external_funds/portfolio_analysis_response.dart';
import '../../widgets/scheme_holding_card.dart';
import 'analysis_section_card.dart';

class AmcAllocation extends StatelessWidget {
  const AmcAllocation({
    super.key,
    required this.amcAllocations,
  });
  final List<AmcBasedHoldings> amcAllocations;
  @override
  Widget build(BuildContext context) {
    return AnalysisSessionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'AMC Allocation',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const Divider(),
          ...amcAllocations
              .map<Widget>(
                (e) => ShchemeHoldingCard(
                  schemeName: e.amcName ?? '',
                  image: '${ApiConstants.baseProdUrl}/${e.amcURL}',
                  currentValue: e.currentValue ?? 0,
                  investedValue: e.investedValue ?? 0,
                  returnValue: e.returnsValue ?? 0,
                  holdingPercentage: e.holdingsPercentage ?? 0,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
