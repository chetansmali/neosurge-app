part of 'loan_import_details_cubit.dart';

sealed class LoanImportDetailsState extends Equatable {
  final LoanImportDetailsModel? loanImportDetailsModel;

  const LoanImportDetailsState({this.loanImportDetailsModel});

  @override
  List<Object?> get props => [loanImportDetailsModel];
}

final class LoanImportDetailsInitial extends LoanImportDetailsState {
  @override
  List<Object> get props => [];
}

final class LoanImportDetailsLoading extends LoanImportDetailsState {
  @override
  List<Object> get props => [];
}

final class LoanImportDetailsSuccess extends LoanImportDetailsState {
  final LoanImportDetailsModel loanImportDetailsResponse;

  const LoanImportDetailsSuccess({required this.loanImportDetailsResponse});

  @override
  List<Object> get props => [loanImportDetailsResponse];
}

final class LoanImportDetailsFailure extends LoanImportDetailsState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const LoanImportDetailsFailure(
      {this.errorMessage, required this.appErrorType});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
