import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/goal_planning/create_goal_investment_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/goal_planning/create_custom_goals_params.dart';
import '../../entities/params/goal_planning/create_goal_investment_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/goal_planning_repository.dart';

@injectable
class CreateGoalInvestment
    extends UseCase<CreateGoalInvestmentModel, CreateGoalInvestmentParams> {
  final GoalPlanningRepository _goalPlanningRepository;

  CreateGoalInvestment(this._goalPlanningRepository);

  @override
  Future<Either<AppError, CreateGoalInvestmentModel>> call(
      CreateGoalInvestmentParams params) async {
    return await _goalPlanningRepository.createGoalsInvestment(params.toJson());
  }
}
