part of 'remove_watchlist_cubit.dart';

abstract class RemoveWatchlistState extends Equatable {
  const RemoveWatchlistState();
}

class RemoveWatchlistInitial extends RemoveWatchlistState {
  @override
  List<Object> get props => [];
}

class RemoveWatchlistLoading extends RemoveWatchlistState {
  @override
  List<Object> get props => [];
}

class RemoveWatchlistSuccess extends RemoveWatchlistState {
  final DeleteWatchlistModel deleteWatchlistModel;

  const RemoveWatchlistSuccess(this.deleteWatchlistModel);

  @override
  List<Object> get props => [deleteWatchlistModel];
}

class RemoveWatchlistFailure extends RemoveWatchlistState {
  final String? errorMessage;
  final AppErrorType errorType;

  const RemoveWatchlistFailure(
    this.errorType,
    this.errorMessage,
  );

  @override
  List<Object?> get props => [errorType, errorMessage];
}
