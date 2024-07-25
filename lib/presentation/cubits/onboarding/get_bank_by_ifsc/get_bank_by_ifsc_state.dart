part of 'get_bank_by_ifsc_cubit.dart';

abstract class GetBankByIfscState extends Equatable {
  const GetBankByIfscState();
}

class GetBankByIfscInitial extends GetBankByIfscState {
  @override
  List<Object> get props => [];
}

class GetBankByIfscLoading extends GetBankByIfscState {
  @override
  List<Object> get props => [];
}

class GetBankByIfscSuccess extends GetBankByIfscState {
  final BankDetailsByIfscModel bank;

  const GetBankByIfscSuccess({required this.bank});

  @override
  List<Object> get props => [bank];
}

class GetBankByIfscFailure extends GetBankByIfscState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetBankByIfscFailure({required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
