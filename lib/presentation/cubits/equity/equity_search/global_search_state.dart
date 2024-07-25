part of 'global_search_cubit.dart';

abstract class GlobalSearchState extends Equatable {
  const GlobalSearchState();
}

class GlobalSearchInitial extends GlobalSearchState {
  @override
  List<Object> get props => [];
}

class GlobalSearchLoading extends GlobalSearchState {
  final List<GlobalSearchModel> oldStocks;

  const GlobalSearchLoading({
    required this.oldStocks,
});

  @override
  List<Object> get props => [];
}

class GlobalSearchLoaded extends GlobalSearchState {
  final List<GlobalSearchModel> stock;

  const GlobalSearchLoaded({
    required this.stock,

});
  @override
  List<Object> get props => [stock];
}

class GlobalSearchLoadError extends GlobalSearchState {
  final String? errorMessage;
  final AppErrorType appErrorType;
  final List<GlobalSearchModel> oldStocks;

  const GlobalSearchLoadError({
    required this.oldStocks,
    required this.appErrorType,
    this.errorMessage,
});
  @override
  List<Object?> get props => [errorMessage,appErrorType];
}