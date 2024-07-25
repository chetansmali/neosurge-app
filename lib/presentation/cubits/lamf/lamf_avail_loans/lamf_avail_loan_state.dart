part of 'lamf_avail_loan_cubit.dart';

sealed class LamfAvailLoanState extends Equatable {
  const LamfAvailLoanState();
}

final class LamfAvailLoanInitial extends LamfAvailLoanState {
  @override
  List<Object> get props => [];
}

final class LamfAvailLoanLoading extends LamfAvailLoanState {
  @override
  List<Object> get props => [];
}

final class LamfAvailLoanSuccess extends LamfAvailLoanState {
  AvailLoanDetails availLoanDetails;
  LamfAvailLoanSuccess(this.availLoanDetails);
  @override
  List<Object> get props => [];
}

final class LamfAvailLoanFailure extends LamfAvailLoanState {
  final String? errorMessage;
  final AppErrorType errorType;

  const LamfAvailLoanFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
