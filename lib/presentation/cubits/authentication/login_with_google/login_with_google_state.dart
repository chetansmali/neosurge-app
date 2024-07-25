part of 'login_with_google_cubit.dart';

abstract class LoginWithGoogleState extends Equatable {
  const LoginWithGoogleState();
}

class LoginWithGoogleInitial extends LoginWithGoogleState {
  @override
  List<Object> get props => [];
}

class LoginWithGoogleLoading extends LoginWithGoogleState {
  @override
  List<Object> get props => [];
}

class LoginWithGoogleSuccess extends LoginWithGoogleState {
  final GoogleSignInAccount googleSignInAccount;
  final String accessToken;

  const LoginWithGoogleSuccess(
      {required this.googleSignInAccount, required this.accessToken});

  @override
  List<Object> get props => [];
}

class LoginWithGoogleFailure extends LoginWithGoogleState {
  final String error;

  const LoginWithGoogleFailure({required this.error});

  @override
  List<Object> get props => [];
}
