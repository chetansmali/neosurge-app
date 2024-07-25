part of 'lamf_pledged_funds_cubit.dart';

abstract class LamfPledgedFundsState extends Equatable {
  const LamfPledgedFundsState();
}

final class LamfPledgedFundsInitial extends LamfPledgedFundsState {
  @override
  List<Object> get props => [];
}

final class LamfPledgedFundsLoading extends LamfPledgedFundsState {
  @override
  List<Object> get props => [];
}

final class LamfPledgedFundsSuccess extends LamfPledgedFundsState {
  GetPledgedFundsDetails getPledgedFundsDetails;
  LamfPledgedFundsSuccess(this.getPledgedFundsDetails);
  @override
  List<Object> get props => [];
}

final class LamfPledgedFundsFailure extends LamfPledgedFundsState {
  final String? errorMessage;
  final AppErrorType errorType;
  const LamfPledgedFundsFailure(this.errorMessage, this.errorType);

  @override
  List<Object?> get props => [errorMessage, errorType];
}
