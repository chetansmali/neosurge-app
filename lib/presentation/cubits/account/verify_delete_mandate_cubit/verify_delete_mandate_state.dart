part of 'verify_delete_mandate_cubit.dart';

abstract class VerifyDeleteMandateState extends Equatable {
  const VerifyDeleteMandateState();
}

class VerifyDeleteMandateInitial extends VerifyDeleteMandateState {
  @override
  List<Object> get props => [];
}

class VerifyDeleteMandateLoading extends VerifyDeleteMandateState {
  @override
  List<Object> get props => [];
}

class VerifyDeleteMandateSuccess extends VerifyDeleteMandateState {
  const VerifyDeleteMandateSuccess();

  @override
  List<Object> get props => [];
}

class VerifyDeleteMandateError extends VerifyDeleteMandateState {
  final String? errorMessage;
  final AppErrorType errorType;

  const VerifyDeleteMandateError({
    required this.errorMessage,
    required this.errorType,
  });

  @override
  List<Object> get props => [];
}
