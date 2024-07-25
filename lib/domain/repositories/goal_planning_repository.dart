import 'package:dartz/dartz.dart';

import '../../data/models/goal_planning/create_custom_goal_model.dart';
import '../../data/models/goal_planning/create_goal_investment_model.dart';
import '../../data/models/goal_planning/get_core_goals_model.dart';
import '../../data/models/goal_planning/get_goal_details_model.dart';
import '../../data/models/goal_planning/goal_planning_dashboard_data_model.dart';
import '../entities/app_error.dart';

abstract class GoalPlanningRepository {
  Future<Either<AppError, List<GoalPlanningDashboardDataModel>>>
      getGoalPlanningDasboardData(Map<String, dynamic> params);

  Future<Either<AppError, List<GetCoreGoalsModel>>> getGoalCoreData();

  Future<Either<AppError, CreateCustomGoalModel>> createUserGoals(
      Map<String, dynamic> params);

  Future<Either<AppError, GetGoalDetailsModel>> getUserGoalsDetails(
      Map<String, dynamic> params);

  Future<Either<AppError, CreateGoalInvestmentModel>> createGoalsInvestment(
      Map<String, dynamic> params);
}
