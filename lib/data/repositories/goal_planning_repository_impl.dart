import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/goal_planning_repository.dart';
import '../data_sources/remote/goal_planning_remote_data_source.dart';
import '../models/goal_planning/create_custom_goal_model.dart';
import '../models/goal_planning/create_goal_investment_model.dart';
import '../models/goal_planning/get_core_goals_model.dart';
import '../models/goal_planning/get_goal_details_model.dart';
import '../models/goal_planning/goal_planning_dashboard_data_model.dart';

@LazySingleton(as: GoalPlanningRepository)
class GoalPlanningRepositoryImpl implements GoalPlanningRepository {
  final GoalPlanningRemoteDataSource _goalPlanningRemoteDataSource;

  GoalPlanningRepositoryImpl(this._goalPlanningRemoteDataSource);

  @override
  Future<Either<AppError, List<GoalPlanningDashboardDataModel>>>
      getGoalPlanningDasboardData(Map<String, dynamic> params) async {
    return await ApiCallWithError.call(() =>
        _goalPlanningRemoteDataSource.getGoalPlanningDashboardData(params));
  }

  @override
  Future<Either<AppError, List<GetCoreGoalsModel>>> getGoalCoreData() async {
    return await ApiCallWithError.call(
        () => _goalPlanningRemoteDataSource.getGoalCoreData());
  }

  @override
  Future<Either<AppError, CreateCustomGoalModel>> createUserGoals(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _goalPlanningRemoteDataSource.createGoal(params));
  }

  @override
  Future<Either<AppError, GetGoalDetailsModel>> getUserGoalsDetails(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _goalPlanningRemoteDataSource.getUserGoalsDetails(params));
  }

  @override
  Future<Either<AppError, CreateGoalInvestmentModel>> createGoalsInvestment(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _goalPlanningRemoteDataSource.createGoalInvestment(params));
  }
}
