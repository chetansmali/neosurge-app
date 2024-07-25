import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/mutual_fund_repository.dart';
import '../data_sources/remote/mutual_fund_remote_data_source.dart';
import '../models/initiate_payment_response.dart';
import '../models/mutual_funds/cart/initiate_lumpsum_cart_purchase_response.dart';
import '../models/mutual_funds/cart/mutual_fund_cart.dart';
import '../models/mutual_funds/cart/verify_cart_purchase_response.dart';
import '../models/mutual_funds/capital_gain_report_model.dart';
import '../models/mutual_funds/create_consent.dart';
import '../models/mutual_funds/explore_diy_response.dart';
import '../models/mutual_funds/fp_fund_details.dart';
import '../models/mutual_funds/fund.dart';
import '../models/mutual_funds/fund_detail.dart';
import '../models/mutual_funds/fund_holding.dart';
import '../models/mutual_funds/holding_analysis.dart';
import '../models/mutual_funds/installment_dto.dart';
import '../models/mutual_funds/investment_returns.dart';
import '../models/mutual_funds/lumpsum_purchase_model.dart';
import '../models/mutual_funds/mf_order.dart';
import '../models/mutual_funds/mf_transaction.dart';
import '../models/mutual_funds/mutual_fund.dart';
import '../models/mutual_funds/nav_history.dart';
import '../models/mutual_funds/redeem/redeem_order_response.dart';
import '../models/mutual_funds/sector_allocation.dart';
import '../models/mutual_funds/sip/sip_model.dart';
import '../models/mutual_funds/sip/sip_order_response.dart';
import '../models/mutual_funds/stp/stp_order_response.dart';
import '../models/mutual_funds/switch/switch_order_response.dart';
import '../models/mutual_funds/swp/swp_order_response.dart';
import '../models/mutual_funds/systematic_plan.dart';
import '../models/mutual_funds/user_mf_holding.dart';
import '../models/mutual_funds/verify_consent.dart';

@LazySingleton(as: MutualFundRepository)
class MutualFundRepositoryImpl implements MutualFundRepository {
  final MutualFundRemoteDataSource _mfRemoteDataSource;

  const MutualFundRepositoryImpl(this._mfRemoteDataSource);

