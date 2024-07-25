part of 'delete_sip_cubit.dart';

abstract class DeleteSipState extends Equatable {
  const DeleteSipState();
}

class DeleteSipInitial extends DeleteSipState {
  @override
  List<Object> get props => [];
}

class DeleteSipLoading extends DeleteSipState {
  @override
  List<Object> get props => [];
}

class DeleteSipSuccess extends DeleteSipState {
  @override
  List<Object> get props => [];
}

class DeleteSipError extends DeleteSipState {
  const DeleteSipError({
    required this.appErrorType,
    this.message,
  });

  final AppErrorType appErrorType;
  final String? message;

  @override
  List<Object> get props => [];
}
