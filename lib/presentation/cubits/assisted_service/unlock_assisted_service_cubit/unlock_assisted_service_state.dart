part of 'unlock_assisted_service_cubit.dart';

abstract class UnlockAssistedServiceState extends Equatable {
  const UnlockAssistedServiceState();
}

class UnlockAssistedServiceInitial extends UnlockAssistedServiceState {
  @override
  List<Object> get props => [];
}

class UnlockAssistedServiceLoading extends UnlockAssistedServiceState {
  @override
  List<Object> get props => [];
}

class UnlockAssistedServiceSuccess extends UnlockAssistedServiceState {
  final UnlockAssistedServiceResponse response;

  const UnlockAssistedServiceSuccess({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class UnlockAssistedServiceFailure extends UnlockAssistedServiceState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const UnlockAssistedServiceFailure({
    this.errorMessage,
    required this.appErrorType,
  });

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
