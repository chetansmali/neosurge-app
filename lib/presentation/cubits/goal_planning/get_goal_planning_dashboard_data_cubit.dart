import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/goal_planning/goal_planning_dashboard_data_model.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/goal_planning/goal_planning_dashboard_data_params.dart';
import '../../../domain/usecases/goal_planning/get_goal_planning_dashboard.dart';

part 'get_goal_planning_dashboard_data_state.dart';

@injectable
class GetGoalPlanningDashboardDataCubit
    extends Cubit<GetGoalPlanningDashboardDataState> {
  GetGoalPlanningDashboardDataCubit(this.getGoalPlanningDashboard)
      : super(GetGoalPlanningDashboardDataInitial());

  final GetGoalPlanningDashboard getGoalPlanningDashboard;
  int currentPage = 0;
  final int size = 20;

  void getDashboardData({
    required String goaltype,
    String? sort,
    int? page,
  }) async {
    if (state is GetGoalPlanningDashboardDataLoading) return;

    List<GoalPlanningDashboardDataModel> oldFundList = state.fundList ?? [];
    currentPage = page ?? currentPage;

    if (currentPage == 0) oldFundList.clear();

    emit(
      GetGoalPlanningDashboardDataLoading(
        oldFundList: oldFundList,
      ),
    );

    final response = await getGoalPlanningDashboard(
      GoalPlanningOnboardDataParams(
        page: currentPage,
        size: size,
        goaltype: goaltype,
      ),
    );

    response.fold(
      (l) => emit(
        GetGoalPlanningDashboardDataFailure(
          oldFundList: oldFundList,
          error: l.error,
          errorType: l.errorType,
        ),
      ),
      (r) {
        currentPage++;
        oldFundList.addAll(r);
        emit(
          GetGoalPlanningDashboardDataLoaded(
            newFundList: oldFundList,
            isLastPage: r.length < size,
          ),
        );
      },
    );
  }
}
