part of 'remove_alert_cubit.dart';

abstract class RemoveAlertState extends Equatable {
  const RemoveAlertState();
}

class RemoveAlertInitial extends RemoveAlertState {
  @override
  List<Object> get props => [];
}

class RemoveAlertLoading extends RemoveAlertState {
  @override
  List<Object> get props => [];
}

class RemoveAlertLoaded extends RemoveAlertState {
  RemoveAlertModel removeAlertModel;

  RemoveAlertLoaded(this.removeAlertModel);
  @override
  List<Object> get props => [removeAlertModel];
}

class RemoveAlertFailure extends RemoveAlertState {
  final String? errorMessage;
  final AppErrorType errorType;

  const RemoveAlertFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
