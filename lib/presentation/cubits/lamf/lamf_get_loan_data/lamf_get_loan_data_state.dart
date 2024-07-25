part of 'lamf_get_loan_data_cubit.dart';

abstract class LamfGetLoanDataState extends Equatable {
  const LamfGetLoanDataState();
}

final class LamfGetLoanDataInitial extends LamfGetLoanDataState {
  @override
  List<Object> get props => [];
}

final class LamfGetLoanDataLoading extends LamfGetLoanDataState {
  @override
  List<Object> get props => [];
}

final class LamfGetLoanDataSuccess extends LamfGetLoanDataState {
  final GetLoanDataDetails getLoanDataDetails;
  const LamfGetLoanDataSuccess(this.getLoanDataDetails);
  @override
  List<Object> get props => [];
}

final class LamfGetLoanDataFailure extends LamfGetLoanDataState {
  final String? errorMessage;
  final AppErrorType errorType;
  const LamfGetLoanDataFailure(this.errorMessage, this.errorType);

  @override
  List<Object?> get props => [errorMessage, errorType];
}
