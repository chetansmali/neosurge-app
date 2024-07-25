part of 'authorise_mandate_cubit.dart';

abstract class AuthoriseMandateState extends Equatable {
  const AuthoriseMandateState();
}

class AuthoriseMandateInitial extends AuthoriseMandateState {
  @override
  List<Object> get props => [];
}

class AuthoriseMandateLoading extends AuthoriseMandateState {
  @override
  List<Object> get props => [];
}

class AuthoriseMandateLoaded extends AuthoriseMandateState {
  final UserMandate mandate;

  const AuthoriseMandateLoaded(this.mandate);

  @override
  List<Object> get props => [mandate];
}

class AuthoriseMandateLoadError extends AuthoriseMandateState {
  final AppErrorType errorType;
  final String? errorMessage;

  const AuthoriseMandateLoadError({required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
