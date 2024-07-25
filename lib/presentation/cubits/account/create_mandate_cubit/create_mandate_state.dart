part of 'create_mandate_cubit.dart';

abstract class CreateMandateState extends Equatable {
  const CreateMandateState();
}

class CreateMandateInitial extends CreateMandateState {
  @override
  List<Object> get props => [];
}

class CreateMandateLoading extends CreateMandateState {
  @override
  List<Object> get props => [];
}

class CreateMandateSuccess extends CreateMandateState {
  final UserMandate mandate;

  const CreateMandateSuccess({required this.mandate});

  @override
  List<Object> get props => [mandate];
}

class CreateMandateError extends CreateMandateState {
  final String? error;
  final AppErrorType errorType;

  const CreateMandateError({required this.error, required this.errorType});

  @override
  List<Object?> get props => [error, errorType];
}
