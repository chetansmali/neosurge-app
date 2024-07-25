import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../models/lamf/avail_loan_details.dart';
import '../../models/lamf/get_loan_data_details.dart';
import '../../models/lamf/get_loan_user_details.dart';
import '../../models/lamf/get_pledged_funds_details.dart';
import '../../models/lamf/get_transactions_details.dart';
import '../../models/lamf/import_loans_details.dart';
import '../../models/lamf/initiate_loan_closure_details.dart';
import '../../models/lamf/initiate_payment_details.dart';
import '../../models/lamf/initiate_withdrawal_details.dart';
import '../../models/lamf/loan_closure_details.dart';
import '../../models/lamf/update_loan_status_details.dart';

import '../../models/lamf/get_import_landing_page_model.dart';
import '../../models/lamf/get_init_loan_import_response.dart';
import '../../models/lamf/get_loan_data_response.dart';
import '../../models/lamf/loan_import_details_response.dart';

abstract class LAMFRemoteDataSource {
  Future<GetLoanUserDetails> getLoanUser();

  Future<GetLoanUserDetails> getCreditLimit();
  Future<ImportLoansDetails> getImportLoans();
  Future<AvailLoanDetails> getAvailLoans();

  Future<UpdateLoanStatusDetails> updateLoanStatus(Map<String, dynamic> params);
  Future<GetLoanDataDetails> getLoanData();
  Future<GetPledgedFundsDetails> getPledgedFunds();
  Future<GetTransactionsDetails> getTransactions();
  Future<InitiatePaymentDetails> initiatePayment();
  Future<InitiateWithdrawalDetails> initiateWithdrawal();
  Future<InitiateLoanClosureDetails> initiateLoanClosure();
  Future<LoanClosureDetails> loanClosure();

  Future<GetInitiateLoanImportResponse> getInitiateLoanImport(
      Map<String, dynamic> params);

  Future<LoanImportDetailsModel> getLoanImportDetails();

  Future<GetImportLandingPageResponse> submitImportOtp(
      Map<String, dynamic> params);

  Future<GetLoanDataResponse> getImportLoanData(Map<String, dynamic> params);

  Future<GetImportLandingPageResponse> getLAMFLandingPage();

  Future<GetImportLandingPageResponse> getCibilRefresh();
}

@LazySingleton(as: LAMFRemoteDataSource)
class LAMFRemoteDataSourceImpl implements LAMFRemoteDataSource {
  final ApiClient _client;

  LAMFRemoteDataSourceImpl(this._client);

  @override
  Future<GetLoanUserDetails> getLoanUser() async {
    final response =
        await _client.get(ApiConstants.getLoanUser, extractData: false);
    return GetLoanUserDetails.fromJson(response);
  }

  Future<AvailLoanDetails> getAvailLoans() async {
    final response =
        await _client.get(ApiConstants.availLoan, extractData: false);

    return AvailLoanDetails.fromJson(response);
  }

  Future<GetLoanUserDetails> getCreditLimit() async {
    final response =
        await _client.get(ApiConstants.getCreditLimit, extractData: false);
    return GetLoanUserDetails.fromJson(response);
  }

  @override
  Future<ImportLoansDetails> getImportLoans() async {
    final response =
        await _client.get(ApiConstants.getLAMFLandingPage, extractData: false);
    return ImportLoansDetails.fromJson(response);
  }

  @override
  Future<GetInitiateLoanImportResponse> getInitiateLoanImport(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.getInitiateloanimport,
        params: params, extractData: false);
    return GetInitiateLoanImportResponse.fromJson(response);
  }

  @override
  Future<LoanImportDetailsModel> getLoanImportDetails() async {
    final response = await _client.get(ApiConstants.getLoanImportDetails,
        extractData: false);
    return LoanImportDetailsModel.fromJson(response);
  }

  @override
  Future<GetImportLandingPageResponse> submitImportOtp(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.submitImportOtp,
        params: params, extractData: false);
    return GetImportLandingPageResponse.fromJson(response);
  }

  @override
  Future<GetLoanDataResponse> getImportLoanData(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.getImportLoanData,
        params: params, extractData: false);
    return GetLoanDataResponse.fromJson(response);
  }

  @override
  Future<GetImportLandingPageResponse> getLAMFLandingPage() async {
    final response =
        await _client.get(ApiConstants.getLAMFLandingPage, extractData: false);
    return GetImportLandingPageResponse.fromJson(response);
  }

  @override
  Future<GetImportLandingPageResponse> getCibilRefresh() async {
    final response =
        await _client.get(ApiConstants.getCibilRefresh, extractData: false);
    return GetImportLandingPageResponse.fromJson(response);
  }

  @override
  Future<GetLoanDataDetails> getLoanData() async {
    final response =
        await _client.get(ApiConstants.getLoanData, extractData: false);
    return GetLoanDataDetails.fromJson(response);
  }

  @override
  Future<GetPledgedFundsDetails> getPledgedFunds() async {
    final response =
        await _client.get(ApiConstants.getPledgedFunds, extractData: false);
    return GetPledgedFundsDetails.fromJson(response);
  }

  @override
  Future<GetTransactionsDetails> getTransactions() async {
    final response =
        await _client.get(ApiConstants.getTransactions, extractData: false);
    return GetTransactionsDetails.fromJson(response);
  }

  @override
  Future<InitiateLoanClosureDetails> initiateLoanClosure() async {
    final response =
        await _client.get(ApiConstants.initiateLoanClosure, extractData: false);
    return InitiateLoanClosureDetails.fromJson(response);
  }

  @override
  Future<InitiatePaymentDetails> initiatePayment() async {
    final response =
        await _client.get(ApiConstants.initiatePayments, extractData: false);
    return InitiatePaymentDetails.fromJson(response);
  }

  @override
  Future<InitiateWithdrawalDetails> initiateWithdrawal() async {
    final response =
        await _client.get(ApiConstants.initiateWithdrawal, extractData: false);
    return InitiateWithdrawalDetails.fromJson(response);
  }

  @override
  Future<LoanClosureDetails> loanClosure() async {
    final response =
        await _client.get(ApiConstants.loanClosure, extractData: false);
    return LoanClosureDetails.fromJson(response);
  }

  @override
  Future<UpdateLoanStatusDetails> updateLoanStatus(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.updateLoanStatus,
        params: params, extractData: false);
    return UpdateLoanStatusDetails.fromJson(response);
  }
}
