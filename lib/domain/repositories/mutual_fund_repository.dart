import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../data/models/initiate_payment_response.dart';
import '../../data/models/mutual_funds/cart/initiate_lumpsum_cart_purchase_response.dart';
import '../../data/models/mutual_funds/cart/mutual_fund_cart.dart';
import '../../data/models/mutual_funds/cart/verify_cart_purchase_response.dart';
import '../../data/models/mutual_funds/capital_gain_report_model.dart';
import '../../data/models/mutual_funds/create_consent.dart';
import '../../data/models/mutual_funds/explore_diy_response.dart';
import '../../data/models/mutual_funds/fp_fund_details.dart';
import '../../data/models/mutual_funds/fund.dart';
import '../../data/models/mutual_funds/fund_detail.dart';
import '../../data/models/mutual_funds/fund_holding.dart';
import '../../data/models/mutual_funds/holding_analysis.dart';
import '../../data/models/mutual_funds/installment_dto.dart';
import '../../data/models/mutual_funds/investment_returns.dart';
import '../../data/models/mutual_funds/lumpsum_purchase_model.dart';
import '../../data/models/mutual_funds/mf_order.dart';
import '../../data/models/mutual_funds/mf_transaction.dart';
import '../../data/models/mutual_funds/mutual_fund.dart';
import '../../data/models/mutual_funds/nav_history.dart';
import '../../data/models/mutual_funds/redeem/redeem_order_response.dart';
import '../../data/models/mutual_funds/sector_allocation.dart';
import '../../data/models/mutual_funds/sip/sip_model.dart';
import '../../data/models/mutual_funds/sip/sip_order_response.dart';
import '../../data/models/mutual_funds/stp/stp_order_response.dart';
import '../../data/models/mutual_funds/switch/switch_order_response.dart';
import '../../data/models/mutual_funds/swp/swp_order_response.dart';
import '../../data/models/mutual_funds/systematic_plan.dart';
import '../../data/models/mutual_funds/user_mf_holding.dart';
import '../../data/models/mutual_funds/verify_consent.dart';
import '../entities/app_error.dart';

abstract class MutualFundRepository {
  Future<Either<AppError, List<Fund>>> getMutualFunds(
      Map<String, dynamic> params);

  Future<Either<AppError, Fund>> getFundByIsin(Map<String, dynamic> params);

  Future<Either<AppError, List<MutualFund>>> getFundsBySubcategory(
      Map<String, dynamic> params);

  Future<Either<AppError, List<NavHistory>>> getMutualFundNavHistory(
      Map<String, dynamic> params);

  Future<Either<AppError, FundDetail>> getMutualFundDetail(
      Map<String, dynamic> params);

  Future<Either<AppError, FpFundDetails>> getFpFundDetails(
      Map<String, dynamic> params);

  Future<Either<AppError, List<Fund>>> getSwitchFunds(
      Map<String, dynamic> params);

  Future<Either<AppError, List<Fund>>> getStpFunds(Map<String, dynamic> params);

  Future<Either<AppError, HoldingAnalysis>> getHoldingAnalysis(
      Map<String, dynamic> params);

  Future<Either<AppError, SectorAllocationList>> getSectorAllocation(
      Map<String, dynamic> params);

  Future<Either<AppError, List<FundHolding>>> getFundHoldings(
      Map<String, dynamic> params);

  Future<Either<AppError, CreateConsentModel>> createLumpsumConsent(
      Map<String, dynamic> params);

  Future<Either<AppError, CreateConsentModel>> createSipConsent(
      Map<String, dynamic> params);

  Future<Either<AppError, VerifyConsentModel>> verifyLumpsumConsent(
      Map<String, dynamic> params);

  Future<Either<AppError, VerifyConsentModel>> verifySipConsent(
      Map<String, dynamic> params);

  Future<Either<AppError, LumpsumPurchase>> createLumpsumPurchase(
      Map<String, dynamic> params);

  Future<Either<AppError, InitiatePaymentResponse>> initiateLumpsumPurchase(
      Map<String, dynamic> params);

  Future<Either<AppError, SipOrderResponse>> createSipOrder(
      Map<String, dynamic> params);

  Future<Either<AppError, List<SipModel>>> getActiveSips(
      Map<String, dynamic> params);

  Future<Either<AppError, List<SipModel>>> getCancelledSips(
      Map<String, dynamic> params);

  Future<Either<AppError, List<SystematicPlan>>> getSystematicPlans(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> stopSipOrder(Map<String, dynamic> params);

  Future<Either<AppError, void>> stopStpOrder(Map<String, dynamic> params);

  Future<Either<AppError, void>> stopSwpOrder(Map<String, dynamic> params);

  Future<Either<AppError, List<InstallmentDTO>>> getSipInstallments(
      Map<String, dynamic> params);

  Future<Either<AppError, List<InstallmentDTO>>> getStpInstallments(
      Map<String, dynamic> params);

  Future<Either<AppError, List<InstallmentDTO>>> getSwpInstallments(
      Map<String, dynamic> params);

  Future<Either<AppError, UserMfHoldings?>> getUserMFHoldings(
      Map<String, dynamic> params);

  Future<Either<AppError, MfTransaction>> getMfTransactions(
      Map<String, dynamic> params);

  Future<Either<AppError, InvestmentReturns>> getMfInvestmentReturns(
      Map<String, dynamic> params);

  Future<Either<AppError, RedeemOrderResponse>> createRedemptionOrder(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> verifyRedemptionOtp(
      Map<String, dynamic> params);

  Future<Either<AppError, SwitchOrderResponse>> createSwitchOrder(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> verifySwitchOtp(Map<String, dynamic> params);

  Future<Either<AppError, StpOrderResponse>> createStpOrder(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> verifyStpOtp(Map<String, dynamic> params);

  Future<Either<AppError, SwpOrderResponse>> createSwpOrder(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> verifySwpOtp(Map<String, dynamic> params);

  Future<Either<AppError, void>> resendTransactionOtp(FormData formData);

  Future<Either<AppError, List<MfOrder>>> fetchMfOrders(
      Map<String, dynamic> params);

  Future<Either<AppError, String>> generateHoldingsReport(
      Map<String, dynamic> params);

  Future<Either<AppError, ExploreDIYDataResponse>> getExploreDIYData(
    Map<String, dynamic> queryParams,
  );

  Future<Either<AppError, List<String>>> getInvestmentIdeaFilters(
    Map<String, dynamic> queryParams,
  );

  Future<Either<AppError, List<MutualFund>>> getFundsByInvestmentIdea(
    Map<String, dynamic> queryParams,
  );

  Future<Either<AppError, bool>> isSchemePresent(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, void>> addToCart(
    Map<String, dynamic> queryParams,
  );

  Future<Either<AppError, void>> editCart(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, MutualFundCart>> getCartLumpsumFunds();

  Future<Either<AppError, MutualFundCart>> getCartSipFunds();

  Future<Either<AppError, void>> clearCartFunds(Map<String, dynamic> params);

  Future<Either<AppError, void>> removeFundFromCart(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, InitiateCartPurchaseResponse>>
      initiateCartLumpsumPurchase();

  Future<Either<AppError, InitiateCartPurchaseResponse>>
      initiateCartSipPurchase(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, VerifyCartPurchaseOtpResponse>> verifyCartPurchaseOtp(
    Map<String, dynamic> params,
  );
  Future<Either<AppError, CapitalGainReportModel>> getCapitalGainsReport(
      Map<String, dynamic> params);

  Future<Either<AppError, void>> generateCapitalGainFile(
      Map<String, dynamic> params);
}
