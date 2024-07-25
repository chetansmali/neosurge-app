// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:signature/signature.dart';

import '../../data/models/assisted_service/invest_suggested_funds_response.dart';
import '../../data/models/authentication/login_with_email_response_model.dart';
import '../../data/models/digital_gold/create_order_response_model.dart';
import '../../data/models/digital_gold/delivery_product_model.dart';
import '../../data/models/digital_gold/razor_pay_error_response_model.dart';
import '../../data/models/mutual_funds/fp_fund_details.dart';
import '../../data/models/mutual_funds/fund.dart';
import '../../data/models/mutual_funds/fund_detail.dart';
import '../../data/models/mutual_funds/fund_holding.dart';
import '../../data/models/mutual_funds/lumpsum_purchase_model.dart';
import '../../data/models/mutual_funds/mf_order.dart';
import '../../data/models/mutual_funds/redeem/redeem_order_response.dart';
import '../../data/models/mutual_funds/sip/sip_order_response.dart';
import '../../data/models/mutual_funds/stp/stp_order_response.dart';
import '../../data/models/mutual_funds/switch/switch_order_response.dart';
import '../../data/models/mutual_funds/swp/swp_order_response.dart';
import '../../data/models/mutual_funds/systematic_plan.dart';
import '../../data/models/mutual_funds/user_mf_scheme.dart';
import '../../data/models/retirement_calculator/retirement_passbook_model.dart';
import '../../data/models/user/address_details_model.dart';
import '../../data/models/neobaskets/basket_details.dart';
import '../../data/models/neobaskets/basket_portfolio_detail_response.dart'
    as basket_portfolio_detail_response;
import '../../data/models/neobaskets/basket_portfolio_response.dart';
import '../../data/models/user/kyc_last_route.dart';
import '../../data/models/user/mandate_sip_model.dart';
import '../../data/models/user/user_bank_details_model.dart';
import '../../data/models/user/user_bank_mandate_model.dart';
import '../../data/models/user/user_mandate_details_model.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/params/digital_gold/create_delivery_order_params.dart';
import '../../domain/entities/params/digital_gold/create_order_params.dart';
import '../../domain/entities/params/digital_gold/dg_transaction_model.dart';

class SignUpArgs {
  final int pageIndex;

  const SignUpArgs({required this.pageIndex});
}

class DigitalSignatureArgs {
  final SignatureController signatureController;

  const DigitalSignatureArgs({required this.signatureController});
}

class MobileNumberArgs {
  final String mobileNumber;

  const MobileNumberArgs({required this.mobileNumber});
}

class VerifyEmailParams {
  final String emailId;
  final LoginWithEmailResponseModel loginWithEmailResponseModel;

  const VerifyEmailParams(
      {required this.emailId, required this.loginWithEmailResponseModel});
}

class KycOnboardingArgs {
  final int currentStep;

  const KycOnboardingArgs({required this.currentStep});
}

class KycFlowArgs {
  final KycLastRouteModel kycData;
  final String panNumber;
  final String fullName;

  const KycFlowArgs({
    required this.kycData,
    required this.panNumber,
    required this.fullName,
  });
}

class ConfirmPoaUploadArgs {
  final String imagePath;
  final String documentType;

  const ConfirmPoaUploadArgs({
    required this.imagePath,
    required this.documentType,
  });
}

class ESignSubmitWebViewArgs {
  final String url;

  const ESignSubmitWebViewArgs({
    required this.url,
  });
}

class DetailedFundViewArgs {
  final String schemeCode;

  const DetailedFundViewArgs({
    required this.schemeCode,
  });
}

class DigitalGoldTransactionStatusArgs {
  final bool isSuccess;
  final DGTransactionType transactionType;
  final CreateOrderParams orderDetails;
  final RazorPayErrorResponseModel? errorResponse;

  const DigitalGoldTransactionStatusArgs({
    required this.isSuccess,
    required this.transactionType,
    required this.orderDetails,
    this.errorResponse,
  });
}

class DigitalGoldDeliveryDetailedViewArgs {
  final DeliveryProductModel deliveryProduct;

  const DigitalGoldDeliveryDetailedViewArgs({required this.deliveryProduct});
}

class DigitalGoldPaymentArgs {
  final CreateOrderParams createOrderParams;
  final CreateOrderResponseModel createOrderResponseModel;
  final Duration timeOut;

  const DigitalGoldPaymentArgs(
      {required this.createOrderParams,
      required this.createOrderResponseModel,
      required this.timeOut});
}

