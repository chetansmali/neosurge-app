import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/goal_planning/create_custom_goal_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/goal_planning/create_custom_goals_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/goal_planning_repository.dart';

@injectable
class CreateCustomUserGoals
    extends UseCase<CreateCustomGoalModel, CreateCustomGoalsParams> {
  final GoalPlanningRepository _goalPlanningRepository;

  CreateCustomUserGoals(this._goalPlanningRepository);

  @override
  Future<Either<AppError, CreateCustomGoalModel>> call(
      CreateCustomGoalsParams params) async {
    return await _goalPlanningRepository.createUserGoals(params.toJson());
  }
}
