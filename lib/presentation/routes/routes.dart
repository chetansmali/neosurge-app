import '../screens/dashboard/dashboard_screen.dart';
import '../screens/mutual_funds/neo_baskets_tab.dart';
import '../screens/mutual_funds/lumpsum/invest_lumpsum_screen.dart';
import '../screens/mutual_funds/sip/invest_sip_screen.dart';

class Routes {
  Routes._();

  static const String initial = '/';
  static const String home = 'home';
  static const String logout = 'logout';

  static const String test = 'test';

  ///Routes for user onboarding

  static const String kycRoutingScreen = 'kycRoutingScreen';

  static const String kycVerifiedFlowScreen = 'kycVerifiedFlowScreen';
  static const String nonKycFlowScreen = 'nonKycFlowScreen';

  // static const String kycCreateAccountScreen = 'kycCreateAccountScreen';
  static const String nonKycCreateAccountScreen = 'nonKycCreateAccountScreen';

  static const String onboarding = 'onboarding';
  static const String signUp = 'signUp';

  static const String kycOnboarding = 'kycOnboarding';
  static const String nonKycOnboarding = 'nonKycOnboarding';
  static const String comfirmPanUpload = 'comfirmPan';
  static const String comfirmPOAUpload = 'comfirmPOA';
  static const String addPersonalDetails = 'addPersonalDetails';
  static const String addAddressDetails = 'addAddressDetails';
  static const String addBankDetails = 'addBankDetails';
  static const String addBankErrorScreen = 'addBankErrorScreen';
  static const String uploadChequeScreen = 'uploadChequeScreen';
  static const String addNomineeDetails = 'addNomineeDetails';
  static const String confirmPanDetails = 'confirmPanDetails';
  static const String digitalSignature = 'digitalSignature';
  static const String digitalSignatureCapture = 'digitalSignatureCapture';
  static const String bankAccountVerify = 'bankAccountVerify';
  static const String uploadPanScreen = 'uploadPanScreen';
  static const String eSignSubmitWebView = 'eSignSubmitWebView';
  // static const String verifyPan = 'verifyPan';

  ///Mpin Routes
  static const String mPinFpLogin = 'mPinFpLogin';
  static const String forgotMPinOtp = 'forgotMPinOtp';
  static const String forgotMPinSetMPin = 'forgotMPinSetMPin';

  // Mutual Funds
  static const String mutualFunds = 'mutualFunds';
  static const String fundsListBySubcategory = 'fundsListBySubcategory';
  static const String fundsListByInvestmentIdea = 'fundsListByInvestmentIdea';
  static const String mutualFundsCart = 'mutualFundsCart';
  static const String selectCartPaymentOption = 'selectCartPaymentOption';
  static const String verifyCartTrasaction = 'verifyCartTrasaction';
  static const String statusCartTrasaction = 'statusCartTrasaction';
  static const String capitalGainDetails = 'capitalGainDetails';
  static const String finacialYearReportScreen = 'finacialYearReportScreen';

  ///Mandate Routes
  static const String setupAutoMandate = 'setupAutoMandate';
  static const String createAutoMandate = 'createAutoMandate';

  /// Routes to [AutoMandateStatusScreen]
  static const String autoMandateStatus = 'autoMandateSuccess';

  ///Assisted Service
  static const String unlockAssistedServiceInfo = 'assistedServiceDetails';
  static const String assistedServicePaymentWebView =
      'assistedServicePaymentWebView';

  static const String startAssistedService = 'startAssistedService';
  static const String assistedServiceQuiz = 'assistedServiceQuiz';
  static const String assistedServiceOtp = 'assistedServiceOtp';
  static const String analyseAssistedService = 'analyseAssistedService';
  static const String fundSuggestion = 'fundSuggestion';
  static const String assistedOrderSummary = 'assistedOrderSummary';

  //Dashboard Routes
  ///Route pointing to [DashboardScreen]
  static const String dashboard = 'dashboard';

  ///Route pointing to [InvestLumpsumScreen]
  static const String investLumpsum = 'investLumpsum';

  ///Route pointing to [InvestSIPScreen]
  static const String investSIP = 'investSIP';

