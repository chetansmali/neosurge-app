import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/goal_planning/create_custom_goal_model.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/goal_planning/create_custom_goals_params.dart';
import '../../../domain/usecases/goal_planning/create_custom_user_goals.dart';

part 'create_user_goals_state.dart';

@injectable
class CreateUserGoalsCubit extends Cubit<CreateUserGoalsState> {
  final CreateCustomUserGoals createCustomUserGoals;
  CreateUserGoalsCubit(this.createCustomUserGoals)
      : super(CreateUserGoalsInitial());

  Future createGoals(CreateCustomGoalsParams params) async {
    if (state is CreateUserGoalsLoading) return;

    emit(CreateUserGoalsLoading());
    final response = await createCustomUserGoals(params);
    response.fold(
        (l) => emit(
              CreateUserGoalsFailure(
                  errorType: l.errorType, errorMessage: l.error),
            ), (r) {
      emit(CreateUserGoalsLoaded(r));
    });
  }
}
