import 'package:flutter/material.dart';
import '../../../../data/models/goal_planning/get_core_goals_model.dart';

import 'goal_choice_card.dart';

class LongTermGoalChoiceScreen extends StatelessWidget {
  final List<Goal> goals;
  const LongTermGoalChoiceScreen({super.key, required this.goals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: goals.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemBuilder: (context, index) {
          return GoalChoiceCard(
              title: goals[index].goalName,
              icon: goals[index].goalIcon,
              goalType: goals[index].goalType);
        });
  }
}
