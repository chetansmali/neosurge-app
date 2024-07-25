part of 'social_login_cubit.dart';

abstract class SocialLoginState extends Equatable {
  const SocialLoginState();
}

class SocialLoginInitial extends SocialLoginState {
  @override
  List<Object> get props => [];
}

class SocialLoginLoading extends SocialLoginState {
  @override
  List<Object> get props => [];
}

class SocialLoginSuccess extends SocialLoginState {
  final User user;

  const SocialLoginSuccess({required this.user});

  @override
  List<Object> get props => [];
}

class SocialLoginFailure extends SocialLoginState {
  final String? errorMessage;

  final AppErrorType errorType;

  const SocialLoginFailure({
    this.errorMessage,
    required this.errorType,
  });

  @override
  List<Object?> get props => [errorMessage, errorType];
}
