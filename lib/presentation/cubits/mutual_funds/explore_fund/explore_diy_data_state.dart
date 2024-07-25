part of 'explore_diy_data_cubit.dart';

abstract class ExploreDIYDataState extends Equatable {
  const ExploreDIYDataState();
}

class ExploreDIYDataInitial extends ExploreDIYDataState {
  @override
  List<Object> get props => [];
}

class ExploreDIYDataLoading extends ExploreDIYDataState {
  @override
  List<Object> get props => [];
}

class ExploreDIYDataLoaded extends ExploreDIYDataState {
  final ExploreDIYDataResponse exploreDIYDataResponse;

  const ExploreDIYDataLoaded(this.exploreDIYDataResponse);

  @override
  List<Object> get props => [exploreDIYDataResponse];
}

class ExploreDIYDataError extends ExploreDIYDataState {
  final String message;
  final AppErrorType appErrorType;

  const ExploreDIYDataError({
    required this.message,
    required this.appErrorType,
  });

  @override
  List<Object> get props => [message];
}
