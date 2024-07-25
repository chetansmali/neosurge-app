part of 'get_goal_details_cubit.dart';

abstract class GetGoalDetailsState extends Equatable {
  const GetGoalDetailsState();
}

class GetGoalDetailsInitial extends GetGoalDetailsState {
  @override
  List<Object> get props => [];
}

class GetGoalDetailsLoading extends GetGoalDetailsState {
  @override
  List<Object> get props => [];
}

class GetGoalDetailsLoaded extends GetGoalDetailsState {
  final GetGoalDetailsModel getGoalDetailsModel;

  const GetGoalDetailsLoaded(this.getGoalDetailsModel);
  @override
  List<Object> get props => [getGoalDetailsModel];
}

class GetGoalDetailsFailure extends GetGoalDetailsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GetGoalDetailsFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
