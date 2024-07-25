part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final User? user;

  const AuthState({this.user});
}

class UpdateApp extends AuthState {
  final AppVersionResult appVersionUpdateResult;

  const UpdateApp(this.appVersionUpdateResult);

  @override
  List<Object?> get props => [appVersionUpdateResult];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final User newUser;
  final bool serverAuthenticated;

  const Authenticated({required this.newUser, this.serverAuthenticated = false}) : super(user: newUser);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthError extends AuthState {
  final String? message;
  final AppErrorType errorType;

  const AuthError(this.errorType, this.message, final User oldUser) : super(user: oldUser);

  @override
  List<Object?> get props => [message, errorType];
}