  ///Route pointing to [DetailedFundView]
  static const String detailedFundView = 'detailedFundView';
  static const String lumpsumOrderSummaryScreen = 'lumpsumOrderSummary';
  static const String sipOrderSummaryScreen = 'sipOrderSummary';
  static const String mfFilterSortScreen = 'mfFilterSort';
  static const String allHoldingsScreen = 'allHoldings';
  static const String paymentWebView = 'paymentWebView';
  static const String viewEditNominee = 'viewEditNominee';

  ///Routes for [ImportExternalFundsScreen]
  static const String importExternalFundsPan = 'importExternalFundsPan';
  static const String importExternalFundsVerifyOtp =
      'importExternalFundsVerifyOtp';
  static const String importingFundScreen = 'importingFundScreen';
  static const String importFundSuccess = 'importFundSuccess';
  static const String importFundFail = 'importFundFail';
  static const String brokerHoldingFundScreen = 'brokerHoldingFundScreen';
  static const String portfolioAnalysis = 'portfolioAnalysis';

  // Systematic Plan Detail Routes
  static const String sipDetail = 'sipDetailScreen';
  static const String stpDetail = 'stpDetailScreen';
  static const String swpDetail = 'swpDetailScreen';
  static const String mySystematicPlans = 'mySystematicPlans';
  static const String fundTransactions = 'fundTransactionsScreen';
  static const String redeem = 'redeemScreen';
  static const String redeemVerifyOtp = 'redeemVerifyOtpScreen';
  static const String mfTransactionStatus = 'mfTransactionStatusScreen';
  static const String mfOrderStatusScreen = 'mfOrderStatusScreen';
  static const String cancelSipSuccess = 'cancelSipSuccess';
  static const String switchFundList = 'switchFundList';
  static const String switchFund = 'switchFund';
  static const String switchVerifyOtp = 'switchVerifyOtp';
  static const String stpFundList = 'stpFundList';
  static const String stpFund = 'stpFund';
  static const String stpVerifyOtp = 'stpVerifyOtp';
  static const String swpFund = 'swpFund';
  static const String swpVerifyOtp = 'swpVerifyOtp';

  //Digital Gold
  static const String digitalGold = '/digitalGold';
  static const String checkOut = 'checkOut';
  static const String digitalGoldSips = 'digitalGoldSips';
  static const String digitalGoldPayment = 'digitalGoldPayment';
  static const String digitalGoldTransactionStatus =
      'digitalGoldTransactionStatus';
  static const String digitalGoldDelivery = 'digitalGoldDelivery';
  static const String digitalGoldDeliveryDetailedView =
      'digitalGoldDeliveryDetailedView';
  static const String selectDeliveryAddress = 'selectDeliveryAddress';
  static const String deliveryCheckOut = 'deliveryCheckOut';
  static const String deliveryPayment = 'deliveryPaymentScreen';
  static const String digitalGoldOrderStatus = 'digitalGoldOrderStatus';
  static const String digitalGoldInvestmentDetails =
      'digitalGoldInvestmentDetails';
  static const String digitalGoldTransactions = 'digitalGoldTransactions';

  //Profile
  static const String profile = 'profile';
  static const String neoBasketOrders = 'neoBasketOrders';
  static const String accountDetails = 'accountDetails';
  static const String deliveryAddress = 'deliveryAddress';
  static const String addDeliveryAddress = 'addDeliveryAddress';
  static const String bankDetails = 'bankDetails';
  static const String mandateDetails = 'mandateDetails';
  static const String closeAllSipScreen = 'closeAllSipScreen';
  static const String sipLinkedScreen = 'sipLinkedScreen';
  static const String verifyDeleteMandateScreen = 'verifyDeleteMandateScreen';
  static const String bankDetailsFromMandate = 'bankDetailsFromMandate';
  static const String editBankIfsc = 'editBankIfsc';
  static const String addProfileBankDetails = 'addProfileBankDetails';
  static const String securityOptions = 'securityOptions';
  static const String detailedBankView = 'detailedBankView';
  static const String authoriseMandateWebView = 'authoriseMandateWebView';
  static const String reports = 'reports';
  static const String aboutUs = 'aboutUs';
  static const String aboutWebView = 'aboutWebView';
  static const String orders = 'orders';
  static const String newOrderScreen = 'newOrderScreen';
  static const String mFOrdersScreen = 'mFOrdersScreen';
  static const String goldOrdersScreen = 'goldOrdersScreen';

