part of 'verify_assisted_service_pin_cubit.dart';

abstract class VerifyAssistedServicePinState extends Equatable {
  const VerifyAssistedServicePinState();
}

class VerifyAssistedServicePinInitial extends VerifyAssistedServicePinState {
  @override
  List<Object> get props => [];
}

class VerifyAssistedServicePinLoading extends VerifyAssistedServicePinState {
  @override
  List<Object> get props => [];
}

class VerifyAssistedServicePinSuccess extends VerifyAssistedServicePinState {
  final VerifyAssistedServicePinResponse response;

  const VerifyAssistedServicePinSuccess({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class VerifyAssistedServicePinFailure extends VerifyAssistedServicePinState {
  final AppErrorType errorType;
  final String? errorMessage;

  const VerifyAssistedServicePinFailure({required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
