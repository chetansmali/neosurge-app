part of 'update_bank_ifsc_cubit.dart';

abstract class UpdateBankIfscState extends Equatable {
  const UpdateBankIfscState();
}

class UpdateBankIfscInitial extends UpdateBankIfscState {
  @override
  List<Object> get props => [];
}

class UpdateBankIfscLoading extends UpdateBankIfscState {
  @override
  List<Object> get props => [];
}

class UpdateBankIfscSuccess extends UpdateBankIfscState {
  final UserBank bank;

  const UpdateBankIfscSuccess({required this.bank});

  @override
  List<Object> get props => [];
}

class UpdateBankIfscFailure extends UpdateBankIfscState {
  final AppErrorType errorType;
  final String? error;

  const UpdateBankIfscFailure({required this.errorType, this.error});

  @override
  List<Object?> get props => [errorType, error];
}
