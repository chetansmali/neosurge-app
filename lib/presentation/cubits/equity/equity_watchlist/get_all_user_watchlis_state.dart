part of 'get_all_user_watchlis_cubit.dart';

abstract class GetAllUserWatchlisState extends Equatable {
  const GetAllUserWatchlisState();
}

class GetAllUserWatchlisInitial extends GetAllUserWatchlisState {
  @override
  List<Object> get props => [];
}

class GetAllUserWatchlisLoading extends GetAllUserWatchlisState {
  @override
  List<Object> get props => [];
}

class GetAllUserWatchlisLoaded extends GetAllUserWatchlisState {
  final List<GetAllWatchlistModel> getAllWatchlist;

  const GetAllUserWatchlisLoaded({required this.getAllWatchlist});

  @override
  List<Object> get props => [getAllWatchlist];
}

class GetAllUserWatchlistFailure extends GetAllUserWatchlisState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GetAllUserWatchlistFailure(
    this.errorType,
    this.errorMessage,
  );

  @override
  List<Object?> get props => [errorType, errorMessage];
}
