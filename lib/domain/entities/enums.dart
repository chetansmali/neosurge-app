import 'package:json_annotation/json_annotation.dart';

enum ReturnsType {
  oneYear,
  threeYear,
  fiveYear;

  @override
  String toString() {
    switch (this) {
      case ReturnsType.oneYear:
        return '1Y Returns';
      case ReturnsType.threeYear:
        return '3Y Returns';
      case ReturnsType.fiveYear:
        return '5Y Returns';
    }
  }
}

enum HeaderApiKeyType {
  equity,
  mutualFundImport,
}

enum BankDetailsFetchType { manual, auto }

enum GoldSilverTimePeriod { sixMonth, oneYear, threeYear, fiveYear, all }

enum MfTransactionStatus { success, failure, pending }

enum MFSortBy {
  currInvested,
  currentNav,
  absReturn,
  gainLoss;

  @override
  String toString() {
    switch (this) {
      case MFSortBy.currInvested:
        return 'Current(Invested)';
      case MFSortBy.currentNav:
        return 'Current NAV';
      case MFSortBy.absReturn:
        return 'Abs Return';
      case MFSortBy.gainLoss:
        return 'Gain/Loss';
    }
  }
}

enum MutualFundTimePeriod {
  oneMonth,
  sixMonth,
  oneYear,
  threeYear,
  fiveYear,
  all
}

enum OrderType { mf, gold, neobasket }

enum InvestmentType { monthlySip, lumpsum }

enum GoldSilverRatesQuantity { oneGram, tenGram }

enum DGTransactionType {
  @JsonValue('buy')
  buy,
  @JsonValue('sell')
  sell,
  @JsonValue('delivery')
  delivery,
  @JsonValue('buy/sell')
  buySell;

  @override
  String toString() {
    switch (this) {
      case DGTransactionType.buy:
        return 'Buy';
      case DGTransactionType.sell:
        return 'Sell';
      case DGTransactionType.delivery:
        return 'Delivery';
      case DGTransactionType.buySell:
        return 'Buy/Sell';
    }
  }
}

enum MetalType {
  @JsonValue('gold')
  gold,
  @JsonValue('silver')
  silver;

  @override
  String toString() {
    switch (this) {
      case MetalType.gold:
        return 'Gold';
      case MetalType.silver:
        return 'Silver';
    }
  }
}

enum GoldSilverUnitType {
  @JsonValue('gms')
  gram,
  @JsonValue('inr')
  rupee,
}

//This will be used in last step of account creation process
enum AccountCreationStep { eSign, investor, mf }

enum DocumentType {
  @JsonValue('pan')
  pan,
  @JsonValue('aadhar')
  aadhar,
  @JsonValue('voter')
  voterId,
  @JsonValue('dl')
  drivingLicense,
  @JsonValue('passport')
  passport,
}

enum DGOrderType {
  @JsonValue('BUY')
  buy,
  @JsonValue('SELL')
  sell,
  @JsonValue('DELIVERY')
  delivery,
}

enum SocialLoginType {
  @JsonValue('GOOGLE')
  google,
  @JsonValue('APPLE')
  apple,
}

enum Gender {
  @JsonValue(1)
  male,
  @JsonValue(2)
  female,
  @JsonValue(3)
  transgender
}

enum DgTransactionStatus {
  @JsonValue('SUCCESS')
  success,
  @JsonValue('PROCESSING')
  processing,
  @JsonValue('FAILED')
  failure,
  @JsonValue('ALL')
  all;

  @override
  String toString() {
    switch (this) {
      case DgTransactionStatus.success:
        return 'Success';
      case DgTransactionStatus.processing:
        return 'Processing';
      case DgTransactionStatus.failure:
        return 'Failed';
      case DgTransactionStatus.all:
        return 'All';
    }
  }
}

enum Nationality {
  @JsonValue('indian')
  indian,
  @JsonValue('nri')
  nri
}

enum UserMandateStatus {
  //rejected
  //  recieved
  //  submitted
  //  approved
  //  created
  @JsonValue('FAILED')
  failed,
  @JsonValue('REJECTED')
  rejected,
  @JsonValue('RECEIVED')
  received,
  @JsonValue('SUBMITTED')
  submitted,
  @JsonValue('APPROVED')
  approved,
  @JsonValue('CREATED')
  created;

