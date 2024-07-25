part of 'upload_proof_of_identity_cubit.dart';

abstract class UploadProofOfIdentityState extends Equatable {
  const UploadProofOfIdentityState();
}

class UploadProofOfIdentityInitial extends UploadProofOfIdentityState {
  @override
  List<Object> get props => [];
}

class UploadProofOfIdentityLoading extends UploadProofOfIdentityState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;

  const UploadProofOfIdentityLoading({
    this.isFetch = false,
  });

  @override
  List<Object> get props => [];
}

///This state will be used to indicate that data is uploaded to server successfully.
class UploadProofOfIdentitySuccess extends UploadProofOfIdentityState {
  final bool isFetch;
  final File? panImage;

  const UploadProofOfIdentitySuccess({this.isFetch = false, this.panImage});

  @override
  List<Object> get props => [];
}

class UploadProofOfIdentityFailure extends UploadProofOfIdentityState {
  //This state will be emitted in case of fetching of data/ uploading of data fails.
  final bool isFetch;
  final AppErrorType errorType;
  final String? errorMessage;

  const UploadProofOfIdentityFailure({
    this.isFetch = false,
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