class DeliveryProductArgs {
  final DeliveryProductModel deliveryProductModel;
  final int quantity;

  const DeliveryProductArgs(
      {required this.deliveryProductModel, required this.quantity});
}

class DeliveryCheckoutArgs {
  final CreateDeliveryOrderParams createDeliveryOrderParams;
  final DeliveryProductModel deliveryProductModel;

  const DeliveryCheckoutArgs(
      {required this.createDeliveryOrderParams,
      required this.deliveryProductModel});
}

class DeliveryPaymentArgs {
  final CreateOrderResponseModel createOrderResponseModel;
  final CreateDeliveryOrderParams createDeliveryOrderParams;

  const DeliveryPaymentArgs(
      {required this.createOrderResponseModel,
      required this.createDeliveryOrderParams});
}

class AllHoldingArgs {
  final List<FundHolding> holdings;

  const AllHoldingArgs({required this.holdings});
}

class FundsListBySubCategoryArgs {
  final String category;
  final String subCategory;

  const FundsListBySubCategoryArgs({
    required this.category,
    required this.subCategory,
  });
}

class DgOrderStatusArgs {
  final DgTransactionModel transaction;
  final DgTransactionStatus transactionStatus;

  const DgOrderStatusArgs({
    required this.transaction,
    required this.transactionStatus,
  });
}

class PurchaseFundArgs {
  final bool? isEditing;
  final String purchaseType;
  final Fund fund;
  final FundDetail fundDetail;
  final FpFundDetails fpFundDetails;

  const PurchaseFundArgs({
    this.isEditing,
    required this.purchaseType,
    required this.fund,
    required this.fundDetail,
    required this.fpFundDetails,
  });
}

class LumpsumOrderSummaryArgs {
  final FundDetail fundDetail;
  final LumpsumPurchase lumpsumPurchase;

  const LumpsumOrderSummaryArgs(
      {required this.fundDetail, required this.lumpsumPurchase});
}

class SipOrderSummaryArgs {
  final SipOrderResponse sipOrder;

  const SipOrderSummaryArgs({required this.sipOrder});
}

class PaymentWebViewArgs {
  final String url;
  final MFTransactionTypes transactionType;

  const PaymentWebViewArgs({required this.url, required this.transactionType});
}

class AboutWebViewArgs {
  final String url;
  final String title;

  const AboutWebViewArgs({required this.url, required this.title});
}

class SystematicPlanArgs {
  final SystematicPlan plan;

  const SystematicPlanArgs({required this.plan});
}

class FundTransactionArgs {
  final UserMfScheme scheme;
  final Fund fund;

  const FundTransactionArgs({required this.scheme, required this.fund});
}

class RedeemTransactionArgs {
  final Fund fund;
  final RedeemOrderResponse redeemResponse;
  final UserMfScheme scheme;

  const RedeemTransactionArgs(
      {required this.fund, required this.scheme, required this.redeemResponse});
}

class MfTransactionStatusArgs {
  final MFTransactionTypes transactionType;
  final bool isAssistedService;
  final MfTransactionStatus transactionStatus;

  const MfTransactionStatusArgs({
    required this.transactionType,
    required this.isAssistedService,
    required this.transactionStatus,
  });
}

class SwitchFundArgs {
  final Fund fund;
  final UserMfScheme scheme;
  final Fund switchFund;
  final SwitchOrderResponse? switchResponse;

  const SwitchFundArgs(
      {required this.fund,
      required this.scheme,
      required this.switchFund,
      this.switchResponse});
}

class StpFundArgs {
  final Fund fund;
  final UserMfScheme scheme;
  final Fund stpFund;
  final StpOrderResponse? stpResponse;

  const StpFundArgs(
      {required this.fund,
      required this.scheme,
      required this.stpFund,
      this.stpResponse});
}

class SwpFundArgs {
  final Fund fund;
  final UserMfScheme scheme;
  final SwpOrderResponse? swpResponse;

  const SwpFundArgs(
      {required this.fund, required this.scheme, this.swpResponse});
}

class MfOrderStatusArgs {
  final MfOrder mfOrder;

  const MfOrderStatusArgs({required this.mfOrder});
}

class FundSuggestionArgs {
  final double amount;
  final int tenure;

  const FundSuggestionArgs({required this.amount, required this.tenure});
}

class AssistedServiceOrderSummaryArgs {
  final InvestSuggestedFundsResponse fundsResponse;
  final double amount;

