import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/goal_planning/create_goal_investment_model.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/goal_planning/create_custom_goals_params.dart';
import '../../../domain/entities/params/goal_planning/create_goal_investment_params.dart';
import '../../../domain/usecases/goal_planning/create_goal_investment.dart';

part 'create_goal_investements_state.dart';

@injectable
class CreateGoalInvestementsCubit extends Cubit<CreateGoalInvestementsState> {
  final CreateGoalInvestment createGoalInvestment;

  CreateGoalInvestementsCubit(this.createGoalInvestment)
      : super(CreateGoalInvestementsInitial());

  Future createInvestment(CreateGoalInvestmentParams params) async {
    if (state is CreateGoalInvestementsLoading) return;
    emit(CreateGoalInvestementsLoading(params.goalId));
    final response = await createGoalInvestment(params);
    response.fold(
        (l) => emit(
              CreateGoalInvestementsFailure(
                  errorType: l.errorType, errorMessage: l.error),
            ), (r) {
      emit(
        CreateGoalInvestementsSuccess(r),
      );
    });
  }
}
