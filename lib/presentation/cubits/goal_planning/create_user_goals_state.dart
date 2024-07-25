part of 'create_user_goals_cubit.dart';

abstract class CreateUserGoalsState extends Equatable {
  const CreateUserGoalsState();
}

class CreateUserGoalsInitial extends CreateUserGoalsState {
  @override
  List<Object> get props => [];
}

class CreateUserGoalsLoading extends CreateUserGoalsState {
  @override
  List<Object> get props => [];
}

class CreateUserGoalsLoaded extends CreateUserGoalsState {
  final CreateCustomGoalModel createCustomGoalModel;

  const CreateUserGoalsLoaded(this.createCustomGoalModel);
  @override
  List<Object> get props => [createCustomGoalModel];
}

class CreateUserGoalsFailure extends CreateUserGoalsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const CreateUserGoalsFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
