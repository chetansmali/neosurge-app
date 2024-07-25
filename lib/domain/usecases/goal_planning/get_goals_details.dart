import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/goal_planning/get_goal_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/goal_planning/get_goals_details_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/goal_planning_repository.dart';

@injectable
class GetGoalsDetails
    extends UseCase<GetGoalDetailsModel, GetGoalsDetailsParams> {
  final GoalPlanningRepository _goalPlanningRepository;

  GetGoalsDetails(this._goalPlanningRepository);

  @override
  Future<Either<AppError, GetGoalDetailsModel>> call(params) =>
      _goalPlanningRepository.getUserGoalsDetails(params.toJson());
}