  @override
  String toString() {
    switch (this) {
      case UserMandateStatus.failed:
        return 'Failed';
      case UserMandateStatus.rejected:
        return 'Rejected';
      case UserMandateStatus.received:
        return 'Received';
      case UserMandateStatus.submitted:
        return 'Submitted';
      case UserMandateStatus.approved:
        return 'Approved';
      case UserMandateStatus.created:
        return 'Created';
    }
  }
}

enum MFTransactionTypes {
  @JsonValue(1)
  lumpsum,
  @JsonValue(2)
  sip,
  @JsonValue(3)
  redemption,
  @JsonValue(4)
  switchTransaction,
  @JsonValue(5)
  stp,
  @JsonValue(6)
  swp,
  @JsonValue(7)
  stopSip,
  @JsonValue(8)
  stopSwp,
  @JsonValue(9)
  assistedService,
  @JsonValue(10)
  basket,
  @JsonValue(11)
  cart;

  @override
  String toString() {
    switch (this) {
      case MFTransactionTypes.lumpsum:
        return 'Lumpsum';
      case MFTransactionTypes.sip:
        return 'SIP';
      case MFTransactionTypes.redemption:
        return 'Redeem';
      case MFTransactionTypes.switchTransaction:
        return 'Switch';
      case MFTransactionTypes.stp:
        return 'STP';
      case MFTransactionTypes.swp:
        return 'SWP';
      case MFTransactionTypes.stopSip:
        return 'Stop SIP';
      case MFTransactionTypes.stopSwp:
        return 'Stop SWP';
      case MFTransactionTypes.assistedService:
        return 'Assisted Service';
      case MFTransactionTypes.basket:
        return 'Basket';
      case MFTransactionTypes.cart:
        return 'Cart';
    }
  }
}

enum MFPaymentTypes {
  @JsonValue('NETBANKING')
  netbanking,
  @JsonValue('UPI')
  upi,
}

enum SipInternalStatus {
  @JsonValue('initated')
  initiated,
  @JsonValue('submitted')
  submitted,
}

enum SystematicPlansStatus {
  @JsonValue('ACTIVATED')
  activated,
  @JsonValue('DEACTIVATED')
  deactivated,
  @JsonValue('SUCCESS')
  success,
}

enum MFPurchaseType {
  @JsonValue('PURCHASE')
  purchase,
  @JsonValue('ADDITIONAL_PURCHASE')
  additionalPurchase,
}

enum FundTransactionTypeString {
  @JsonValue('purchase')
  invest,
  @JsonValue('redemption')
  redemption;

  @override
  String toString() {
    switch (this) {
      case FundTransactionTypeString.invest:
        return 'Invest';
      case FundTransactionTypeString.redemption:
        return 'Redeem';
    }
  }
}

enum FundType {
  units,
  amount,
}

enum MFOrderStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('Successful')
  success,
  @JsonValue('Failed')
  failed;

  @override
  String toString() {
    switch (this) {
      case MFOrderStatus.pending:
        return 'Pending';
      case MFOrderStatus.success:
        return 'Success';
      case MFOrderStatus.failed:
        return 'Failed';
    }
  }
}

enum BasketInvestmentType {
  lumpsum,
  sip;

  @override
  String toString() {
    switch (this) {
      case BasketInvestmentType.lumpsum:
        return 'Lumpsum';
      case BasketInvestmentType.sip:
        return 'SIP';
    }
  }
}

enum BasketTransactionStatus {
  pending,
  success,
  failed;

  @override
  String toString() {
    switch (this) {
      case BasketTransactionStatus.pending:
        return 'Pending';
      case BasketTransactionStatus.success:
        return 'Success';
      case BasketTransactionStatus.failed:
        return 'Failed';
    }
  }
}

enum EquityChartTimePeriod {
  oneDay,
  oneWeek,
  oneMonth,
  oneYear,
  fiveYear,
}

enum EquityStockSortTypes {
  noOrder,
  ase,
  dse,
  lowHigh,
  mcLowHigh,
  mcHighLow,
  highLow,
  mplowHigh,
  mphighLow;

