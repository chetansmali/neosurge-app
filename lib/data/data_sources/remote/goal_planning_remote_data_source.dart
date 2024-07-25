import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../models/goal_planning/create_custom_goal_model.dart';
import '../../models/goal_planning/create_goal_investment_model.dart';
import '../../models/goal_planning/get_core_goals_model.dart';
import '../../models/goal_planning/get_goal_details_model.dart';
import '../../models/goal_planning/goal_planning_dashboard_data_model.dart';

abstract class GoalPlanningRemoteDataSource {
  Future<List<GoalPlanningDashboardDataModel>> getGoalPlanningDashboardData(
      Map<String, dynamic> params);

  Future<List<GetCoreGoalsModel>> getGoalCoreData();

  Future<CreateCustomGoalModel> createGoal(Map<String, dynamic> params);

  Future<GetGoalDetailsModel> getUserGoalsDetails(Map<String, dynamic> params);

  Future<CreateGoalInvestmentModel> createGoalInvestment(
      Map<String, dynamic> params);
}

@LazySingleton(as: GoalPlanningRemoteDataSource)
class GoalPlanningRemoteDataSourceImpl implements GoalPlanningRemoteDataSource {
  final ApiClient _client;
  GoalPlanningRemoteDataSourceImpl(this._client);

  @override
  Future<List<GoalPlanningDashboardDataModel>> getGoalPlanningDashboardData(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.goalPlanningDashboardData,
        queryParameters: params);
    log(response.toString());
    return GoalPlanningDashboardDataModel.listFromJson(response);
  }

  @override
  Future<List<GetCoreGoalsModel>> getGoalCoreData() async {
    final response = await _client.get(ApiConstants.goalCoreData);
    return GetCoreGoalsModel.listFromJson(response);
  }

  @override
  Future<CreateCustomGoalModel> createGoal(Map<String, dynamic> params) async {
    final response =
        await _client.post(ApiConstants.createGoals, params: params);
    return CreateCustomGoalModel.fromJson(response);
  }

  @override
  Future<GetGoalDetailsModel> getUserGoalsDetails(
      Map<String, dynamic> params) async {
    final response = await _client.get(
      ApiConstants.getGoalsDetails + params['id'].toString(),
    );
    return GetGoalDetailsModel.fromJson(response);
  }

  @override
  Future<CreateGoalInvestmentModel> createGoalInvestment(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.createGoalInvestment,
        params: params, extractData: false);
    return CreateGoalInvestmentModel.fromJson(response);
  }
}
