part of 'get_user_alerts_cubit.dart';

abstract class GetUserAlertsState extends Equatable {
  const GetUserAlertsState();
}

class GetUserAlertsInitial extends GetUserAlertsState {
  @override
  List<Object> get props => [];
}

class GetUserAlertsLoading extends GetUserAlertsState {
  @override
  List<Object> get props => [];
}

class GetUserAlertsLoaded extends GetUserAlertsState {
  final GetUserAlertModel getUserAlertModel;
  const GetUserAlertsLoaded(this.getUserAlertModel);
  @override
  List<Object> get props => [getUserAlertModel];
}

class GetUserAlertsFailure extends GetUserAlertsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GetUserAlertsFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
