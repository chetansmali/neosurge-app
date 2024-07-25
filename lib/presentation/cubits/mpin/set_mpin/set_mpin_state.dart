part of 'set_mpin_cubit.dart';

abstract class SetMPinState extends Equatable {
  const SetMPinState();
}

class SetMPinInitial extends SetMPinState {
  @override
  List<Object> get props => [];
}

class SetMPinLoading extends SetMPinState {
  @override
  List<Object> get props => [];
}

class SetMPinSuccess extends SetMPinState {
  @override
  List<Object> get props => [];
}

class SetMPinFailure extends SetMPinState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const SetMPinFailure({this.errorMessage, required this.appErrorType});

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
