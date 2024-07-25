part of 'create_watchlist_cubit.dart';

abstract class CreateWatchlistState extends Equatable {
  const CreateWatchlistState();
}

class CreateWatchlistInitial extends CreateWatchlistState {
  @override
  List<Object> get props => [];
}

class CreateWatchlistLoading extends CreateWatchlistState {
  @override
  List<Object> get props => [];
}

class CreateWatchlistLoaded extends CreateWatchlistState {
  final CreateWatchlistModel createWatchlistModel;

  const CreateWatchlistLoaded(this.createWatchlistModel);

  @override
  List<Object> get props => [createWatchlistModel];
}

class CreateWatchlistFailure extends CreateWatchlistState {
  final String? errorMessage;
  final AppErrorType errorType;

  const CreateWatchlistFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
