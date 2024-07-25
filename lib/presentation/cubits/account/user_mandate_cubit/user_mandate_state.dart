part of 'user_mandate_cubit.dart';

abstract class UserMandateState extends Equatable {
  const UserMandateState();
}

class UserMandateInitial extends UserMandateState {
  @override
  List<Object> get props => [];
}

class UserMandateLoading extends UserMandateState {
  @override
  List<Object> get props => [];
}

class UserMandateLoaded extends UserMandateState {
  final List<UserBankMandateModel> mandates;

  const UserMandateLoaded(this.mandates);

  @override
  List<Object?> get props => [];
}

class UserMandateLoadError extends UserMandateState {
  final AppErrorType errorType;
  final String? errorMessage;

  const UserMandateLoadError({required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
