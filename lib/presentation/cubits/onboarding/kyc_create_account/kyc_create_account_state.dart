part of 'kyc_create_account_cubit.dart';

abstract class KycCreateAccountState extends Equatable {
  const KycCreateAccountState();
}

class KycCreateAccountInitial extends KycCreateAccountState {
  @override
  List<Object> get props => [];
}

class KycCreateAccountLoading extends KycCreateAccountState {
  final AccountCreationStep? accountCreationStep;

  const KycCreateAccountLoading({
    this.accountCreationStep,
  });

  @override
  List<Object?> get props => [accountCreationStep];
}

class KycCreateAccountSuccess extends KycCreateAccountState {
  const KycCreateAccountSuccess();

  @override
  List<Object> get props => [];
}

class KycCreateAccountFailure extends KycCreateAccountState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const KycCreateAccountFailure({required this.errorMessage, required this.appErrorType});

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
