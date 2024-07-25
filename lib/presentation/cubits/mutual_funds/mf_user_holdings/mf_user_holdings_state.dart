part of 'mf_user_holdings_cubit.dart';

abstract class MfUserHoldingsState extends Equatable {
  const MfUserHoldingsState();
}

class MfUserHoldingsInitial extends MfUserHoldingsState {
  @override
  List<Object> get props => [];
}

class MfUserHoldingsLoading extends MfUserHoldingsState {
  @override
  List<Object> get props => [];
}

class MfUserHoldingsLoaded extends MfUserHoldingsState {
  final UserMfHoldings? userMfHoldings;

  const MfUserHoldingsLoaded(this.userMfHoldings);

  @override
  List<Object?> get props => [userMfHoldings];
}

class MfUserHoldingsError extends MfUserHoldingsState {
  final AppErrorType errorType;
  final String? error;

  const MfUserHoldingsError(this.errorType, this.error);

  @override
  List<Object?> get props => [errorType, error];
}
