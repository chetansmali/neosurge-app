part of 'get_goals_core_data_cubit.dart';

abstract class GetGoalsCoreDataState extends Equatable {
  const GetGoalsCoreDataState();
}

class GetGoalsCoreDataInitial extends GetGoalsCoreDataState {
  @override
  List<Object> get props => [];
}

class GetGoalsCoreDataLoading extends GetGoalsCoreDataState {
  @override
  List<Object> get props => [];
}

class GetGoalsCoreDataLoaded extends GetGoalsCoreDataState {
  final List<GetCoreGoalsModel> getCoreGoalsModel;

  const GetGoalsCoreDataLoaded(this.getCoreGoalsModel);
  @override
  List<Object> get props => [getCoreGoalsModel];
}

class GetGoalsCoreDataFailure extends GetGoalsCoreDataState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GetGoalsCoreDataFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
