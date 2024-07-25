part of 'submit_choices_cubit.dart';

abstract class SubmitChoicesState extends Equatable {
  const SubmitChoicesState();
}

class SubmitChoicesInitial extends SubmitChoicesState {
  @override
  List<Object> get props => [];
}

class SubmitChoicesLoading extends SubmitChoicesState {
  @override
  List<Object> get props => [];
}

class SubmitChoicesSuccess extends SubmitChoicesState {
  const SubmitChoicesSuccess();

  @override
  List<Object> get props => [];
}

class SubmitChoicesFailure extends SubmitChoicesState {
  final String? error;
  final AppErrorType errorType;

  const SubmitChoicesFailure(this.error, this.errorType);

  @override
  List<Object?> get props => [error, errorType];
}
