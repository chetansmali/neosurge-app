part of 'non_kyc_create_account_cubit.dart';

abstract class NonKycCreateAccountState extends Equatable {
  const NonKycCreateAccountState();
}

class NonKycCreateAccountInitial extends NonKycCreateAccountState {
  @override
  List<Object> get props => [];
}

class NonKycCreateAccountLoading extends NonKycCreateAccountState {
  const NonKycCreateAccountLoading();

  @override
  List<Object?> get props => [];
}

class NonKycCreateAccountPartSuccess extends NonKycCreateAccountState {
  @override
  List<Object?> get props => [];
}

class NonKycCreateAccountSuccess extends NonKycCreateAccountState {
  @override
  List<Object> get props => [];
}

class NonKycCreateAccountFailure extends NonKycCreateAccountState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const NonKycCreateAccountFailure({required this.errorMessage, required this.appErrorType});

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
