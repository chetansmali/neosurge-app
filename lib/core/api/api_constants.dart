class ApiConstants {
  ApiConstants._();

  static const String baseDevUrl = 'https://bullsurge.mindstack.in';
  static const String baseProdUrl = 'https://mutualfunds.neosurge.money';
  static const String apiVersion = '/api/v1';
  static const String aboutUs = 'https://www.neosurge.money/about';
  static const String faq = '/faq';
  static const String termsAndConditions = '/terms-conditions';

  static const String _userManagement = '/usermgmt';

  static const String _goldService = '/goldservice';

  static const String _personalDetails = '/personalDetails';

  static const String _addressDetails = '/addressDetails';

  static const String _kycService = '/kycservice';

  static const String _nomineeDetails = '/nominee_details';

  static const String _transactionService = '/transactionservice';

  static const String _notificationService = '/appnotificationservice';

  static const String _assistedServiceRiskProfile = '/risk_profiles';

  static const String _assistedServiceRazorpay = '/admin_service/razor_pay';

  static const String _assistedService = '/admin_service/assisted';

  static const String refreshTokenEndPoint =
      '$_userManagement/jwt_token/verify';

  static const String loginWithEmailEndPoint = '$_userManagement/user/login';

  static const String verifyEmailOtpEndPoint =
      '$_userManagement/user/email_verify';

  static const String getUserEndPoint = '$_userManagement/user/get_user';

  static const String socialLoginEndPoint =
      '$_userManagement/user/social_login';
  static const String generateMobileOTPEndPoint =
      '$_userManagement/otp/generate_otp';
  static const String verifyMobileOTPEndPoint =
      '$_userManagement/otp/verify_otp';
  static const String loginWithMPinEndPoint =
      '$_userManagement/user/mpin_login';
  static const String forgotMPinGenerateOtpEndPoint =
      '$_userManagement/user/forgot_mpin';
  static const String forgotMPinVerifyOtpEndPoint =
      '$_userManagement/user/verify_forgot_mpin_otp';
  static const String setMPinEndPoint = '$_userManagement/user/set_mpin';
  static const String getKycLastRouteEndPoint =
      '$_userManagement/user/get_last_routed_screen';
  static const String getUserBankDetailsEndPoint =
      '$_userManagement/bankDetails/getBankDetailsByUserId';
  static const String getUserPrimaryBankDetailsEndPoint =
      '$_userManagement/bankDetails/getPrimaryBank';
  static const String addUpdateProfilePhotoEndPoint =
      '$_userManagement/ProfilePhoto/addOrUpdateProfilePhoto';

  static const String getPanStatusEndPoint =
      '$_kycService/kycStatus/get_pan_status';
  static const String confirmPanEndPoint = '$_kycService/kycStatus/confirm_pan';
  static const String uploadProofOfAddressEndPoint =
      '$_kycService/doc_uploads/kyc_address_proof_upload';
  static const String uploadProofOfIdentityOrProfilePhotoEndPoint = ''
      '$_kycService/doc_uploads/pan_and_profile_upload';
  static const String signatureUploadEndPoint =
      '$_kycService/doc_uploads/sign_upload';
  static const String kycVideoUploadEndPoint =
      '$_kycService/doc_uploads/video_upload';
  static const String uploadAdhaarNumEndPoint =
      '$_kycService/doc_uploads/upload_aadhar_number';
  static const String getKycVideoOtpEndPoint =
      '$_kycService/getAll/get_video_otp';
  static const String videoUploadEndPoint =
      '$_kycService/doc_uploads/video_upload';
  static const String kycCreateRequestEndPoint =
      '$_kycService/kyc_create_request/submit';
  static const String cancelledChequeUploadEndPoint =
      '$_userManagement/bankDetails/add_or_update_cancel_cheque';
  static const String uploadBankDetailsEndPoint =
      '$_userManagement/bankDetails/addOrUpdateBankDetails';
  static const String verifyBankAccountEndPoint =
      '$_userManagement/bankDetails/bankAccountVerifications';
  static const String getBankDetailsByIfscEndPoint =
      '$_userManagement/bankDetails/get_bankdetails_by_ifsc';

  static const String uploadPersonalDetailsEndPoint =
      '$_userManagement$_personalDetails/updatePersonalDetails';
  static const String getPersonalDetailsEndPoint =
      '$_personalDetails/getPersonalDetailsByUserId';

  static const String uploadFatcaDetailsEndPoint =
      '$_kycService/user_fatca_details/add_or_update';

  static const String ocrReadingEndPoint = '$_kycService/pichain/ocrReading';
  static const String chequeOcrReadingEndPoint =
      '$_kycService/pichain/cancelChequeocrReading';

  static const String uploadNomineeDetailsEndPoint =
      '$_userManagement$_nomineeDetails/add_or_update';
  static const String deleteNomineeDetailsEndPoint =
      '$_userManagement$_nomineeDetails/delete_nominee_by_id';

  static const String getAllCountryEndPoint =
      '$_userManagement/getAll/getAllCountries';

  static String getPinCodeDataEndPoint =
      '$_userManagement/getAll/getAddressDetailsByPinCode';

  static String getDecentroAddressEndPoint =
      '$_userManagement/addressDetails/pull';

  static const String uploadAddressDetailsEndPoint =
      '$_userManagement$_addressDetails/addOrUpdateAddressDetails';
  static const String getAddressDetailsEndPoint =
      '$_addressDetails/getAddressDetails';

  static const String eSignSubmitEndPoint =
      '$_kycService/kyc_create_request/submit_esign';

  static const String updateEsignResultEndPoint =
      '$_kycService/kyc_create_request/esign_postback_url';

  static const String createInvestorAccountEndPoint =
      '$_kycService/investor_account/create';

  static const String updateInvestorAccountEndPoint =
      '$_kycService/investor_account/update';

  static const String createMfAccountEndPoint =
      '$_kycService/mf_investment_account/create';

  static const String getKycAddressDetailsEndPoint =
      '$_userManagement/addressDetails/getAddressDetails';
  static const String getKycPersonalDetailsEndPoint =
      '$_userManagement/personalDetails/getPersonalDetailsByUserId';
  static const String getKycBankDetailsEndPoint =
      '$_userManagement/bankDetails/getBankDetailsByUserId';
  static const String getKycNomineeDetailsEndPoint =
      '$_userManagement$_nomineeDetails/get_all_nominee_by_userid';
  static const String getKycFatcaDetailsEndPoint =
      '$_kycService/user_fatca_details/get';
  static const String getKycDataEndPoint =
      '$_kycService/doc_uploads/get_kyc_data';
  static const String retakeKyc = '$_kycService/kycStatus/retake_kyc';

  //DigitalGold EndPoints

  static const String createGoldUserEndPoint =
      '$_goldService/user/create_commodity_user';
  static const String acceptTermsAndConditionsEndPoint =
      '$_goldService/user/accept_terms_conditions';
  static const String createGoldKycEndPoint = '$_goldService/kyc/update_kyc';

  static const String getGoldUserDetailsEndPoint =
      '$_goldService/user/get_user_data';
  static const String getDGDeliveryTransactionListEndPoint =
      '$_goldService/razor_pay/get_delivery_list_by_status';
  static const String getDGTransactionListEndPoint =
      '$_goldService/razor_pay/get_transaction_list_by_status';

  static const String getGoldGraphDataEndPoint =
      '$_goldService/graph/historic_data';
  static const String getGoldSilverRatesEndPoint =
      '$_goldService/rate/get_current_rate';
  static const String getCheckOutRatesEndPoint =
      '$_goldService/rate/checkout_rate';
  static const String goldCreateOrderEndPoint =
      '$_goldService/razor_pay/create_order';
  static const String goldPostPaymentEndPoint =
      '$_goldService/razor_pay/post_payment';
  static const String getDeliveryProductsByMetalTypeEndPoint =
      '$_goldService/delivery/get_all_product_list_by_metal_type';
  static const String deliveryCheckoutEndPoint =
      '$_goldService/delivery/checkout_response';
  static const String sellGoldSilverEndPoint =
      '$_goldService/buy_sell/sell_request';
  static const String getDGDeliveryAddressListEndPoint =
      '$_goldService/address_details/get_by_user';
  static const String addDGDeliveryAddressEndPoint =
      '$_goldService/address_details/add';
  static const String deleteDGDeliveryAddressEndPoint =
      '$_goldService/address_details/delete_by_id';
  static const String getDGStatesListEndPoint =
      '$_goldService/states/get_all_states';
  static const String getDGCitiesListByStateIDEndPoint =
      '$_goldService/states/city_list';
  static const String addDGBankAccountEndPoint =
      '$_goldService/bank_details/add_bank';

  static const String addProfileBankDetailsEndPoint =
      '$_userManagement/bankDetails/addnewbank';

  static const String updateProfileBankIfscEndPoint =
      '$_userManagement/bankDetails/update_profile_bank_details';

  static const String updatePrimaryBankAccountEndPoint =
      '$_userManagement/bankDetails/update_primary_account_by_id';

  //Mutual Fund EndPoints

  static const String getMutualFunds = '/mutualfund/pulselab/SearchAllFundsWeb';
  static const String getMutualFundsBySubCategory = '/mutualfund/explore';

  static const String getNavMFGraph = '/mutualfund/nav/navhistory';
  static const String getMutualFundDetail =
      '/mutualfund/pulselab/get_fund_details';
  static const String getHoldingAnalysis =
      '/mutualfund/pulselab/analytical-data';
  static const String getSectorAllocationEndPoint =
      '/mutualfund/pulselab/schemeholdingssector';
  static const String getExploreDIYDataEndPoint =
      '/mutualfund/explore/dashboard/';
  static const String getInvestmentIdeasEndPoint =
      '/mutualfund/explore/topmutualfundfilters/';
  static const String getFundsByInvestmentIdeasEndPoint =
      '/mutualfund/explore/topmutualfunds/';
  static const String getFundHoldings =
      '/mutualfund/schemeholdings/schemeholdingssecurity';
  static const String getFundByIsin = '/mutualfund/pulselab/SearchByIsin';

  static const String schemePresent = '/mutualfund/cart/schemepresent';
  static const String addToCart = '/mutualfund/cart/addtocart';
  static const String editCart = '/mutualfund/cart/editcart';
  static const String getCartLumpsumFunds = '/mutualfund/cart/getlumpsumcart';
  static const String getCartSipFunds = '/mutualfund/cart/getsipcart';
  static const String clearCartFunds = '/mutualfund/cart/emptycart';
  static const String removeFundFromCart = '/mutualfund/cart/deletecartitem';
  static const String initiateCartLumpsumPurchase =
      '$_transactionService/cart/initiatelumpsumpurchase';
  static const String initiateCartSipPurchase =
      '$_transactionService/cart/initiatesippurchase';
  static const String verifyCartPurchase =
      '$_transactionService/cart/verifycartpurchase';

  static const String getCapitalGainReport =
      '$baseProdUrl/api/baskets/portfolio/gains-report';

  static const String generateCapitalGainReportFile =
      '$baseProdUrl/api/baskets/portfolio/gains-report-generate-csv';

  //Transaction Service
  static const String addUserMandateEndPoint =
      '$_transactionService/usermandate/addMultipleUserMandate';
  static const String getUserMandatesEndPoint =
      '$_transactionService/usermandate/getUserMandate';
  static const String getUserMandateByIdEndPoint =
      '$_transactionService/usermandate/getUserMandateByMandateId';
  static const String deleteUserMandateByIdEndPoint =
      '$_transactionService/usermandate/deleteUserMandateByMandateId';
  static const String getUserMandatesByBankEndPoint =
      '$_transactionService/usermandate/getbankmandates';
  static const String getSipsByMandateEndPoint =
      '$_transactionService/usermandate/getmandatesip';
  static const String deleteUserMandateEndPoint =
      '$_transactionService/usermandate/initiatemandatedelete';
  static const String getAllSwitchableMandatesEndPoint =
      '$_transactionService/usermandate/getallmandates';
  static const String verifyDeleteMandateEndPoint =
      '$_transactionService/usermandate/verifymandatedelete';
  static const String authoriseMandateEndPoint =
      '$_transactionService/usermandate/authorize_mandate';

  static const String createLumpsumConsent =
      '$_transactionService/lumpsum/create_consent';
  static const String verifyLumpsumConsent =
      '$_transactionService/lumpsum/verify_consent';

  static const String createSipConsent =
      '$_transactionService/sip/create_consent';
  static const String verifySipConsent =
      '$_transactionService/sip/verify_consent';

  static const String createLumpsumPurchaseEndPoint =
      '$_transactionService/lumpsum/create_lumpsum_purchase';
  static const String initiateLumpsumPurchaseEndPoint =
      '$_transactionService/lumpsum/initiate_payment';

  static const String createSipOrderEndPoint =
      '$_transactionService/sip/add_sip_orders';

  static const String getActiveSipsEndPoint =
      '$_transactionService/sip/getActiveSip';
  static const String getInactiveSipsEndPoint =
      '$_transactionService/sip/getInActiveSip';

  static const String getUserMutualFundsEndPoint =
      '$_transactionService/holdings/get_holdings';
  static const String getMFTransactionListEndPoint =
      '$_transactionService/schemewisereturns/list_all_transactions_by_isin';
  static const String getMFInvestmentReturnsEndPoint =
      '$_transactionService/schemewisereturns/investment_returns_by_user_id';

  static const String fetchSipInstallmentsEndPoint =
      '$_transactionService/sip/fetchInstallmentsByUserIdAndSipId';
  static const String fetchStpInstallmentsEndPoint =
      '$_transactionService/stp/fetchInstallmentsByUserIdAndStpId';
  static const String fetchSwpInstallmentsEndPoint =
      '$_transactionService/swp/get_swp_installments';

  static const String stopSipEndPoint = '$_transactionService/sip/stopSip';
  static const String stopSwpEndPoint = '$_transactionService/swp/stop_swp';
  static const String stopStpEndPoint = '$_transactionService/stp/stop_stp';

  //get active plans endpoint
  static const String getSystematicPlansEndPoint =
      '$_transactionService/orders/get_sip_stp_and_swp';

  static const String getMfOrdersEndPoint =
      '$_transactionService/orders/getAllOrders';

  //switch
  static const String getSwitchFundsEndPoint =
      '/mutualfund/pulselab/switch_Altranative_funds';
  static const String getAssistedSwitchFundsEndPoint =
      '/mutualfund/pulselab/assisted_switch_Altranative_funds';
  static const String createSwitchOrderEndPoint =
      '$_transactionService/switch/create_switch_generate';
  static const String verifySwitchOTPEndPoint =
      '$_transactionService/switch/create_switch_verify';

  //redemption
  static const String createRedemptionOrderEndPoint =
      '$_transactionService/redemption/create';
  static const String verifyRedemptionOTPEndPoint =
      '$_transactionService/redemption/verify_redemption_otp';

  //stp
  static const String getStpFundsEndPoint =
      '/mutualfund/pulselab/Stp_Altranative_funds';
  static const String createStpOrderEndPoint =
      '$_transactionService/stp/create_stp_generate';
  static const String verifyStpOTPEndPoint =
      '$_transactionService/stp/create_stp_verify';

  //swp
  static const String createSwpOrderEndPoint =
      '$_transactionService/swp/create_swp_generate';
  static const String verifySwpOTPEndPoint =
      '$_transactionService/swp/create_swp_verify';

  //resend otp
  static const String resendTransactionOtpEndPoint =
      '$_transactionService/otp/otp_resend';

  static const String getFpFundDetailsEndPoint =
      '/mutualfund/fundscheme/getFundDetailsByIsin';

  //reports
  static const String generateHoldingsReportEndPoint =
      '$_transactionService/pdfholdings/mutual_fund_summary_report';

  //notifications
  static const String getNotificationsEndPoint =
      '$_notificationService/notification/get_app_notification_by_user_id';
  static const String markNotificationAsReadEndPoint =
      '$_notificationService/notification/update_isread';
  static const String markAllNotificationsAsReadEndPoint =
      '$_notificationService/notification/read_all_notification';
  static const String getUnreadNotificationCountEndPoint =
      '$_notificationService/notification/get_notification_count';

  //assisted service
  static const String getAssistedOrdersEndPoint =
      '$_transactionService/orders/getAllAssistedOrders';

  static const String verifyAssistedServicePin =
      '$_assistedServiceRazorpay/verify_assisted_services_pin';

  static const String getAssistedServiceDetailsEndPoint =
      '$_assistedService/get_assisted_service_details';
  static const String getAssistedHoldingsEndPoint =
      '$_transactionService/holdings/get_assisted_holdings';
  static const String getQuestionsEndPoint =
      '$_assistedServiceRiskProfile/map_quize_choice/get_all_quize_choices';
  static const String submitChoicesEndPoint =
      '$_assistedServiceRiskProfile/map_user_quize_choice/map_user_quize_choices';

  static const String getSuggestedFundsEndPoint =
      '$_assistedService/suggestedFunds';
  static const String investSuggestedFundsEndPoint =
      '$_assistedService/payForAssistedFunds';
  static const String initiatePaymentSuggestedFundsEndPoint =
      '$_assistedService/initiate_payment';

  static const String unlockAssistedServiceEndPoint =
      '$_assistedServiceRazorpay/create_order';
  static const String verifyAssistedServicePaymentEndPoint =
      '$_assistedServiceRazorpay/post_payment';

  //Basket Details
  static const String neoBasketBaseUrl =
      'https://mutualfunds.neosurge.money/api';
  static const String getNeoBaskets =
      '$neoBasketBaseUrl/baskets/baskets/searchbaskets';
  static const String basketDetails =
      '$neoBasketBaseUrl/baskets/baskets/getbasket';
  static const String basketLumpsumOrder =
      '$neoBasketBaseUrl/baskets/buy/lumpsum';
  static const String basketSipOrder =
      '$neoBasketBaseUrl/baskets/sip/createsip';
  static const String basketPortfolio =
      '$neoBasketBaseUrl/baskets/portfolio/getportfolio';
  static const String basketPortfolioDetail =
      '$neoBasketBaseUrl/baskets/portfolio/getbasket';

  static const String createBasketOrderConsent =
      '$_transactionService/lumpsum/create_consent';

  static const String verifyBasketLumpsumConsent =
      '$neoBasketBaseUrl/baskets/buy/verify_consent';
  static const String verifyBasketSipConsent =
      '$neoBasketBaseUrl/baskets/sip/addsip';
  static const String getBasketBuyTransactions =
      '$neoBasketBaseUrl/baskets/portfolio/getbaskettransactionsbuy';
  static const String getBasketSellTransactions =
      '$neoBasketBaseUrl/baskets/portfolio/getbaskettransactionssell';
  static const String getBasketBuyOrder =
      '$neoBasketBaseUrl/baskets/portfolio/getbasketordersbuy';
  static const String getBasketSellOrder =
      '$neoBasketBaseUrl/baskets/portfolio/getbasketorderssell';
  static const String getTransactionDetail =
      '$neoBasketBaseUrl/baskets/portfolio/gettransactiondetails';

  static const String deleteSip = '$neoBasketBaseUrl/baskets/sip/deletesi';
  static const String basketRedeemOrder =
      '$neoBasketBaseUrl/baskets/redemption/basketredemption';
  static const String basketIndividualRedeemOrder =
      '$neoBasketBaseUrl/baskets/redemption/individualredemption';
  static const String verifyBasketRedeemConsent =
      '$neoBasketBaseUrl/baskets/redemption/verifyconsent';
  static const String getBasketChartData =
      '$neoBasketBaseUrl/baskets/baskets/getbasketperformance';
  //Equity URLs
  static const String equityBaseURL = 'https://equities.neosurge.money';
  static const String equityStockDetails =
      '$equityBaseURL/complexdata/getstockscreen';
  static const String equityStockChart = '$equityBaseURL/livedata/getchartdata';
  static const String equityStocks = '$equityBaseURL/livedata/getstocks';
  static const String equityIndexPrice =
      '$equityBaseURL/livedata/getindexprice';
  static const String equityTransactionID =
      '$equityBaseURL/smallcase/v2/transaction/connect';
  static const String equityBrokers = '$equityBaseURL/livedata/getbrokers';
  static const String equitySmallCaseLogin = '$equityBaseURL/smallcase/login';
  static const String equityBuySell =
      '$equityBaseURL/smallcase/transaction/securities';
  static const String equityHoldingsToken =
      '$equityBaseURL/smallcase/transaction/holdings';
  static const String equityGlobalSearch =
      '$equityBaseURL/twelvedata/fetch/symboldata';
  static const String equityCreateWatchlist = '$equityBaseURL/watchlist/create';
  static const String equityAllWatchlist = '$equityBaseURL/watchlist/all';
  static const String equityAddStockToWatch =
      '$equityBaseURL/watchlist/addsymbol';
  static const String equityGetWatchlistToStock = '$equityBaseURL/watchlist/';
  static const String equityWatchlistDeleteSymbol = '$equityBaseURL/watchlist/';
  static const String equityFetchOrders =
      '$equityBaseURL/smallcase/fetch/orders';
  static const String equityGetHoldings = '$equityBaseURL/portfolio';
  static const String equityGetPositions = '$equityBaseURL/smallcase/positions';
  static const String equityDeleteWatchlist = '$equityBaseURL/watchlist/';
  static const String equitySmallcaseFunds =
      'https://equities.neosurge.money/smallcase/transaction/funds';

  // LAMF
  static const String equitySmartWatchlistSearch =
      'https://equities.neosurge.money/api/v1/smart-watchlist/search';
  static const String equitySmartWatchlistHoldings =
      'https://equities.neosurge.money/api/v1/smart-watchlist/listuserholdings';
  static const String equityCreateAlert =
      'https://equities.neosurge.money/api/v1/smart-watchlist/createalert';
  static const String equityUserAlert =
      'https://equities.neosurge.money/api/v1/smart-watchlist/listusersmartwatchliststocks';
  static const String equityDeleteAlert =
      'https://equities.neosurge.money/api/v1/smart-watchlist/deleteusersmartwatchliststocks';
  static const String equityAlertDetails =
      'https://equities.neosurge.money/api/v1/smart-watchlist/stockscreen';

  static const String getLoanUser =
      '$baseProdUrl/api/v1/mutualfund/loans/getloanuser';
  static const String getCreditLimit =
      '$baseProdUrl/api/v1/mutualfund/loans/getcreditlimit';
  // Equity - ETFs
  static const String etfStocks = '$equityBaseURL/livedata/getetfs';
  static const String availLoan = '/mutualfund/loans/initiateloan';
  static const String updateLoanStatus = '/mutualfund/loans/updateloanstate';
  static const String getLoanData = '/mutualfund/loans/getloandata';
  static const String getPledgedFunds = '/mutualfund/loans/pledgedfunds';
  static const String getTransactions = '/mutualfund/loans/transactions';
  static const String initiatePayments = '/mutualfund/loans/payment';
  static const String initiateWithdrawal = '/mutualfund/loans/withdrawal';
  static const String initiateLoanClosure =
      '/mutualfund/loans/initiatecloseloan';
  static const String loanClosure = '/mutualfund/loans/closeloan';
  static const String getInitiateloanimport =
      '$baseProdUrl/api/v1/mutualfund/loans/initiateloanimport';
  static const String getLoanImportDetails =
      '$baseProdUrl/api/v1/mutualfund/loans/getimportdetails';
  static const String submitImportOtp =
      '$baseProdUrl/api/v1/mutualfund/loans/submitimportotp';
  static const String getImportLoanData =
      '$baseProdUrl/api/v1/mutualfund/loans/getimportloandata';
  static const String getLAMFLandingPage =
      '$baseProdUrl/api/v1/mutualfund/loans/importlandingpage';
  static const String getCibilRefresh =
      '$baseProdUrl/api/v1/mutualfund/loans/refreshimport';

  // Market News
  static const String fetchMarketNews = '$equityBaseURL/livedata/fetch/news';

  // Smart Filter
  static const String getSectorsIndustries =
      '$equityBaseURL/api/v1/smartfilter/sectors-industries';
  static const String filterBySectorIndustries =
      '$equityBaseURL/api/v1/smartfilter/filter-sector-industry';
  static const String fetchSmartFilterIndices =
      '$equityBaseURL/livedata/indices';
  static const String fetchFilterByIndex =
      '$equityBaseURL/api/v1/smartfilter/filter-by-index';
  static const String getIndexData = '$equityBaseURL/livedata/getindexprice';
  static const String getBusinessHouses =
      '$equityBaseURL/api/v1/smartfilter/business-houses';
  static const String getSubsidiaries =
      '$equityBaseURL/api/v1/smartfilter/stocks-by-business-house';
  static const String getEtfFundHouses =
      '$equityBaseURL/api/v1/smartfilter/etf-fund-houses';

  /// Contact Us baseurl APIs :- https://equities.neosurge.money/api/
  static const String contactUsBaseUrl = "https://equities.neosurge.money/api";

  /// API endpoint :- /v1/chat-support/core/categories
  static const String chatSupportCategories =
      "$contactUsBaseUrl/v1/chat-support/core/categories";

  /// API endpoint :- /v1/chat-support/core/dislike-reasons
  static const String disLikeReasons =
      "$contactUsBaseUrl/v1/chat-support/core/dislike-reasons";

  /// API endpoint :- /v1/chat-support/faq/search
  static const String chatSupportSearch =
      "$contactUsBaseUrl/v1/chat-support/faq/search";

  /// API endpoint :- /v1/chat-support/faq/
  static const String singleFaqDetails =
      "$contactUsBaseUrl/v1/chat-support/faq";

  /// API endpoint :- messaging/dispatch-support-email
  static const String sendSupportEmail =
      "$contactUsBaseUrl/messaging/dispatch-support-email";

  /// API endpoint :- /v1/chat-support/faq/dislike
  static const String capturefaqdislike =
      "$contactUsBaseUrl/v1/chat-support/faq/dislike";

  /// API endpoint :- /v1/chat-support/faq/dislike
  static const String capturefaqlike =
      "$contactUsBaseUrl/v1/chat-support/faq/like";

  /// External Fund Import APIs
  static const externalFundBaseUrl = 'https://mfimp.neosurge.money/mfimports';

  static const String getUserAccountDetails = '$externalFundBaseUrl/getdetails';
  static const String initialiseImportTransaction =
      '$externalFundBaseUrl/transactionandotp';
  static const String validateImportTransaction =
      '$externalFundBaseUrl/validateotp';
  static const String getImportedUserHolding =
      '$externalFundBaseUrl/getimportuser';
  static const String getBrokerHoldingsFund =
      '$externalFundBaseUrl/getbrokerholdings';
  static const String getPortfolioAnalysis =
      '$externalFundBaseUrl/analyticspage';

  ///Retirement calculator
  static const String GenerateRetirementOTP =
      '$baseProdUrl/api/v1/usermgmt/retirement/generate-otp';
  static const String SubmitRetirementOTP =
      '$baseProdUrl/api/v1/usermgmt/retirement/submit-otp';
  static const String retirementCorpus =
      '$baseProdUrl/api/v1/usermgmt/retirement/retirement-corpus';
  static const String retirementInflationCalculator =
      '$baseProdUrl/api/v1/usermgmt/retirement/expense-x-years';
  static const String retirementPassbook =
      '$baseProdUrl/api/v1/usermgmt/retirement/fetch-passbook';

  //Goal Planning
  static const String goalPlanningDashboardData =
      '$baseProdUrl/api/v1/mutualfund/goalplanning/usergoals';

  static const String goalCoreData =
      '$baseProdUrl/api/v1/mutualfund/goalplanning/goalscoredata';

  static const String createGoals =
      '$baseProdUrl/api/v1/mutualfund/goalplanning/createusergoal';

  static const String getGoalsDetails =
      '$baseProdUrl/api/v1/mutualfund/goalplanning/usergoal/';

  static const String createGoalInvestment =
      '$baseProdUrl/api/v1/mutualfund/goalplanning/investmentforgoal';
}