  const AssistedServiceOrderSummaryArgs(
      {required this.fundsResponse, required this.amount});
}

/// Bank and Mandate Route Arguments

class DetailedBankViewArgs {
  final int index;
  final UserBank bank;
  final bool isFromCreateMandatePopup;

  const DetailedBankViewArgs(
      {required this.index,
      required this.bank,
      this.isFromCreateMandatePopup = false});
}

class AddBankErrorScreenArgs {
  final AppErrorType errorType;
  final String? msg;
  AddBankErrorScreenArgs({required this.errorType, this.msg});
}

class DetailedMandateArgs {
  final UserBankMandateModel userBankMandateModel;

  DetailedMandateArgs({
    required this.userBankMandateModel,
  });
}

class MandateCloseAllScreenArgs {
  final List<MandateSipModel> sips;
  final UserBankMandateModel mandate;

  MandateCloseAllScreenArgs({
    required this.sips,
    required this.mandate,
  });
}

class MandateSwitchScreenArgs {
  final UserBankMandateModel mandate;
  final List<MandateSipModel> sips;

  MandateSwitchScreenArgs({
    required this.mandate,
    required this.sips,
  });
}

class VerifyDeleteMandateScreenArgs {
  final String deleteMandateRefId;

  VerifyDeleteMandateScreenArgs({
    required this.deleteMandateRefId,
  });
}

class AuthoriseMandateArgs {
  final UserMandate mandate;
  final UserBank bank;

  const AuthoriseMandateArgs({required this.mandate, required this.bank});
}

class AutoMandateStatusArgs {
  final UserMandate mandate;
  final UserBank bank;

  /// if [isCreate] is true then the mandate was created successfully
  /// else it means the mandate was activated successfully.
  final bool isCreate;
  final bool isFailed;

  const AutoMandateStatusArgs(
      {required this.bank,
      this.isCreate = false,
      required this.mandate,
      this.isFailed = false});
}

class BrokerFundInvestmentArgs {
  final String brokerName;
  final int userId;
  final double? currentAssetValue;
  final double? investedValue;
  final double? returnValue;

  const BrokerFundInvestmentArgs({
    required this.brokerName,
    required this.userId,
    required this.currentAssetValue,
    required this.investedValue,
    required this.returnValue,
  });
}

class PortfolioAnalysisArgs {
  final double equityPercentage;
  final double debtPercentage;
  final double hybridPercentage;
  final double xirr;
  final int holdingsCount;

  const PortfolioAnalysisArgs({
    required this.equityPercentage,
    required this.debtPercentage,
    required this.hybridPercentage,
    required this.xirr,
    required this.holdingsCount,
  });
}

class BasketOrderArgs {
  BasketDetailsModel basketDetails;

  BasketOrderArgs({
    required this.basketDetails,
  });
}

class BasketOrderSummaryArgs {
  BasketDetailsModel basketDetails;
  int investmentAmount;
  BasketInvestmentType basketInvestmentType;
  int investmentDate;
  int installments;

  BasketOrderSummaryArgs({
    required this.basketDetails,
    required this.investmentAmount,
    required this.basketInvestmentType,
    required this.investmentDate,
    required this.installments,
  });
}

class BasketPortfolioDetailArgs {
  Basket portfolioBasket;

  BasketPortfolioDetailArgs({
    required this.portfolioBasket,
  });
}

class BasketOtpArgs {
  final BasketInvestmentType basketInvestmentType;
  final String orderRef;
  final String consentId;

  BasketOtpArgs({
    required this.orderRef,
    required this.consentId,
    required this.basketInvestmentType,
  });
}

class BasketTransactionArgs {
  final String basketId;

  BasketTransactionArgs({
    required this.basketId,
  });
}

class BasketTransactionDetailsArgs {
  final String orderRef;

  BasketTransactionDetailsArgs({
    required this.orderRef,
  });
}

class RedeemFundSelectionArgs {
  final basket_portfolio_detail_response.BasketPortfolioDetailResponse
      basketPortfolioDetailResponse;
  final Basket basket;

  RedeemFundSelectionArgs({
    required this.basketPortfolioDetailResponse,
    required this.basket,
  });
}

class RedeemIndividualFundArgs {
  final basket_portfolio_detail_response.BasketPortfolioDetailResponse
      basketPortfolioDetailResponse;
  final int index;
  final Basket basket;

  const RedeemIndividualFundArgs({
    required this.basket,
    required this.basketPortfolioDetailResponse,
    required this.index,
  });
}

