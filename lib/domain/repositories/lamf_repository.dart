import 'package:dartz/dartz.dart';
import '../../data/models/lamf/avail_loan_details.dart';
import '../../data/models/lamf/get_loan_user_details.dart';
import '../../data/models/lamf/import_loans_details.dart';
import '../../data/models/lamf/update_loan_status_details.dart';
import '../../data/models/lamf/get_loan_data_details.dart';
import '../../data/models/lamf/get_pledged_funds_details.dart';
import '../../data/models/lamf/get_transactions_details.dart';
import '../../data/models/lamf/initiate_payment_details.dart';
import '../../data/models/lamf/initiate_withdrawal_details.dart';
import '../../data/models/lamf/initiate_loan_closure_details.dart';
import '../../data/models/lamf/loan_closure_details.dart';

import '../../data/models/lamf/get_import_landing_page_model.dart';
import '../../data/models/lamf/get_init_loan_import_response.dart';
import '../../data/models/lamf/get_loan_data_response.dart';
import '../../data/models/lamf/loan_import_details_response.dart';
import '../entities/app_error.dart';

abstract class LAMFRepository {
  Future<Either<AppError, GetLoanUserDetails>> getLoanUser();
  Future<Either<AppError, GetLoanUserDetails>> getCreditLimit();
  Future<Either<AppError, ImportLoansDetails>> getImportLoans();
  Future<Either<AppError, AvailLoanDetails>> getAvailLoan();

  Future<Either<AppError, UpdateLoanStatusDetails>> updateLoanStatus(
      Map<String, dynamic> params);
  Future<Either<AppError, GetLoanDataDetails>> getLoanData();
  Future<Either<AppError, GetPledgedFundsDetails>> getPledgedFunds();
  Future<Either<AppError, GetTransactionsDetails>> getTransactions();
  Future<Either<AppError, InitiatePaymentDetails>> initiatePayment();
  Future<Either<AppError, InitiateWithdrawalDetails>> initiateWithdrawal();
  Future<Either<AppError, InitiateLoanClosureDetails>> initiateLoanClosure();
  Future<Either<AppError, LoanClosureDetails>> loanClosure();

  Future<Either<AppError, GetInitiateLoanImportResponse>> getInitiateLoanImport(
      Map<String, dynamic> params);

  Future<Either<AppError, LoanImportDetailsModel>> getLoanImportDetails();

  Future<Either<AppError, GetImportLandingPageResponse>> submitImportOtp(
      Map<String, dynamic> params);

  Future<Either<AppError, GetLoanDataResponse>> getImportLoanData(
      Map<String, dynamic> params);

  Future<Either<AppError, GetImportLandingPageResponse>> getLAMFLandingPage();

  Future<Either<AppError, GetImportLandingPageResponse>> getCibilRefresh();
}
