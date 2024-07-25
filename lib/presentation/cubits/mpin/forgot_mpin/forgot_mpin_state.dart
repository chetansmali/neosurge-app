part of 'forgot_mpin_cubit.dart';

abstract class ForgotMPinState extends Equatable {
  const ForgotMPinState();
}

class ForgotMPinInitial extends ForgotMPinState {
  @override
  List<Object> get props => [];
}

class ForgotMPinLoading extends ForgotMPinState {
  @override
  List<Object> get props => [];
}

class ForgotMPinSuccess extends ForgotMPinState {
  final bool isVerify;

  const ForgotMPinSuccess({this.isVerify = false});

  @override
  List<Object> get props => [isVerify];
}

class ForgotMPinFailure extends ForgotMPinState {
  final AppErrorType appErrorType;
  final String? errorMessage;
  final bool isVerify;

  const ForgotMPinFailure({required this.appErrorType, this.errorMessage, this.isVerify = false});

  @override
  List<Object?> get props => [appErrorType, errorMessage, isVerify];
}
