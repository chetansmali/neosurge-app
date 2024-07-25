part of 'add_user_bank_cubit.dart';

abstract class AddUserBankState extends Equatable {
  const AddUserBankState();
}

class AddUserBankInitial extends AddUserBankState {
  @override
  List<Object> get props => [];
}

class AddUserBankLoading extends AddUserBankState {
  @override
  List<Object> get props => [];
}

class AddUserBankSuccess extends AddUserBankState {
  final UserBank userBank;

  const AddUserBankSuccess({required this.userBank});

  @override
  List<Object> get props => [userBank];
}

class AddUserBankError extends AddUserBankState {
  final String? errorMessage;
  final AppErrorType errorType;

  const AddUserBankError({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
