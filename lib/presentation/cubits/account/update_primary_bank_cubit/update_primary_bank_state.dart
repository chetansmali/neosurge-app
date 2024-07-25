part of 'update_primary_bank_cubit.dart';

abstract class UpdatePrimaryBankState extends Equatable {
  const UpdatePrimaryBankState();
}

class UpdatePrimaryBankInitial extends UpdatePrimaryBankState {
  @override
  List<Object> get props => [];
}

class UpdatePrimaryBankLoading extends UpdatePrimaryBankState {
  @override
  List<Object> get props => [];
}

class UpdatePrimaryBankSuccess extends UpdatePrimaryBankState {
  final int index;

  const UpdatePrimaryBankSuccess(this.index);

  @override
  List<Object> get props => [];
}

class UpdatePrimaryBankError extends UpdatePrimaryBankState {
  final String? errorMessage;
  final AppErrorType errorType;

  const UpdatePrimaryBankError({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