  @override
  String toString() {
    switch (this) {
      case EquityStockSortTypes.noOrder:
        return '';
      case EquityStockSortTypes.lowHigh:
        return 'marketCapitalization,ASC';
      case EquityStockSortTypes.highLow:
        return 'marketCapitalization,DESC';
      case EquityStockSortTypes.mcLowHigh:
        return 'market_capitalization,ASC';
      case EquityStockSortTypes.mcHighLow:
        return 'market_capitalization,DESC';
      case EquityStockSortTypes.mplowHigh:
        return 'close,ASC';
      case EquityStockSortTypes.mphighLow:
        return 'close,DESC';
      case EquityStockSortTypes.ase:
        return 'symbol,ASC';
      case EquityStockSortTypes.dse:
        return 'symbol,DESC';
    }
  }
}

enum ETFStockSortTypes {
  closeAsc,
  closeDesc,
  symbolAsc,
  symbolDesc;

  @override
  String toString() {
    switch (this) {
      case ETFStockSortTypes.closeAsc:
        return 'close,ASC';
      case ETFStockSortTypes.closeDesc:
        return 'close,DESC';
      case ETFStockSortTypes.symbolAsc:
        return 'symbol,ASC';
      case ETFStockSortTypes.symbolDesc:
        return 'symbol,DESC';
    }
  }
}

enum EquityExploreBannerTimePeriod {
  daily,
  weekly,
  monthly,
  yearly,
}

enum EquityFundamentalTimePeriod { oneMonth, oneYear, fiveYear }

enum EquityBrokers {
  groww,
  aliceblue,
  angelbroking,
  axis,
  dhan,
  edelweiss,
  fisdom,
  fivepaisa,
  fundzbazar,
  hdfc,
  icici,
  iifl,
  kite,
  kotak,
  motilal,
  trustline,
  upstox
}

enum DiscoveryAnimationType {
  forwardNeoCardsAnimation,
  forwardNeoPassesAnimation,
  forwardTransactionAnimation,
  discoveryAnimationCompleted,
}

enum CapitalGainsReportSortType {
  @JsonValue('FY 2023 - FY 2024')
  FY2023FY2024,
  @JsonValue('FY 2022 - FY 2023')
  FY2022FY2023,
  @JsonValue('FY 2021 - FY 2022')
  FY2021FY2022,
  @JsonValue('FY 2020 - FY 2021')
  FY2020FY2021,
  @JsonValue('FY 2019 - FY 2020')
  FY2019FY2020,
}

enum SpendPostRetirement {
  same,
  more,
  less,
}

enum RetirementSaving {
  safe,
  aggressive,
}

enum GoalType {
  Custom,
  Retirement,
}

// enum AugmontStatus {
//   //put("awaiting_approval", "Awaiting approval");
//   // 			put("bank_verified", "Bank verified");
//   // 			put("cancelled", "Cancelled");
//   // 			put("completed", "Completed");
//   // 			put("failed", "Failed");
//   // 			put("internal_error", "Internal error");
//   // 			put("pending", "Pending");
//   // 			put("rejected", "Rejected");
//
//   @JsonValue('Awaiting Approval')
//   awaitingApproval,
//   @JsonValue('Bank Verified')
//   bankVerified,
//   @JsonValue('Cancelled')
//   cancelled,
//   @JsonValue('Completed')
//   completed,
//   @JsonValue('Failed')
//   failed,
//   @JsonValue('Internal Error')
//   internalError,
//   @JsonValue('Pending')
//   pending,
//   @JsonValue('Rejected')
//   rejected,
//   @JsonValue('Delivered to client')
//   deliveredToClient;
//
//   @override
//   String toString() {
//     switch (this) {
//       case AugmontStatus.awaitingApproval:
//         return 'Awaiting Approval';
//       case AugmontStatus.bankVerified:
//         return 'Bank Verified';
//       case AugmontStatus.cancelled:
//         return 'Order Cancelled';
//       case AugmontStatus.completed:
//         return 'Transaction Completed';
//       case AugmontStatus.failed:
//         return 'Transaction Failed';
//       case AugmontStatus.internalError:
//         return 'Internal Error';
//       case AugmontStatus.pending:
//         return 'Order Pending';
//       case AugmontStatus.rejected:
//         return 'Order Rejected';
//       case AugmontStatus.deliveredToClient:
//         return 'Delivered to client';
//     }
//   }
// }