  @override
  Future<Either<AppError, List<Fund>>> getMutualFunds(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _mfRemoteDataSource.getMutualFunds(params));
  }

  @override
  Future<Either<AppError, List<MutualFund>>> getFundsBySubcategory(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _mfRemoteDataSource.getFundsBySubCategory(params));
  }

  @override
  Future<Either<AppError, List<NavHistory>>> getMutualFundNavHistory(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _mfRemoteDataSource.getMutualFundNavHistory(params));
  }

  @override
  Future<Either<AppError, FundDetail>> getMutualFundDetail(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _mfRemoteDataSource.getMutualFundDetail(params));
  }

  @override
  Future<Either<AppError, HoldingAnalysis>> getHoldingAnalysis(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _mfRemoteDataSource.getHoldingAnalysis(params));
  }

  @override
  Future<Either<AppError, List<FundHolding>>> getFundHoldings(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _mfRemoteDataSource.getFundHoldings(params));
  }

  @override
  Future<Either<AppError, CreateConsentModel>> createLumpsumConsent(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _mfRemoteDataSource.createLumpsumConsent(params));
  }

  @override
  Future<Either<AppError, CreateConsentModel>> createSipConsent(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _mfRemoteDataSource.createSipConsent(params));
  }

  @override
  Future<Either<AppError, VerifyConsentModel>> verifyLumpsumConsent(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _mfRemoteDataSource.verifyLumpsumConsent(params));
  }

  @override
  Future<Either<AppError, VerifyConsentModel>> verifySipConsent(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _mfRemoteDataSource.verifySipConsent(params));
  }

  @override
  Future<Either<AppError, LumpsumPurchase>> createLumpsumPurchase(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _mfRemoteDataSource.createLumpsumPurchase(params));
  }

  @override
  Future<Either<AppError, InitiatePaymentResponse>> initiateLumpsumPurchase(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.initiateLumpsumPurchase(params));
  }

  @override
  Future<Either<AppError, SipOrderResponse>> createSipOrder(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.createSipOrder(params));
  }

  @override
  Future<Either<AppError, List<SipModel>>> getActiveSips(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.getActiveSips(params));
  }

  @override
  Future<Either<AppError, void>> stopSipOrder(Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.stopSipOrder(params));
  }

  @override
  Future<Either<AppError, void>> stopStpOrder(Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.stopStpOrder(params));
  }

  @override
  Future<Either<AppError, void>> stopSwpOrder(Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.stopSwpOrder(params));
  }

  @override
  Future<Either<AppError, List<InstallmentDTO>>> getSipInstallments(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.fetchSipInstallments(params));
  }

  @override
  Future<Either<AppError, List<InstallmentDTO>>> getStpInstallments(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.fetchStpInstallments(params));
  }

  @override
  Future<Either<AppError, List<InstallmentDTO>>> getSwpInstallments(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.fetchSwpInstallments(params));
  }

  @override
  Future<Either<AppError, UserMfHoldings?>> getUserMFHoldings(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.getUserMFHoldings(params));
  }

  @override
  Future<Either<AppError, MfTransaction>> getMfTransactions(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.getMfTransactions(params));
  }

  @override
  Future<Either<AppError, InvestmentReturns>> getMfInvestmentReturns(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.getMfInvestmentReturns(params));
  }

  @override
  Future<Either<AppError, List<SipModel>>> getCancelledSips(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.getCancelledSips(params));
  }

  @override
  Future<Either<AppError, Fund>> getFundByIsin(Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.getFundByIsin(params));
  }

  @override
  Future<Either<AppError, RedeemOrderResponse>> createRedemptionOrder(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.createRedemptionOrder(params));
  }

  @override
  Future<Either<AppError, void>> verifyRedemptionOtp(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.verifyRedemptionOtp(params));
  }

  @override
  Future<Either<AppError, List<Fund>>> getSwitchFunds(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.getSwitchFunds(params));
  }

  @override
  Future<Either<AppError, StpOrderResponse>> createStpOrder(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.createStpOrder(params));
  }

  @override
  Future<Either<AppError, SwitchOrderResponse>> createSwitchOrder(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.createSwitchOrder(params));
  }

  @override
  Future<Either<AppError, SwpOrderResponse>> createSwpOrder(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.createSwpOrder(params));
  }

  @override
  Future<Either<AppError, void>> resendTransactionOtp(FormData formData) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.resendTransactionOtp(formData));
  }

  @override
  Future<Either<AppError, void>> verifyStpOtp(Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.verifyStpOtp(params));
  }

  @override
  Future<Either<AppError, void>> verifySwitchOtp(Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.verifySwitchOtp(params));
  }

  @override
  Future<Either<AppError, void>> verifySwpOtp(Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.verifySwpOtp(params));
  }

  @override
  Future<Either<AppError, List<MfOrder>>> fetchMfOrders(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.fetchMfOrders(params));
  }

  @override
  Future<Either<AppError, FpFundDetails>> getFpFundDetails(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.getFpFundDetails(params));
  }

  @override
  Future<Either<AppError, List<Fund>>> getStpFunds(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(() => _mfRemoteDataSource.getStpFunds(params));
  }

  @override
  Future<Either<AppError, List<SystematicPlan>>> getSystematicPlans(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.getSystematicPlans(params));
  }

  @override
  Future<Either<AppError, String>> generateHoldingsReport(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.generateHoldingsReport(params));
  }

  @override
  Future<Either<AppError, SectorAllocationList>> getSectorAllocation(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.getSectorAllocation(params));
  }

  @override
  Future<Either<AppError, ExploreDIYDataResponse>> getExploreDIYData(
      Map<String, dynamic> queryParams) {
    return ApiCallWithError.call(
      () => _mfRemoteDataSource.getExploreDIYData(queryParams),
    );
  }

  @override
  Future<Either<AppError, List<String>>> getInvestmentIdeaFilters(
    Map<String, dynamic> queryParams,
  ) {
    return ApiCallWithError.call(
      () => _mfRemoteDataSource.getInvestmentIdeaFilters(queryParams),
    );
  }

  @override
  Future<Either<AppError, List<MutualFund>>> getFundsByInvestmentIdea(
    Map<String, dynamic> queryParams,
  ) {
    return ApiCallWithError.call(
      () => _mfRemoteDataSource.getFundsByInvestmentIdea(queryParams),
    );
  }

  @override
  Future<Either<AppError, bool>> isSchemePresent(Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.isSchemePresent(params));
  }

  @override
  Future<Either<AppError, void>> addToCart(Map<String, dynamic> queryParams) {
    return ApiCallWithError.call(
      () => _mfRemoteDataSource.addToCart(queryParams),
    );
  }

  @override
  Future<Either<AppError, void>> editCart(Map<String, dynamic> params) {
    return ApiCallWithError.call(() => _mfRemoteDataSource.editCart(params));
  }

  @override
  Future<Either<AppError, MutualFundCart>> getCartLumpsumFunds() {
    return ApiCallWithError.call(
      () => _mfRemoteDataSource.getCartLumpsumFunds(),
    );
  }

  @override
  Future<Either<AppError, MutualFundCart>> getCartSipFunds() {
    return ApiCallWithError.call(
      () => _mfRemoteDataSource.getCartSipFunds(),
    );
  }

  @override
  Future<Either<AppError, void>> clearCartFunds(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _mfRemoteDataSource.clearCartFunds(params),
    );
  }

  @override
  Future<Either<AppError, void>> removeFundFromCart(
    Map<String, dynamic> params,
  ) {
    return ApiCallWithError.call(
      () => _mfRemoteDataSource.removeFundFromCart(params),
    );
  }

  @override
  Future<Either<AppError, InitiateCartPurchaseResponse>>
      initiateCartLumpsumPurchase() {
    return ApiCallWithError.call(
      () => _mfRemoteDataSource.initiateCartLumpsumPurchase(),
    );
  }

  @override
  Future<Either<AppError, InitiateCartPurchaseResponse>>
      initiateCartSipPurchase(
    Map<String, dynamic> params,
  ) {
    return ApiCallWithError.call(
      () => _mfRemoteDataSource.initiateCartSipPurchase(params),
    );
  }

  @override
  Future<Either<AppError, VerifyCartPurchaseOtpResponse>> verifyCartPurchaseOtp(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _mfRemoteDataSource.verifyCartPurchaseOtp(params),
    );
  }

  Future<Either<AppError, CapitalGainReportModel>> getCapitalGainsReport(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.getCapitalGainReport(params));
  }

  @override
  Future<Either<AppError, void>> generateCapitalGainFile(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _mfRemoteDataSource.generateCapitalGainReportFile(params));
  }
}
