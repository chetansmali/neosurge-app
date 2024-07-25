part of 'create_goal_investements_cubit.dart';

abstract class CreateGoalInvestementsState extends Equatable {
  const CreateGoalInvestementsState();
}

class CreateGoalInvestementsInitial extends CreateGoalInvestementsState {
  @override
  List<Object> get props => [];
}

class CreateGoalInvestementsLoading extends CreateGoalInvestementsState {
  final int goalID;
  const CreateGoalInvestementsLoading(this.goalID);
  @override
  List<Object> get props => [goalID];
}

class CreateGoalInvestementsSuccess extends CreateGoalInvestementsState {
  final CreateGoalInvestmentModel createGoalInvestmentModel;

  const CreateGoalInvestementsSuccess(this.createGoalInvestmentModel);
  @override
  List<Object> get props => [createGoalInvestmentModel];
}

class CreateGoalInvestementsFailure extends CreateGoalInvestementsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const CreateGoalInvestementsFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
