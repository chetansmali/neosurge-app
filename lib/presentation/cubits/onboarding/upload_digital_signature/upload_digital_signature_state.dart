part of 'upload_digital_signature_cubit.dart';

abstract class UploadDigitalSignatureState extends Equatable {
  const UploadDigitalSignatureState();
}

class UploadDigitalSignatureInitial extends UploadDigitalSignatureState {
  @override
  List<Object> get props => [];
}

class UploadDigitalSignatureLoading extends UploadDigitalSignatureState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;

  const UploadDigitalSignatureLoading({this.isFetch = false});

  @override
  List<Object> get props => [];
}

class UploadDigitalSignatureSuccess extends UploadDigitalSignatureState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;
  final File? signature;
  final Uint8List? signatureBytes;

  const UploadDigitalSignatureSuccess({this.isFetch = false, this.signature, this.signatureBytes});

  @override
  List<Object> get props => [];
}

class UploadDigitalSignatureFailure extends UploadDigitalSignatureState {
  //This state will be emitted in case of fetching of data/ uploading of data fails.
  final bool isFetch;
  final AppErrorType errorType;
  final String? errorMessage;

  const UploadDigitalSignatureFailure({
    this.isFetch = false,
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
