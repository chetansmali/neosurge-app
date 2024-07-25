part of 'lamf_loan_closure_cubit.dart';

abstract class LamfLoanClosureState extends Equatable {
  const LamfLoanClosureState();
}

final class LamfLoanClosureInitial extends LamfLoanClosureState {
  @override
  List<Object> get props => [];
}

final class LamfLoanClosureLoading extends LamfLoanClosureState {
  @override
  List<Object> get props => [];
}

final class LamfLoanClosureSuccess extends LamfLoanClosureState {
  LoanClosureDetails loanClosureDetails;
  LamfLoanClosureSuccess(this.loanClosureDetails);
  @override
  List<Object> get props => [];
}

final class LamfLoanClosureFailure extends LamfLoanClosureState {
  final String? errorMessage;
  final AppErrorType errorType;
  const LamfLoanClosureFailure(this.errorMessage, this.errorType);

  @override
  List<Object?> get props => [errorMessage, errorType];
}
