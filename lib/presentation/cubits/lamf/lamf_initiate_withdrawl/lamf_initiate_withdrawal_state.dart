part of 'lamf_initiate_withdrawal_cubit.dart';

sealed class LamfInitiateWithdrawalState extends Equatable {
  const LamfInitiateWithdrawalState();
}

final class LamfInitiateWithdrawalInitial extends LamfInitiateWithdrawalState {
  @override
  List<Object> get props => [];
}

final class LamfInitiateWithdrawalLoading extends LamfInitiateWithdrawalState {
  @override
  List<Object> get props => [];
}

final class LamfInitiateWithdrawalSuccess extends LamfInitiateWithdrawalState {
  const LamfInitiateWithdrawalSuccess(
      {required this.initiateWithdrawalDetails});
  final InitiateWithdrawalDetails initiateWithdrawalDetails;

  @override
  List<Object> get props => [initiateWithdrawalDetails];
}

final class LamfInitiateWithdrawalFailure extends LamfInitiateWithdrawalState {
  final String? errorMessage;
  final AppErrorType errorType;

  const LamfInitiateWithdrawalFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
