part of 'get_goal_planning_dashboard_data_cubit.dart';

abstract class GetGoalPlanningDashboardDataState extends Equatable {
  final List<GoalPlanningDashboardDataModel>? fundList;
  const GetGoalPlanningDashboardDataState({
    this.fundList,
  });
}

class GetGoalPlanningDashboardDataInitial
    extends GetGoalPlanningDashboardDataState {
  @override
  List<Object> get props => [];
}

class GetGoalPlanningDashboardDataLoading
    extends GetGoalPlanningDashboardDataState {
  final List<GoalPlanningDashboardDataModel> oldFundList;

  const GetGoalPlanningDashboardDataLoading({
    required this.oldFundList,
  }) : super(fundList: oldFundList);
  @override
  List<Object> get props => [oldFundList];
}

class GetGoalPlanningDashboardDataLoaded
    extends GetGoalPlanningDashboardDataState {
  final List<GoalPlanningDashboardDataModel> newFundList;
  final bool isLastPage;

  const GetGoalPlanningDashboardDataLoaded({
    required this.newFundList,
    required this.isLastPage,
  }) : super(fundList: newFundList);

  @override
  List<Object> get props => [newFundList, isLastPage];
}

class GetGoalPlanningDashboardDataFailure
    extends GetGoalPlanningDashboardDataState {
  final List<GoalPlanningDashboardDataModel> oldFundList;
  final String? error;
  final AppErrorType errorType;

  const GetGoalPlanningDashboardDataFailure({
    required this.oldFundList,
    required this.error,
    required this.errorType,
  }) : super(fundList: oldFundList);

  @override
  List<Object?> get props => [oldFundList, error ?? '', errorType];
}
