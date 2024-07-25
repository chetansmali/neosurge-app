part of 'verify_bank_account_cubit.dart';

abstract class VerifyBankAccountState extends Equatable {
  const VerifyBankAccountState();
}

class VerifyBankAccountInitial extends VerifyBankAccountState {
  @override
  List<Object> get props => [];
}

class VerifyBankAccountLoading extends VerifyBankAccountState {
  @override
  List<Object> get props => [];
}

class VerifyBankAccountFailed extends VerifyBankAccountState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const VerifyBankAccountFailed({required this.appErrorType, this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}

class VerifyBankAccountSuccess extends VerifyBankAccountState {
  @override
  List<Object?> get props => [];
}
