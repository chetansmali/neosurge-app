part of 'upload_nominee_details_cubit.dart';

abstract class UploadNomineeDetailsState extends Equatable {
  const UploadNomineeDetailsState();
}

class UploadNomineeDetailsInitial extends UploadNomineeDetailsState {
  @override
  List<Object> get props => [];
}

class UploadNomineeDetailsLoading extends UploadNomineeDetailsState {
  final bool isFetch;

  const UploadNomineeDetailsLoading({this.isFetch = false});

  @override
  List<Object> get props => [isFetch];
}

class UploadNomineeDetailsSuccess extends UploadNomineeDetailsState {
  final bool isFetch;
  final bool isDelete;
  final int? deleteIndex;
  final List<GetKycNomineeDetailsModel>? nomineeList;

  const UploadNomineeDetailsSuccess({this.isFetch = false, this.nomineeList, this.isDelete = false, this.deleteIndex});

  @override
  List<Object?> get props => [isFetch, nomineeList];
}

class UploadNomineeDetailsFailure extends UploadNomineeDetailsState {
  final bool isFetch;
  final AppErrorType appErrorType;
  final String? errorMessage;

  const UploadNomineeDetailsFailure({required this.appErrorType, this.errorMessage, this.isFetch = false});

  @override
  List<Object?> get props => [errorMessage, appErrorType, isFetch];
}
