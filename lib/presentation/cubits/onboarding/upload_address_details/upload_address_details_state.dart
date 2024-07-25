part of 'upload_address_details_cubit.dart';

abstract class UploadAddressDetailsState extends Equatable {
  const UploadAddressDetailsState();
}

class UploadAddressDetailsInitial extends UploadAddressDetailsState {
  @override
  List<Object> get props => [];
}

class UploadAddressDetailsLoading extends UploadAddressDetailsState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;

  const UploadAddressDetailsLoading({this.isFetch = false});

  @override
  List<Object> get props => [];
}

class UploadAddressDetailsSuccess extends UploadAddressDetailsState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;
  final GetKycAddressDetailsModel? kycAddressDetails;

  const UploadAddressDetailsSuccess({this.isFetch = false, this.kycAddressDetails});

  @override
  List<Object> get props => [];
}

class UploadAddressDetailsFailure extends UploadAddressDetailsState {
  //This state will be emitted in case of fetching of data/ uploading of data fails.
  final bool isFetch;
  final AppErrorType errorType;
  final String? errorMessage;

  const UploadAddressDetailsFailure({
    this.isFetch = false,
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
