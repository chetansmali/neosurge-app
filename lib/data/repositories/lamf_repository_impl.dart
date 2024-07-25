import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/lamf_repository.dart';
import '../data_sources/remote/lamf_remote_data_source.dart';
import '../models/lamf/avail_loan_details.dart';
import '../models/lamf/get_loan_data_details.dart';
import '../models/lamf/get_loan_user_details.dart';
import '../models/lamf/get_pledged_funds_details.dart';
import '../models/lamf/get_transactions_details.dart';
import '../models/lamf/import_loans_details.dart';
import '../models/lamf/initiate_loan_closure_details.dart';
import '../models/lamf/initiate_payment_details.dart';
import '../models/lamf/initiate_withdrawal_details.dart';
import '../models/lamf/loan_closure_details.dart';
import '../models/lamf/update_loan_status_details.dart';
import '../models/lamf/get_import_landing_page_model.dart';
import '../models/lamf/get_init_loan_import_response.dart';
import '../models/lamf/get_loan_data_response.dart';
import '../models/lamf/loan_import_details_response.dart';

@LazySingleton(as: LAMFRepository)
class LAMFRepositoryImpl implements LAMFRepository {
  final LAMFRemoteDataSource _lAMFRemoteDataSource;

  LAMFRepositoryImpl(this._lAMFRemoteDataSource);

  @override
  Future<Either<AppError, GetLoanUserDetails>> getLoanUser() {
    return ApiCallWithError.call(() => _lAMFRemoteDataSource.getLoanUser());
  }

  @override
  Future<Either<AppError, AvailLoanDetails>> getAvailLoan() {
    return ApiCallWithError.call(() => _lAMFRemoteDataSource.getAvailLoans());
  }

  @override
  Future<Either<AppError, GetLoanUserDetails>> getCreditLimit() {
    return ApiCallWithError.call(() => _lAMFRemoteDataSource.getCreditLimit());
  }

  @override
  Future<Either<AppError, ImportLoansDetails>> getImportLoans() {
    return ApiCallWithError.call(() => _lAMFRemoteDataSource.getImportLoans());
  }

  @override
  Future<Either<AppError, GetLoanDataDetails>> getLoanData() {
    return ApiCallWithError.call(() => _lAMFRemoteDataSource.getLoanData());
  }

  @override
  Future<Either<AppError, GetPledgedFundsDetails>> getPledgedFunds() {
    return ApiCallWithError.call(() => _lAMFRemoteDataSource.getPledgedFunds());
  }

  @override
  Future<Either<AppError, GetTransactionsDetails>> getTransactions() {
    return ApiCallWithError.call(() => _lAMFRemoteDataSource.getTransactions());
  }

  @override
  Future<Either<AppError, InitiatePaymentDetails>> initiatePayment() {
    return ApiCallWithError.call(() => _lAMFRemoteDataSource.initiatePayment());
  }

  @override
  Future<Either<AppError, InitiateWithdrawalDetails>> initiateWithdrawal() {
    return ApiCallWithError.call(
        () => _lAMFRemoteDataSource.initiateWithdrawal());
  }

  @override
  Future<Either<AppError, InitiateLoanClosureDetails>> initiateLoanClosure() {
    return ApiCallWithError.call(
        () => _lAMFRemoteDataSource.initiateLoanClosure());
  }

  @override
  Future<Either<AppError, LoanClosureDetails>> loanClosure() {
    return ApiCallWithError.call(() => _lAMFRemoteDataSource.loanClosure());
  }

  @override
  Future<Either<AppError, UpdateLoanStatusDetails>> updateLoanStatus(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _lAMFRemoteDataSource.updateLoanStatus(params));
  }

  @override
  Future<Either<AppError, GetInitiateLoanImportResponse>> getInitiateLoanImport(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _lAMFRemoteDataSource.getInitiateLoanImport(params));
  }

  @override
  Future<Either<AppError, LoanImportDetailsModel>> getLoanImportDetails() {
    return ApiCallWithError.call(
        () => _lAMFRemoteDataSource.getLoanImportDetails());
  }

  @override
  Future<Either<AppError, GetImportLandingPageResponse>> submitImportOtp(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _lAMFRemoteDataSource.submitImportOtp(params));
  }

  @override
  Future<Either<AppError, GetLoanDataResponse>> getImportLoanData(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _lAMFRemoteDataSource.getImportLoanData(params));
  }

  @override
  Future<Either<AppError, GetImportLandingPageResponse>> getLAMFLandingPage() {
    return ApiCallWithError.call(
        () => _lAMFRemoteDataSource.getLAMFLandingPage());
  }

  @override
  Future<Either<AppError, GetImportLandingPageResponse>> getCibilRefresh() {
    return ApiCallWithError.call(() => _lAMFRemoteDataSource.getCibilRefresh());
  }
}
