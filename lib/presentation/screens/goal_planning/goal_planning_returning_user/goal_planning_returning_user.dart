import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../di/get_it.dart';
import '../../../cubits/goal_planning/get_goal_planning_dashboard_data_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import 'returning_user_long_term_goal.dart';
import '../../../../common/common.dart';
import 'returning_user_short_term_goal.dart';

class GoalPlanningReturnUser extends StatefulWidget {
  const GoalPlanningReturnUser({
    super.key,
  });

  @override
  State<GoalPlanningReturnUser> createState() => _GoalPlanningReturnUserState();
}

class _GoalPlanningReturnUserState extends State<GoalPlanningReturnUser>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _fetchRes = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My goals',
          style: baseTextStyle14400,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text(
                      'Short term',
                      style: baseTextStyle14400,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Long term',
                      style: baseTextStyle14400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: BlocProvider(
                      create: (context) =>
                          getIt<GetGoalPlanningDashboardDataCubit>()
                            ..getDashboardData(goaltype: 'SHORT_TERM'),
                      child: ReturningUserShortTermGoal(refresh: _fetchRes),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: BlocProvider(
                      create: (context) =>
                          getIt<GetGoalPlanningDashboardDataCubit>()
                            ..getDashboardData(goaltype: 'LONG_TERM'),
                      child: ReturningUserLongTermGoal(refresh: _fetchRes),
                    ),
                  )
                ],
              ),
            ),
            const Gap(10),
            ElevatedButton(
              onPressed: () async {
                final res =
                    await Navigator.pushNamed(context, Routes.goalChoiceScreen);

                setState(() {
                  _fetchRes = res as String;
                });
              },
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(double.infinity, 50),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                'Add a new goal',
                style:
                    baseTextStyle16500.copyWith(color: AppColors.primaryWhite),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
