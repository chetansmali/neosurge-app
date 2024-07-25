part of 'upload_kyc_video_cubit.dart';

abstract class UploadKycVideoState extends Equatable {
  const UploadKycVideoState();
}

class UploadKycVideoInitial extends UploadKycVideoState {
  @override
  List<Object> get props => [];
}

class UploadKycVideoLoading extends UploadKycVideoState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;

  const UploadKycVideoLoading({this.isFetch = false});

  @override
  List<Object> get props => [];
}

///This state will be used to indicate that data is uploaded to server successfully.
class UploadKycVideoSuccess extends UploadKycVideoState {
  final bool isFetch;
  final File? kycVideoFile;

  const UploadKycVideoSuccess({this.isFetch = false, this.kycVideoFile});

  @override
  List<Object> get props => [];
}

class UploadKycVideoFailure extends UploadKycVideoState {
  //This state will be emitted in case of fetching of data/ uploading of data fails.
  final bool isFetch;
  final AppErrorType errorType;
  final String? errorMessage;

  const UploadKycVideoFailure({
    this.isFetch = false,
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
