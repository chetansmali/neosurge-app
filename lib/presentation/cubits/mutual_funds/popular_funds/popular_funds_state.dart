part of 'popular_funds_cubit.dart';

abstract class PopularFundsState extends Equatable {
  const PopularFundsState();
}

class PopularFundsInitial extends PopularFundsState {
  @override
  List<Object> get props => [];
}

class PopularFundsLoading extends PopularFundsState {
  @override
  List<Object> get props => [];
}

class PopularFundsLoaded extends PopularFundsState {
  @override
  List<Object> get props => [];
}

class PopularFundsLoadError extends PopularFundsState {
  final AppErrorType errorType;
  final String? error;

  const PopularFundsLoadError({required this.errorType, this.error});

  @override
  List<Object?> get props => [errorType, error];
}
