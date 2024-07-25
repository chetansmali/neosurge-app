part of 'upload_personal_details_cubit.dart';

abstract class UploadPersonalDetailsState extends Equatable {
  const UploadPersonalDetailsState();
}

class UploadPersonalDetailsInitial extends UploadPersonalDetailsState {
  @override
  List<Object> get props => [];
}

class UploadPersonalDetailsLoading extends UploadPersonalDetailsState {
  ///[isFetch] will be true if the data has to be fetched from the data source to prefill.
  final bool isFetch;

  const UploadPersonalDetailsLoading({this.isFetch = false});

  @override
  List<Object> get props => [isFetch];
}

///This state will be used to indicate that data is uploaded to server successfully.
class UploadPersonalDetailsSuccess extends UploadPersonalDetailsState {
  final bool isFetch;
  final GetKycPersonalDetailsModel? getKycPersonalDetailsModel;

  const UploadPersonalDetailsSuccess({this.isFetch = false, this.getKycPersonalDetailsModel});

  @override
  List<Object?> get props => [isFetch, getKycPersonalDetailsModel];
}

class UploadPersonalDetailsFailure extends UploadPersonalDetailsState {
  //This state will be emitted in case of fetching of data/ uploading of data fails.
  final bool isFetch;
  final AppErrorType errorType;
  final String? errorMessage;

  const UploadPersonalDetailsFailure({
    this.isFetch = false,
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [isFetch, errorType, errorMessage];
}
