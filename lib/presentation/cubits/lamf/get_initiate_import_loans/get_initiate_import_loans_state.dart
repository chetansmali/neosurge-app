part of 'get_initiate_import_loans_cubit.dart';

abstract class GetInitiateImportLoansState extends Equatable {
  const GetInitiateImportLoansState();
}

class GetInitiateImportLoansInitial extends GetInitiateImportLoansState {
  @override
  List<Object> get props => [];
}

class GetInitiateImportLoansLoading extends GetInitiateImportLoansState {
  @override
  List<Object> get props => [];
}

class GetInitiateImportLoansSuccess extends GetInitiateImportLoansState {
  final GetInitiateLoanImportResponse getInitiateLoanImportResponse;
  const GetInitiateImportLoansSuccess(
      {required this.getInitiateLoanImportResponse});

  @override
  List<Object> get props => [getInitiateLoanImportResponse];
}

class GetInitiateImportLoansFailure extends GetInitiateImportLoansState {
  final String? errorMessage;
  final AppErrorType errorType;

  const GetInitiateImportLoansFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
