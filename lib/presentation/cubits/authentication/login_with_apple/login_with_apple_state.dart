part of 'login_with_apple_cubit.dart';

abstract class LoginWithAppleState extends Equatable {
  const LoginWithAppleState();
}

class LoginWithAppleInitial extends LoginWithAppleState {
  @override
  List<Object> get props => [];
}

class LoginWithAppleLoading extends LoginWithAppleState {
  @override
  List<Object> get props => [];
}

class LoginWithAppleSuccess extends LoginWithAppleState {
  final AuthorizationCredentialAppleID appleSignInAccount;

  const LoginWithAppleSuccess({
    required this.appleSignInAccount,
  });

  @override
  List<Object> get props => [];
}

class LoginWithAppleFailure extends LoginWithAppleState {
  final String error;

  const LoginWithAppleFailure({required this.error});

  @override
  List<Object> get props => [];
}
