part of 'upload_adhaar_number_cubit.dart';

abstract class UploadAadhaarNumberState extends Equatable {
  const UploadAadhaarNumberState();
}

class UploadAadhaarNumberInitial extends UploadAadhaarNumberState {
  @override
  List<Object> get props => [];
}

class UploadAadhaarNumberLoading extends UploadAadhaarNumberState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;

  const UploadAadhaarNumberLoading({this.isFetch = false});

  @override
  List<Object> get props => [isFetch];
}

class UploadAadhaarNumberSuccess extends UploadAadhaarNumberState {
  final bool isFetch;
  final String? adhaarNumber;

  const UploadAadhaarNumberSuccess({this.isFetch = false, this.adhaarNumber});

  @override
  List<Object?> get props => [isFetch, adhaarNumber];
}

class UploadAadhaarNumberFailure extends UploadAadhaarNumberState {
  //This state will be emitted in case of fetching of data/ uploading of data fails.
  final bool isFetch;
  final String? errorMessage;
  final AppErrorType errorType;

  const UploadAadhaarNumberFailure({this.errorMessage, required this.errorType, this.isFetch = false});

  @override
  List<Object?> get props => [errorMessage, errorType, isFetch];
}
