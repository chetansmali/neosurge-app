import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/goal_planning/get_goal_details_model.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/goal_planning/get_goals_details_params.dart';
import '../../../domain/usecases/goal_planning/get_goals_details.dart';

part 'get_goal_details_state.dart';

@injectable
class GetGoalDetailsCubit extends Cubit<GetGoalDetailsState> {
  final GetGoalsDetails getGoalsDetails;
  GetGoalDetailsCubit(this.getGoalsDetails) : super(GetGoalDetailsInitial());

  Future fetchGoalDetails(GetGoalsDetailsParams params) async {
    if (state is GetGoalDetailsLoading) return;

    emit(GetGoalDetailsLoading());
    final result = await getGoalsDetails(params);
    result.fold(
        (l) => emit(GetGoalDetailsFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(GetGoalDetailsLoaded(r)));
  }
}
