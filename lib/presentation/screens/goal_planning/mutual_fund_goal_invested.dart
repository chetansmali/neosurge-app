import 'package:flutter/material.dart';
import '../../../data/models/goal_planning/get_goal_details_model.dart';
import 'goal_investment_card.dart';

class MutaalFundGoalInvested extends StatelessWidget {
  final List<LinkedInvestments>? linkedInvestments;

  const MutaalFundGoalInvested({super.key, required this.linkedInvestments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: linkedInvestments!.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(
        12,
      ),
      itemBuilder: (context, index) {
        return GoalInvestmentCard(
          image: linkedInvestments![index].amcLogo ?? '',
          schemeName: linkedInvestments![index].schemeName ?? '',
          currentValue: linkedInvestments![index].currentValue ?? 0,
          investedValue: linkedInvestments![index].investedValue ?? 0,
          returnPercentage: linkedInvestments![index].returnsPercentage ?? 0,
        );
      },
    );
  }
}