class RedeemBasketOtpVerifyArgs {
  final String orderRef;
  final String consentId;

  RedeemBasketOtpVerifyArgs({
    required this.orderRef,
    required this.consentId,
  });
}

class SelectCartPaymentOptionArgs {
  final MFTransactionTypes transactionType;
  final double cartValue;

  SelectCartPaymentOptionArgs({
    required this.transactionType,
    required this.cartValue,
  });
}

class VerifyCartPurchaseArgs {
  final String orderRef;

  const VerifyCartPurchaseArgs({
    required this.orderRef,
  });
}

//equity arg
class StockDetailsArgs {
  final String symbolName;
  final double close;
  final double change;
  final double percentage;
  final String industry;
  final String name;
  final String icon;

  StockDetailsArgs({
    required this.symbolName,
    required this.close,
    required this.change,
    required this.percentage,
    required this.industry,
    required this.name,
    required this.icon,
  });
}

class SmallcaseLoginArgs {
  final String? smallcaseAuthToken;
  final String broker;

  SmallcaseLoginArgs({
    required this.smallcaseAuthToken,
    required this.broker,
  });
}

class BuySellBottomSheetArgs {
  final String type;
  final double? price;
  final String? symbol;
  final String? authToken;

  BuySellBottomSheetArgs({
    required this.type,
    required this.price,
    required this.symbol,
    required this.authToken,
  });
}

class ImportLoanPhoneValidationArgs {
  final String questionKey;
  final String answerKey;
  final String accessToken;
  final String phoneNum;

  ImportLoanPhoneValidationArgs({
    required this.questionKey,
    required this.answerKey,
    required this.accessToken,
    required this.phoneNum,
  });
}

class OtherLoanDetailScreenArgs {
  final String accountID;

  OtherLoanDetailScreenArgs({
    required this.accountID,
  });
}

// Category Questions Screen arguments
class CategoryQuestionsArgs {
  final String title;
  final String? category;
  final String? query;

  CategoryQuestionsArgs({
    required this.title,
    this.category,
    this.query,
  });
}

// Category Questions Detail Screen arguments
class CategoryQuestionsDetailArgs {
  final String title;
  final String articletitle;
  final String articleid;
  final String query;

  CategoryQuestionsDetailArgs({
    required this.title,
    required this.articletitle,
    required this.articleid,
    required this.query,
  });
}

class AddAddressScreenArgs {
  final String? fullName;
  final String? address;
  final DGUserCity? city;
  final DGUserState? state;
  final String? pincode;
  final String? mobileNumber;

  AddAddressScreenArgs({
    this.fullName,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.mobileNumber,
  });
}

class RetirementCorpusArgs {
  final int monthlyIncome;
  final int monthlyExpense;
  final int existingSavings;
  final String investmentStyle;
  final String postRetirementStyle;
  final int retirementAge;
  final String requestID;

  RetirementCorpusArgs({
    required this.monthlyIncome,
    required this.monthlyExpense,
    required this.existingSavings,
    required this.investmentStyle,
    required this.postRetirementStyle,
    required this.retirementAge,
    required this.requestID,
  });
}

class RetirementPassBookArgs {
  final String requestID;
  final String refreshNeeded;

  RetirementPassBookArgs({
    required this.requestID,
    required this.refreshNeeded,
  });
}

class RetirementFinancialDetailsArgs {
  final int income;
  final int expence;
  final int saving;
  RetirementFinancialDetailsArgs({
    required this.income,
    required this.expence,
    required this.saving,
  });
}

class RetirementAgeArgs {
  final int income;
  final int expence;
  final int saving;
  final String selectedOption;
  final String isSafe;
  RetirementAgeArgs({
    required this.income,
    required this.expence,
    required this.saving,
    required this.selectedOption,
    required this.isSafe,
  });
}

class RetirementEPFTransactionDetailsArgs {
  final Company company;
  final String name;
  final String uan;
  RetirementEPFTransactionDetailsArgs({
    required this.company,
    required this.name,
    required this.uan,
  });
}

class CapitalGainReportArgs {
  final String financialYear;

  CapitalGainReportArgs({
    required this.financialYear,
  });
}

class GoalSettingArgs {
  final String goalName;
  final String goalType;

  GoalSettingArgs({
    required this.goalName,
    required this.goalType,
  });
}

class GoalDashboardArgs {
  final String goalName;
  final String id;

  GoalDashboardArgs({
    required this.goalName,
    required this.id,
  });
}
