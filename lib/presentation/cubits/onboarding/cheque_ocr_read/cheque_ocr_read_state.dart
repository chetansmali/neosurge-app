part of 'cheque_ocr_read_cubit.dart';

abstract class ChequeOcrReadState extends Equatable {
  const ChequeOcrReadState();
}

class ChequeOcrReadInitial extends ChequeOcrReadState {
  @override
  List<Object> get props => [];
}

class ChequeOcrReadLoading extends ChequeOcrReadState {
  @override
  List<Object> get props => [];
}

class ChequeOcrReadLoaded extends ChequeOcrReadState {
  final ChequeOcrReadResponseModel chequeOcrResponse;

  const ChequeOcrReadLoaded({required this.chequeOcrResponse});

  @override
  List<Object> get props => [chequeOcrResponse];
}

class ChequeOcrReadFailure extends ChequeOcrReadState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const ChequeOcrReadFailure({required this.appErrorType, this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
