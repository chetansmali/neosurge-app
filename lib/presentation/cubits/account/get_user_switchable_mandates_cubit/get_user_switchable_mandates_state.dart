part of 'get_user_switchable_mandates_cubit.dart';

abstract class GetUserSwitchableMandatesState extends Equatable {
  const GetUserSwitchableMandatesState();
}

class GetUserSwitchableMandatesInitial extends GetUserSwitchableMandatesState {
  const GetUserSwitchableMandatesInitial();

  @override
  List<Object> get props => [];
}

class GetUserSwitchableMandatesLoading extends GetUserSwitchableMandatesState {
  const GetUserSwitchableMandatesLoading();

  @override
  List<Object> get props => [];
}

class GetUserSwitchableMandatesLoaded extends GetUserSwitchableMandatesState {
  const GetUserSwitchableMandatesLoaded(this.mandates);

  final List<SwitchableMandateModel> mandates;

  @override
  List<Object> get props => [mandates];
}

class GetUserSwitchableMandatesError extends GetUserSwitchableMandatesState {
  const GetUserSwitchableMandatesError({
    required this.errorType,
    this.errorMessage,
  });

  final AppErrorType errorType;
  final String? errorMessage;

  @override
  List<Object> get props => [];
}
