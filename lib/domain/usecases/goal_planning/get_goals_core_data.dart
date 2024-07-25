import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/goal_planning/get_core_goals_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/goal_planning_repository.dart';

@injectable
class GetGoalsCoreData extends UseCase<List<GetCoreGoalsModel>, NoParams> {
  final GoalPlanningRepository _goalPlanningRepository;

  GetGoalsCoreData(this._goalPlanningRepository);

  @override
  Future<Either<AppError, List<GetCoreGoalsModel>>> call(params) =>
      _goalPlanningRepository.getGoalCoreData();
}
