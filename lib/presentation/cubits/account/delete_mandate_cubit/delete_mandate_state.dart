part of 'delete_mandate_cubit.dart';

abstract class DeleteMandateState extends Equatable {
  const DeleteMandateState();
}

class DeleteMandateInitial extends DeleteMandateState {
  @override
  List<Object> get props => [];
}

class DeleteMandateLoading extends DeleteMandateState {
  @override
  List<Object> get props => [];
}

class DeleteMandateSuccess extends DeleteMandateState {
  final DeleteMandateModel deleteMandateModel;

  const DeleteMandateSuccess({
    required this.deleteMandateModel,
  });

  @override
  List<Object> get props => [];
}

class DeleteMandateError extends DeleteMandateState {
  final String? error;
  final AppErrorType errorType;

  const DeleteMandateError({required this.error, required this.errorType});

  @override
  List<Object> get props => [];
}
