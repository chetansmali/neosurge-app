part of 'user_bank_details_cubit.dart';

abstract class UserBankDetailsState extends Equatable {
  const UserBankDetailsState();
}

class UserBankDetailsInitial extends UserBankDetailsState {
  @override
  List<Object> get props => [];
}

class UserBankDetailsLoading extends UserBankDetailsState {
  @override
  List<Object> get props => [];
}

class UserBankDetailsLoaded extends UserBankDetailsState {
  final List<UserBank> bankList;

  const UserBankDetailsLoaded(this.bankList);

  @override
  List<Object> get props => [bankList];
}

class UserBankDetailsLoadError extends UserBankDetailsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const UserBankDetailsLoadError({
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
