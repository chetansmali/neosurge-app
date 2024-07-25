part of 'upload_cheque_cubit.dart';

abstract class UploadCancelledChequeState extends Equatable {
  const UploadCancelledChequeState();
}

class UploadCancelledChequeInitial extends UploadCancelledChequeState {
  @override
  List<Object> get props => [];
}

class UploadCancelledChequeLoading extends UploadCancelledChequeState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;

  const UploadCancelledChequeLoading({this.isFetch = false});

  @override
  List<Object> get props => [];
}

class UploadCancelledChequeSuccess extends UploadCancelledChequeState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;
  final File? chequeImage;

  const UploadCancelledChequeSuccess({this.isFetch = false, this.chequeImage});

  @override
  List<Object> get props => [];
}

class UploadCancelledChequeFailure extends UploadCancelledChequeState {
  //This state will be emitted in case of fetching of data/ uploading of data fails.
  final bool isFetch;
  final AppErrorType errorType;
  final String? errorMessage;

  const UploadCancelledChequeFailure({
    this.isFetch = false,
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
