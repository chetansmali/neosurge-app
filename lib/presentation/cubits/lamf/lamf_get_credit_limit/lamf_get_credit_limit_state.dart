part of 'lamf_get_credit_limit_cubit.dart';

abstract class LamfGetCreditLimitState extends Equatable {
  const LamfGetCreditLimitState();
}

class LamfGetCreditLimitInitial extends LamfGetCreditLimitState {
  @override
  List<Object> get props => [];
}

class LamfGetCreditLimitLoading extends LamfGetCreditLimitState {
  @override
  List<Object> get props => [];
}

class LamfGetCreditLimitSuccess extends LamfGetCreditLimitState {
  final GetLoanUserDetails getCreditLimitDetails;

  const LamfGetCreditLimitSuccess(this.getCreditLimitDetails);

  @override
  List<Object> get props => [];
}

class LamfGetCreditLimitFailure extends LamfGetCreditLimitState {
  final String? errorMessage;
  final AppErrorType errorType;

  const LamfGetCreditLimitFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
