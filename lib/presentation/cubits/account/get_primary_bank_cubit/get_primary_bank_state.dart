part of 'get_primary_bank_cubit.dart';

abstract class GetPrimaryBankState extends Equatable {
  const GetPrimaryBankState();
}

class GetPrimaryBankInitial extends GetPrimaryBankState {
  @override
  List<Object> get props => [];
}

class GetPrimaryBankLoading extends GetPrimaryBankState {
  @override
  List<Object> get props => [];
}

class GetPrimaryBankLoaded extends GetPrimaryBankState {
  final UserBank bankDetails;

  const GetPrimaryBankLoaded(this.bankDetails);

  @override
  List<Object> get props => [bankDetails];
}

class GetPrimaryBankLoadError extends GetPrimaryBankState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetPrimaryBankLoadError(this.errorType, this.errorMessage);

  @override
  List<Object?> get props => [errorType, errorMessage];
}
