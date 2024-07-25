part of 'mpin_login_cubit.dart';

abstract class MPinLoginState extends Equatable {
  const MPinLoginState();
}

class MPinLoginInitial extends MPinLoginState {
  @override
  List<Object> get props => [];
}

class MPinLoginLoading extends MPinLoginState {
  @override
  List<Object> get props => [];
}

class MPinLoginSuccess extends MPinLoginState {
  final User user;

  const MPinLoginSuccess({required this.user});

  @override
  List<Object> get props => [];
}

class MPinLoginFailure extends MPinLoginState {
  final String? errorMessage;
  final AppErrorType errorType;

  const MPinLoginFailure({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
