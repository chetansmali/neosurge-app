part of 'upload_proof_of_address_cubit.dart';

abstract class UploadProofOfAddressState extends Equatable {
  const UploadProofOfAddressState();
}

class UploadProofOfAddressInitial extends UploadProofOfAddressState {
  @override
  List<Object> get props => [];
}

class UploadProofOfAddressLoading extends UploadProofOfAddressState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;

  const UploadProofOfAddressLoading({this.isFetch = false});

  @override
  List<Object> get props => [];
}

///This state will be used to indicate that data is uploaded to server successfully.
class UploadProofOfAddressSuccess extends UploadProofOfAddressState {
  final bool isFetch;
  final UploadProofOfAddressParams? uploadProofOfAddressParams;

  const UploadProofOfAddressSuccess({this.isFetch = false, this.uploadProofOfAddressParams});

  @override
  List<Object> get props => [];
}

class UploadProofOfAddressFailure extends UploadProofOfAddressState {
  //This state will be emitted in case of fetching of data/ uploading of data fails.
  final bool isFetch;
  final AppErrorType errorType;
  final String? errorMessage;

  const UploadProofOfAddressFailure({
    this.isFetch = false,
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
