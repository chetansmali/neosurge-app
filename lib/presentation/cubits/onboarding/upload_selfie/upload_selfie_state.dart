part of 'upload_selfie_cubit.dart';

abstract class UploadSelfieState extends Equatable {
  const UploadSelfieState();
}

class UploadSelfieInitial extends UploadSelfieState {
  @override
  List<Object> get props => [];
}

class UploadSelfieLoading extends UploadSelfieState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;

  const UploadSelfieLoading({this.isFetch = false});

  @override
  List<Object> get props => [];
}

///This state will be used to indicate that data is uploaded to server successfully.
class UploadSelfieSuccess extends UploadSelfieState {
  final bool isFetch;
  final File? selfie;

  const UploadSelfieSuccess({this.isFetch = false, this.selfie});

  @override
  List<Object> get props => [];
}

class UploadSelfieFailure extends UploadSelfieState {
  //This state will be emitted in case of fetching of data/ uploading of data fails.
  final bool isFetch;
  final AppErrorType errorType;
  final String? errorMessage;

  const UploadSelfieFailure({
    this.isFetch = false,
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
