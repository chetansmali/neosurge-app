import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/goal_planning/goal_planning_dashboard_data_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/goal_planning/goal_planning_dashboard_data_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/goal_planning_repository.dart';

@injectable
class GetGoalPlanningDashboard extends UseCase<
    List<GoalPlanningDashboardDataModel>, GoalPlanningOnboardDataParams> {
  final GoalPlanningRepository _goalPlanningRepository;

  GetGoalPlanningDashboard(this._goalPlanningRepository);

  @override
  Future<Either<AppError, List<GoalPlanningDashboardDataModel>>> call(params) =>
      _goalPlanningRepository.getGoalPlanningDasboardData(params.toJson());
}
