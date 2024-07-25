part of 'lamf_import_loans_cubit.dart';

abstract class LamfImportLoansState extends Equatable {
  const LamfImportLoansState();
}

class LamfImportLoansInitial extends LamfImportLoansState {
  @override
  List<Object> get props => [];
}

class LamfImportLoansLoading extends LamfImportLoansState {
  @override
  List<Object> get props => [];
}

class LamfImportLoansSuccess extends LamfImportLoansState {
  final ImportLoansDetails importLoansDetails;
  const LamfImportLoansSuccess(this.importLoansDetails);
  @override
  List<Object> get props => [];
}

class LamfImportLoansFailure extends LamfImportLoansState {
  final String? errorMessage;
  final AppErrorType errorType;

  const LamfImportLoansFailure(this.errorMessage, this.errorType);
  @override
  List<Object?> get props => [errorMessage, errorType];
}
