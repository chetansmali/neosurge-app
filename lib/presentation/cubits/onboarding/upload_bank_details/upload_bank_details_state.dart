part of 'upload_bank_details_cubit.dart';

abstract class UploadBankDetailsState extends Equatable {
  const UploadBankDetailsState();
}

class UploadBankDetailsInitial extends UploadBankDetailsState {
  @override
  List<Object> get props => [];
}

class UploadBankDetailsLoading extends UploadBankDetailsState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;

  const UploadBankDetailsLoading({this.isFetch = false});

  @override
  List<Object> get props => [];
}

class UploadBankDetailsSuccess extends UploadBankDetailsState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;
  final GetKycBankDetailsModel? bankDetails;

  const UploadBankDetailsSuccess({this.isFetch = false, this.bankDetails});

  @override
  List<Object> get props => [];
}

class UploadBankDetailsFailure extends UploadBankDetailsState {
  //This state will be emitted in case of fetching of data/ uploading of data fails.
  final bool isFetch;
  final AppErrorType errorType;
  final String? errorMessage;

  const UploadBankDetailsFailure({
    this.isFetch = false,
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object> get props => [];
}
