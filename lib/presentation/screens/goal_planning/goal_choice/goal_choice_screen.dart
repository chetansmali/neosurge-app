import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../cubits/goal_planning/get_goals_core_data_cubit.dart';
import '../../../widgets/app_error_widget.dart';
import 'short_term_goal_choice_screen.dart';
import '../../../../common/custom_styles.dart';
import 'long_term_goal_choice_screen.dart';

class GoalChoiceScreen extends StatefulWidget {
  const GoalChoiceScreen({super.key});

  @override
  State<GoalChoiceScreen> createState() => _GoalChoiceScreenState();
}

class _GoalChoiceScreenState extends State<GoalChoiceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, 'true');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text(
                'What do you want to save for?',
                style: baseTextStyle20400.copyWith(fontWeight: FontWeight.w500),
              ),
              const Gap(20),
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
              BlocBuilder<GetGoalsCoreDataCubit, GetGoalsCoreDataState>(
                builder: (context, state) {
                  if (state is GetGoalsCoreDataLoading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                  if (state is GetGoalsCoreDataFailure) {
                    return AppErrorWidget(
                      errorType: state.errorType,
                      error: state.errorMessage,
                      onRetry: () => context
                          .read<GetGoalsCoreDataCubit>()
                          .fetchGoalCoreData(),
                    );
                  }
                  if (state is GetGoalsCoreDataLoaded) {
                    return Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ShortTermGoalChoiceScreen(
                                goals: state.getCoreGoalsModel[0].goalType ==
                                        'SHORT_TERM'
                                    ? state.getCoreGoalsModel[0].goals
                                    : state.getCoreGoalsModel[1].goals),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: LongTermGoalChoiceScreen(
                                goals: state.getCoreGoalsModel[1].goalType ==
                                        'LONG_TERM'
                                    ? state.getCoreGoalsModel[1].goals
                                    : state.getCoreGoalsModel[0].goals),
                          )
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
