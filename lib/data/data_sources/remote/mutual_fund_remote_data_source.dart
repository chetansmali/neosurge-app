import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../models/initiate_payment_response.dart';
import '../../models/mutual_funds/cart/initiate_lumpsum_cart_purchase_response.dart';
import '../../models/mutual_funds/cart/mutual_fund_cart.dart';
import '../../models/mutual_funds/cart/verify_cart_purchase_response.dart';
import '../../models/mutual_funds/capital_gain_report_model.dart';
import '../../models/mutual_funds/create_consent.dart';
import '../../models/mutual_funds/explore_diy_response.dart';
import '../../models/mutual_funds/fp_fund_details.dart';
import '../../models/mutual_funds/fund.dart';
import '../../models/mutual_funds/fund_detail.dart';
import '../../models/mutual_funds/fund_holding.dart';
import '../../models/mutual_funds/holding_analysis.dart';
import '../../models/mutual_funds/installment_dto.dart';
import '../../models/mutual_funds/investment_returns.dart';
import '../../models/mutual_funds/lumpsum_purchase_model.dart';
import '../../models/mutual_funds/mf_order.dart';
import '../../models/mutual_funds/mf_transaction.dart';
import '../../models/mutual_funds/mutual_fund.dart';
import '../../models/mutual_funds/nav_history.dart';
import '../../models/mutual_funds/redeem/redeem_order_response.dart';
import '../../models/mutual_funds/sector_allocation.dart';
import '../../models/mutual_funds/sip/sip_model.dart';
import '../../models/mutual_funds/sip/sip_order_response.dart';
import '../../models/mutual_funds/stp/stp_order_response.dart';
import '../../models/mutual_funds/switch/switch_order_response.dart';
import '../../models/mutual_funds/swp/swp_order_response.dart';
import '../../models/mutual_funds/systematic_plan.dart';
import '../../models/mutual_funds/user_mf_holding.dart';
import '../../models/mutual_funds/verify_consent.dart';

abstract class MutualFundRemoteDataSource {
  Future<List<Fund>> getMutualFunds(Map<String, dynamic> queryParams);

  Future<Fund> getFundByIsin(Map<String, dynamic> queryParams);

  Future<List<MutualFund>> getFundsBySubCategory(
      Map<String, dynamic> queryParams);

  Future<List<NavHistory>> getMutualFundNavHistory(
      Map<String, dynamic> queryParams);

  Future<FundDetail> getMutualFundDetail(Map<String, dynamic> queryParams);

  Future<FpFundDetails> getFpFundDetails(Map<String, dynamic> queryParams);

  Future<List<Fund>> getSwitchFunds(Map<String, dynamic> queryParams);

  Future<List<Fund>> getStpFunds(Map<String, dynamic> queryParams);

  Future<HoldingAnalysis> getHoldingAnalysis(Map<String, dynamic> queryParams);

  Future<SectorAllocationList> getSectorAllocation(
      Map<String, dynamic> queryParams);

  Future<List<FundHolding>> getFundHoldings(Map<String, dynamic> queryParams);

  Future<CreateConsentModel> createLumpsumConsent(
      Map<String, dynamic> queryParams);

  Future<CreateConsentModel> createSipConsent(Map<String, dynamic> queryParams);

  Future<VerifyConsentModel> verifyLumpsumConsent(
      Map<String, dynamic> queryParams);

  Future<VerifyConsentModel> verifySipConsent(Map<String, dynamic> queryParams);

  Future<LumpsumPurchase> createLumpsumPurchase(
      Map<String, dynamic> queryParams);

  Future<InitiatePaymentResponse> initiateLumpsumPurchase(
      Map<String, dynamic> queryParams);

  Future<SipOrderResponse> createSipOrder(Map<String, dynamic> queryParams);

  Future<List<SipModel>> getActiveSips(Map<String, dynamic> queryParams);

  Future<List<SipModel>> getCancelledSips(Map<String, dynamic> queryParams);

  Future<List<SystematicPlan>> getSystematicPlans(
      Map<String, dynamic> queryParams);

  Future<void> stopSipOrder(Map<String, dynamic> queryParams);

