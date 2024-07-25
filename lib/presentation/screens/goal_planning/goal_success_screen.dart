import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'goal_planning_returning_user/bookmarkerd_goal_planning_card.dart';

import '../../../common/common.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/app_colors.dart';

class GoalSuccessScreen extends StatelessWidget {
  const GoalSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(80),
              Assets.gifs.transactionSuccess.image(height: 140, width: 125),
              const Gap(12),
              Text(
                'Payment Received!',
                style: baseTextStyle14500,
              ),
              const Gap(8),
              Text(
                'Request will be sent to AMC.',
                style: baseTextStyle12400.copyWith(color: AppColors.textGrey),
              ),
              const Gap(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Link this investment to a goal?',
                    style: baseTextStyle14400,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: baseTextStyle14500.copyWith(
                          color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                  itemCount: 15,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const BookmarkedGoalPlanningCard(
                      title: 'ok',
                      subtitle: 45210,
                      goalCompleted: false,
                      persentageValue: 40,
                      id: '789',
                      icon: '',
                    );
                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size(double.infinity, 54),
                  minimumSize: const Size(double.infinity, 54),
                ),
                child: Text(
                  'Go To Portfolio',
                  style: baseTextStyle16500.copyWith(
                      color: AppColors.primaryWhite),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Track Order',
                  style: baseTextStyle16500.copyWith(
                      color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
