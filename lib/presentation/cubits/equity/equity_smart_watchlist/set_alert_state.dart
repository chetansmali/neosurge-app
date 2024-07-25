part of 'set_alert_cubit.dart';

abstract class SetAlertState extends Equatable {
  const SetAlertState();
}

class SetAlertInitial extends SetAlertState {
  @override
  List<Object> get props => [];
}

class SetAlertLoading extends SetAlertState {
  @override
  List<Object> get props => [];
}

class SetAlertSuccess extends SetAlertState {
  final CreateAlertModel createAlertModel;
  const SetAlertSuccess(this.createAlertModel);
  @override
  List<Object> get props => [createAlertModel];
}

class SetAlertFailure extends SetAlertState {
  final String? errorMessage;
  final AppErrorType errorType;

  const SetAlertFailure({required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