  Future<void> stopStpOrder(Map<String, dynamic> queryParams);

  Future<void> stopSwpOrder(Map<String, dynamic> queryParams);

  Future<List<InstallmentDTO>> fetchSipInstallments(
      Map<String, dynamic> queryParams);

  Future<List<InstallmentDTO>> fetchStpInstallments(
      Map<String, dynamic> queryParams);

  Future<List<InstallmentDTO>> fetchSwpInstallments(
      Map<String, dynamic> queryParams);

  Future<UserMfHoldings?> getUserMFHoldings(Map<String, dynamic> queryParams);

  Future<MfTransaction> getMfTransactions(Map<String, dynamic> queryParams);

  Future<InvestmentReturns> getMfInvestmentReturns(
      Map<String, dynamic> queryParams);

  Future<RedeemOrderResponse> createRedemptionOrder(
      Map<String, dynamic> queryParams);

  Future<void> verifyRedemptionOtp(Map<String, dynamic> queryParams);

  Future<SwitchOrderResponse> createSwitchOrder(
      Map<String, dynamic> queryParams);

  Future<void> verifySwitchOtp(Map<String, dynamic> queryParams);

  Future<StpOrderResponse> createStpOrder(Map<String, dynamic> queryParams);

  Future<void> verifyStpOtp(Map<String, dynamic> queryParams);

  Future<SwpOrderResponse> createSwpOrder(Map<String, dynamic> queryParams);

  Future<void> verifySwpOtp(Map<String, dynamic> queryParams);

  Future<void> resendTransactionOtp(FormData formData);

  Future<List<MfOrder>> fetchMfOrders(Map<String, dynamic> queryParams);

  Future<String> generateHoldingsReport(Map<String, dynamic> queryParams);

  Future<CapitalGainReportModel> getCapitalGainReport(
      Map<String, dynamic> queryParams);

  Future<void> generateCapitalGainReportFile(Map<String, dynamic> queryParams);

  Future<ExploreDIYDataResponse> getExploreDIYData(
    Map<String, dynamic> queryParams,
  );

  Future<List<String>> getInvestmentIdeaFilters(
    Map<String, dynamic> queryParams,
  );

  Future<List<MutualFund>> getFundsByInvestmentIdea(
    Map<String, dynamic> queryParams,
  );

  Future<bool> isSchemePresent(Map<String, dynamic> params);

  Future<void> addToCart(
    Map<String, dynamic> params,
  );

  Future<void> editCart(Map<String, dynamic> params);

  Future<MutualFundCart> getCartLumpsumFunds();

  Future<MutualFundCart> getCartSipFunds();

  Future<void> clearCartFunds(
    Map<String, dynamic> params,
  );

  Future<void> removeFundFromCart(
    Map<String, dynamic> params,
  );

  Future<InitiateCartPurchaseResponse> initiateCartLumpsumPurchase();

  Future<InitiateCartPurchaseResponse> initiateCartSipPurchase(
    Map<String, dynamic> params,
  );

  Future<VerifyCartPurchaseOtpResponse> verifyCartPurchaseOtp(
    Map<String, dynamic> params,
  );
}

@LazySingleton(as: MutualFundRemoteDataSource)
class MutualFundRemoteDataSourceImpl implements MutualFundRemoteDataSource {
  final ApiClient _client;

  MutualFundRemoteDataSourceImpl(this._client);

  @override
  Future<List<Fund>> getMutualFunds(Map<String, dynamic> queryParams) async {
    final response = await _client.post(
      ApiConstants.getMutualFunds,
      params: queryParams,
    );
    return Fund.fromJsonList(response);
  }

  @override
  Future<List<MutualFund>> getFundsBySubCategory(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(
      ApiConstants.getMutualFundsBySubCategory,
      queryParameters: queryParams,
    );
    return MutualFund.fromJsonList(response['content']);
  }

  @override
  Future<List<NavHistory>> getMutualFundNavHistory(
      Map<String, dynamic> queryParams) async {
    final response =
        await _client.post(ApiConstants.getNavMFGraph, params: queryParams);
    return NavHistory.listFromJson(response['nav_history']);
  }

