part of 'lamf_update_loan_status_cubit.dart';

abstract class LamfUpdateLoanStatusState extends Equatable {
  const LamfUpdateLoanStatusState();
}

final class LamfUpdateLoanStatusInitial extends LamfUpdateLoanStatusState {
  @override
  List<Object> get props => [];
}

final class LamfUpdateLoanStatusLoading extends LamfUpdateLoanStatusState {
  @override
  List<Object> get props => [];
}

final class LamfUpdateLoanStatusSuccess extends LamfUpdateLoanStatusState {
  UpdateLoanStatusDetails updateLoanStatusDetails;
  LamfUpdateLoanStatusSuccess(this.updateLoanStatusDetails);
  @override
  List<Object> get props => [];
}

final class LamfUpdateLoanStatusFailure extends LamfUpdateLoanStatusState {
  final String? errorMessage;
  final AppErrorType errorType;
  const LamfUpdateLoanStatusFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