  //Notifications
  static const String notifications = 'notifications';

  /// Route for [NeoBasketsTabView]
  static const String basketDetailsScreen = 'basketDetailsScreen';
  static const String buyBasketScreen = 'buyBasket';
  static const String buyBasketOrderSummaryScreen = 'buyBasketOrderSummary';
  static const String buyBasketOtpScreen = 'buyBasketOtp';
  static const String buyBasketStatus = 'buyBasketStatus';
  static const String basketPortfolioDetail = 'basketPortfolioDetail';
  static const String basketTrasactionScreen = 'basketTrasactionScreen';
  static const String basketOrderTransactionDetailsScreen =
      'basketOrderTransactionDetailsScreen';

  /// Route for Redeem Basket
  static const String redeemBasket = 'redeemBasket';
  static const String redeemBasketNotAllow = 'redeemBasketNotAllow';
  static const String redeemIndividualFundSelection =
      'redeemIndividualFundSelection';
  static const String redeemElssIndividualFundSelection =
      'redeemElssIndividualFundSelection';
  static const String redeemIndividualFund = 'redeemIndividualFund';
  static const String redeemOrderSummary = 'redeemOrderSummary';
  static const String redeemBasketOtpVerify = 'redeemBasketOtpVerify';
  static const String redeemBasketStatusScreen = 'redeemBasketStatusScreen';
  //equity
  static const String equity = 'equity';
  static const String equityLogin = 'equityLogin';
  static const String equityHomeSearch = 'equityHomeSearch';
  static const String equityHomeNotification = 'equityHomeNotification';
  static const String equitySignup = 'equitySignup';
  static const String equityTermsConditions = 'equityTermsConditions';
  static const String exploreStockDetail = 'exploreStockDetail';
  static const String equityInvest = 'equityExplore';
  static const String equityBuySellBottomSheet = 'equityBuySellBottomSheet';
  static const String equityInvesScreen = 'equityInvesScreen';
  static const String equitySmartWatchlistHoldings =
      'equitySmartWatchlistHoldings';

  static const String marketNews = 'marketNews';
  static const String marketDigest = 'marketDigest';
  static const String lamf = 'LAMFScreen';
  // static const String smartFilter = 'SmartFilter';
  static const String smartIndex = 'SmartIndex';
  static const String allIndexScreen = 'AllIndexScreen';
  static const String smartSubsidiaryScreen = 'SmartSubsidiaryScreen';
  static const String pledgedMFScreen = 'PledgedMFsScreen';

  //ImportLoans
  static const String importLoanFormScreen = "importLoanFormScreen";
  static const String importLoanPhoneValidation = "importLoanPhoneValidation";
  static const String otherLoansDetailedScreen = "otherLoansDetailedScreen";
  //contactUs
  static const String contactUs = "contactUs";
  static const String categoryQuestions = "categoryQuestions";
  static const String categoryQuestionsDetail = "categoryQuestionsDetail";
  static const String contactUsForm = "contactUsForm";

  // NeoCards
  static const String neoCardDiscovery = 'neoCardsDiscovery';

  // Retirement
  static const String retirementOTPScreen = 'retirementOTPScreen';
  static const String planYourFutureScreen = 'planYourFutureScreen';
  static const String financialDetailsScreens = 'financialDetailsScreens';
  static const String tellUsScreen = 'tellUsScreen';
  static const String retirementAgeScreen = 'retirementAgeScreen';
  static const String retirementETFDetailsScreen = 'retirementETFDetailsScreen';
  static const String retirementEPFTransactionDetails =
      'retirementEPFTransactionDetails';

  // Goal Planning
  static const String goalPlanningOnboardScreen = 'GoalPlanningOnboardScreen';
  static const String goalPlanningReturnUser = 'GoalPlanningReturnUser';
  static const String goalChoiceScreen = 'GoalChoiceScreen';
  static const String goalSettingScreen = 'GoalSettingScreen';
  static const String goalPlanDashboardScreen = 'GoalPlanDashboardScreen';
}