  @override
  Future<FundDetail> getMutualFundDetail(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.getMutualFundDetail,
        params: queryParams);
    return FundDetail.fromJson(response);
  }

  @override
  Future<HoldingAnalysis> getHoldingAnalysis(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.getHoldingAnalysis,
        params: queryParams);
    return HoldingAnalysis.fromJson(response);
  }

  @override
  Future<List<FundHolding>> getFundHoldings(
      Map<String, dynamic> queryParams) async {
    final response =
        await _client.post(ApiConstants.getFundHoldings, params: queryParams);
    return FundHolding.listFromJson(response);
  }

  @override
  Future<CreateConsentModel> createLumpsumConsent(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(ApiConstants.createLumpsumConsent,
        queryParameters: queryParams);
    return CreateConsentModel.fromJson(response);
  }

  @override
  Future<CreateConsentModel> createSipConsent(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(ApiConstants.createSipConsent,
        queryParameters: queryParams);
    return CreateConsentModel.fromJson(response);
  }

  @override
  Future<VerifyConsentModel> verifyLumpsumConsent(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.verifyLumpsumConsent,
        params: queryParams);
    return VerifyConsentModel.fromJson(response);
  }

  @override
  Future<VerifyConsentModel> verifySipConsent(
      Map<String, dynamic> queryParams) async {
    final response =
        await _client.post(ApiConstants.verifySipConsent, params: queryParams);
    return VerifyConsentModel.fromJson(response);
  }

  @override
  Future<LumpsumPurchase> createLumpsumPurchase(
      Map<String, dynamic> queryParams) async {
    final response = await _client
        .post(ApiConstants.createLumpsumPurchaseEndPoint, params: queryParams);
    return LumpsumPurchase.fromJson(response);
  }

  @override
  Future<InitiatePaymentResponse> initiateLumpsumPurchase(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(
        ApiConstants.initiateLumpsumPurchaseEndPoint,
        params: queryParams);
    return InitiatePaymentResponse.fromJson(response);
  }

  @override
  Future<SipOrderResponse> createSipOrder(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.createSipOrderEndPoint,
        params: queryParams);
    return SipOrderResponse.fromJson(response);
  }

  @override
  Future<List<SipModel>> getActiveSips(Map<String, dynamic> queryParams) async {
    final response = await _client.get(ApiConstants.getActiveSipsEndPoint,
        queryParameters: queryParams);
    return response.map<SipModel>((e) => SipModel.fromJson(e)).toList();
  }

  @override
  Future<void> stopSipOrder(Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.stopSipEndPoint,
        queryParams: queryParams);
    return response;
  }

  @override
  Future<void> stopStpOrder(Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.stopStpEndPoint,
        queryParams: queryParams);
    return response;
  }

  @override
  Future<void> stopSwpOrder(Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.stopSwpEndPoint,
        queryParams: queryParams);
    return response;
  }

  @override
  Future<List<InstallmentDTO>> fetchSipInstallments(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(
        ApiConstants.fetchSipInstallmentsEndPoint,
        queryParameters: queryParams);
    return response
        .map<InstallmentDTO>((e) => InstallmentDTO.fromJson(e))
        .toList();
  }

  @override
  Future<List<InstallmentDTO>> fetchStpInstallments(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(
        ApiConstants.fetchStpInstallmentsEndPoint,
        queryParameters: queryParams);
    return response
        .map<InstallmentDTO>((e) => InstallmentDTO.fromJson(e))
        .toList();
  }

  @override
  Future<List<InstallmentDTO>> fetchSwpInstallments(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(
        ApiConstants.fetchSwpInstallmentsEndPoint,
        queryParameters: queryParams);
    return response
        .map<InstallmentDTO>((e) => InstallmentDTO.fromJson(e))
        .toList();
  }

  @override
  Future<UserMfHoldings?> getUserMFHoldings(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(ApiConstants.getUserMutualFundsEndPoint,
        queryParameters: queryParams);
    return response == null ? null : UserMfHoldings.fromJson(response);
  }

  @override
  Future<MfTransaction> getMfTransactions(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(
        ApiConstants.getMFTransactionListEndPoint,
        queryParameters: queryParams);
    return MfTransaction.fromJson(response);
  }

  @override
  Future<InvestmentReturns> getMfInvestmentReturns(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(
        ApiConstants.getMFInvestmentReturnsEndPoint,
        queryParameters: queryParams);
    return InvestmentReturns.fromJson(response);
  }

  @override
  Future<List<SipModel>> getCancelledSips(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(ApiConstants.getInactiveSipsEndPoint,
        queryParameters: queryParams);
    return response.map<SipModel>((e) => SipModel.fromJson(e)).toList();
  }

  @override
  Future<Fund> getFundByIsin(Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.getFundByIsin,
        queryParams: queryParams);
    //Todo check with backend regarding response coming as list
    return Fund.fromJson(response[0]);
  }

  @override
  Future<RedeemOrderResponse> createRedemptionOrder(
      Map<String, dynamic> queryParams) async {
    final response = await _client
        .post(ApiConstants.createRedemptionOrderEndPoint, params: queryParams);
    return RedeemOrderResponse.fromJson(response);
  }

  @override
  Future<void> verifyRedemptionOtp(Map<String, dynamic> queryParams) async {
    return await _client.post(ApiConstants.verifyRedemptionOTPEndPoint,
        queryParams: queryParams);
  }

  @override
  Future<List<Fund>> getSwitchFunds(Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.getSwitchFundsEndPoint,
        queryParams: queryParams);

    log(response.toString());
    return response.map<Fund>((e) => Fund.fromJson(e)).toList();
  }

  @override
  Future<StpOrderResponse> createStpOrder(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.createStpOrderEndPoint,
        params: queryParams);
    //TODO check with backend regarding response
    return StpOrderResponse(id: response as int);
  }

  @override
  Future<SwpOrderResponse> createSwpOrder(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.createSwpOrderEndPoint,
        params: queryParams);
    //TODO check with backend regarding response
    return SwpOrderResponse(id: response as int);
  }

  @override
  Future<void> resendTransactionOtp(FormData formData) async {
    return await _client.post(ApiConstants.resendTransactionOtpEndPoint,
        isFormData: true, formData: formData);
  }

  @override
  Future<void> verifyStpOtp(Map<String, dynamic> queryParams) async {
    return await _client.post(ApiConstants.verifyStpOTPEndPoint,
        queryParams: queryParams);
  }

  @override
  Future<void> verifySwpOtp(Map<String, dynamic> queryParams) async {
    return await _client.post(ApiConstants.verifySwpOTPEndPoint,
        queryParams: queryParams);
  }

  @override
  Future<SwitchOrderResponse> createSwitchOrder(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.createSwitchOrderEndPoint,
        params: queryParams);
    return SwitchOrderResponse.fromJson(response);
  }

  @override
  Future<void> verifySwitchOtp(Map<String, dynamic> queryParams) async {
    return await _client.post(ApiConstants.verifySwitchOTPEndPoint,
        queryParams: queryParams);
  }

  @override
  Future<List<MfOrder>> fetchMfOrders(Map<String, dynamic> queryParams) async {
    final response = await _client.get(ApiConstants.getMfOrdersEndPoint,
        queryParameters: queryParams);
    if (response == null) {
      return const [];
    }
    return response.map<MfOrder>((e) => MfOrder.fromJson(e)).toList();
  }

  @override
  Future<FpFundDetails> getFpFundDetails(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(ApiConstants.getFpFundDetailsEndPoint,
        queryParameters: queryParams);
    return FpFundDetails.fromJson(response);
  }

  @override
  Future<List<Fund>> getStpFunds(Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.getStpFundsEndPoint,
        queryParams: queryParams);
    return response.map<Fund>((e) => Fund.fromJson(e)).toList();
  }

  @override
  Future<List<SystematicPlan>> getSystematicPlans(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(ApiConstants.getSystematicPlansEndPoint,
        queryParameters: queryParams);
    return response == null
        ? []
        : response
            .map<SystematicPlan>((e) => SystematicPlan.fromJson(e))
            .toList();
  }

  @override
  Future<String> generateHoldingsReport(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(
        ApiConstants.generateHoldingsReportEndPoint,
        queryParams: queryParams);
    return response as String;
  }

  @override
  Future<SectorAllocationList> getSectorAllocation(
    Map<String, dynamic> queryParams,
  ) async {
    final response = await _client
        .post(ApiConstants.getSectorAllocationEndPoint, params: queryParams);
    return SectorAllocationList(
        sectors: response
            .map<HoldingSector>((e) => HoldingSector.fromJson(e))
            .toList());
  }

  @override
  Future<ExploreDIYDataResponse> getExploreDIYData(
    Map<String, dynamic> queryParams,
  ) async {
    final response = await _client.get(
      ApiConstants.getExploreDIYDataEndPoint,
      queryParameters: queryParams,
    );

    return ExploreDIYDataResponse.fromJson(response);
  }

  @override
  Future<CapitalGainReportModel> getCapitalGainReport(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.getCapitalGainReport,
        params: queryParams, extractData: false);
    return CapitalGainReportModel.fromJson(response);
  }

  @override
  Future<void> generateCapitalGainReportFile(
      Map<String, dynamic> queryParams) async {
    return await _client.post(ApiConstants.generateCapitalGainReportFile,
        params: queryParams, extractData: false);
  }

  @override
  Future<List<String>> getInvestmentIdeaFilters(
    Map<String, dynamic> queryParams,
  ) async {
    final response = await _client.get(
      ApiConstants.getInvestmentIdeasEndPoint,
      queryParameters: queryParams,
    );

    return response.map<String>((e) => e as String).toList();
  }

  @override
  Future<List<MutualFund>> getFundsByInvestmentIdea(
    Map<String, dynamic> queryParams,
  ) async {
    final response = await _client.get(
      ApiConstants.getFundsByInvestmentIdeasEndPoint,
      queryParameters: queryParams,
    );

    return MutualFund.fromJsonList(response['content']);
  }

  @override
  Future<bool> isSchemePresent(Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.schemePresent,
      params: params,
      extractData: false,
    );

    return response['isPresent'];
  }

  @override
  Future<void> addToCart(Map<String, dynamic> params) async {
    return await _client.post(
      ApiConstants.addToCart,
      params: params,
    );
  }

  @override
  Future<void> editCart(Map<String, dynamic> params) async {
    return await _client.post(
      ApiConstants.editCart,
      params: params,
    );
  }

  @override
  Future<MutualFundCart> getCartLumpsumFunds() async {
    final response = await _client.get(
      ApiConstants.getCartLumpsumFunds,
      extractData: false,
    );

    return MutualFundCart.fromJson(response);
  }

  @override
  Future<MutualFundCart> getCartSipFunds() async {
    final response = await _client.get(
      ApiConstants.getCartSipFunds,
      extractData: false,
    );

    return MutualFundCart.fromJson(response);
  }

  @override
  Future<void> clearCartFunds(Map<String, dynamic> params) async {
    return await _client.post(
      ApiConstants.clearCartFunds,
      params: params,
      extractData: false,
    );
  }

  @override
  Future<void> removeFundFromCart(Map<String, dynamic> params) async {
    return await _client.post(
      ApiConstants.removeFundFromCart,
      params: params,
      extractData: false,
    );
  }

  @override
  Future<InitiateCartPurchaseResponse> initiateCartLumpsumPurchase() async {
    final response = await _client.post(
      ApiConstants.initiateCartLumpsumPurchase,
      extractData: false,
    );

    return InitiateCartPurchaseResponse.fromJson(response);
  }

  @override
  Future<InitiateCartPurchaseResponse> initiateCartSipPurchase(
    Map<String, dynamic> params,
  ) async {
    final response = await _client.post(
      ApiConstants.initiateCartSipPurchase,
      params: params,
      extractData: false,
    );

    return InitiateCartPurchaseResponse.fromJson(response);
  }

  @override
  Future<VerifyCartPurchaseOtpResponse> verifyCartPurchaseOtp(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.verifyCartPurchase,
      params: params,
      extractData: false,
    );

    return VerifyCartPurchaseOtpResponse.fromJson(response);
  }
}
