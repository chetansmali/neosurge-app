part of 'upload_fatca_details_cubit.dart';

abstract class UploadFatcaDetailsState extends Equatable {
  const UploadFatcaDetailsState();
}

class UploadFatcaDetailsInitial extends UploadFatcaDetailsState {
  @override
  List<Object> get props => [];
}

class UploadFatcaDetailsLoading extends UploadFatcaDetailsState {
  final bool isFetch;

  const UploadFatcaDetailsLoading({this.isFetch = false});

  @override
  List<Object> get props => [];
}

class UploadFatcaDetailsSuccess extends UploadFatcaDetailsState {
  final bool isFetch;
  final GetKycFatcaDetailsModel? fatcaDetails;

  const UploadFatcaDetailsSuccess({this.isFetch = false, this.fatcaDetails});

  @override
  List<Object> get props => [];
}

class UploadFatcaDetailsFailure extends UploadFatcaDetailsState {
  final String? errorMessage;
  final AppErrorType appErrorType;
  final bool isFetch;

  const UploadFatcaDetailsFailure({this.errorMessage, required this.appErrorType, this.isFetch = false});

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
