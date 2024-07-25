import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/params/equity/equity_smart_watchlist/fetch_indices_params.dart';
import '../../domain/entities/params/goal_planning/get_goals_details_params.dart';
import '../../domain/entities/params/mutual_funds/is_scheme_present_params.dart';
import '../cubits/equity/equity_smart_filtering/cubit/fetch_smart_indices_cubit.dart';
import '../cubits/equity/smart_filter_subsidiaries/cubit/get_business_houses_cubit.dart';
import '../cubits/goal_planning/create_goal_investements_cubit.dart';
import '../cubits/goal_planning/create_user_goals_cubit.dart';
import '../cubits/goal_planning/get_goal_details_cubit.dart';
import '../cubits/goal_planning/get_goal_planning_dashboard_data_cubit.dart';
import '../cubits/goal_planning/get_goals_core_data_cubit.dart';
import '../cubits/mutual_funds/add_to_cart/add_to_cart_cubit.dart';

import '../cubits/mutual_funds/cart_lumpsum_purchase/cart_lumpsum_purchase_cubit.dart';
import '../cubits/mutual_funds/cart_sip_purchase/cart_sip_purchase_cubit.dart';
import '../cubits/mutual_funds/clear_cart/clear_cart_cubit.dart';
import '../cubits/mutual_funds/is_scheme_present/is_scheme_present_cubit.dart';
import '../cubits/mutual_funds/lumpsum_cart/lumpsum_cart_cubit.dart';
import '../cubits/mutual_funds/sip_cart/sip_cart_cubit.dart';
import '../cubits/mutual_funds/verify_cart_purchase_otp/verify_cart_purchase_otp_cubit.dart';
import '../screens/equity/component/all_index.dart';
import '../../domain/entities/params/retirement_calculator/retirement_corpus_params.dart';
import '../../domain/entities/params/retirement_calculator/retirement_inflation_calculator_params.dart';
import '../../domain/entities/params/retirement_calculator/retirement_passbook_params.dart';
import '../cubits/lamf/lamf_loan_closure/lamf_loan_closure_cubit.dart';
import '../screens/bank_and_mandate/bank/add_bank_error_screen.dart';
import '../cubits/retirement_calculator/generate_retirement_otp_cubit.dart';
import '../cubits/retirement_calculator/retirement_corpus_cubit.dart';
import '../cubits/retirement_calculator/retirement_inflation_calculator_cubit.dart';
import '../cubits/retirement_calculator/retirement_passbook_cubit.dart';
import '../cubits/retirement_calculator/submit_retirement_otp_cubit.dart';
import '../screens/bank_and_mandate/mandate/close_all_sip_screen.dart';
import '../screens/bank_and_mandate/mandate/detailed_mandate_view_screen.dart';
import '../screens/bank_and_mandate/mandate/switch_sip_mandate_screen.dart';
import '../cubits/account/delete_mandate_cubit/delete_mandate_cubit.dart';
import '../cubits/account/get_user_switchable_mandates_cubit/get_user_switchable_mandates_cubit.dart';
import '../cubits/account/mandate_sips_cubit/mandate_sips_cubit.dart';
import '../cubits/account/verify_delete_mandate_cubit/verify_delete_mandate_cubit.dart';

import '../screens/bank_and_mandate/mandate/verify_delete_mandate_screen.dart';
import '../screens/credit/pledged_mfs_screen.dart';
import '../../domain/entities/params/lamf/get_loan_data_params.dart';
import '../cubits/lamf/get_initiate_import_loans/get_initiate_import_loans_cubit.dart';
import '../cubits/lamf/get_loan_data/get_loan_data_cubit.dart';
import '../cubits/lamf/loan_import_details/loan_import_details_cubit.dart';
import '../cubits/lamf/submit_import_otp/submit_import_otp_cubit.dart';
import '../cubits/mutual_funds/get_fund/get_fund_cubit.dart';
import '../cubits/mutual_funds/get_fund_by_subcategory/get_funds_by_subcategory_cubit.dart';
import '../cubits/mutual_funds/get_funds_by_investment_idea/get_funds_by_investment_idea_cubit.dart';
import '../cubits/mutual_funds/get_investment_idea_filters/get_investment_idea_filters_cubit.dart';
import '../cubits/util_cubits/nav_cubit.dart';
import '../screens/credit/import_loan_form.dart';
import '../screens/credit/import_loan_phone_verify_screen.dart';
import '../screens/credit/other_loan_details_screen.dart';
import '../cubits/equity/equity_smart_watchlist/smart_watchlist_holdings_cubit.dart';
import '../cubits/equity/equity_smart_watchlist/smart_watchlist_search_cubit.dart';
import '../../domain/entities/params/mutual_funds/capital_gain_report_params.dart';
import '../cubits/mutual_funds/Capital_gain_report/generate_capital_gains_file_cubit.dart';
import '../cubits/mutual_funds/Capital_gain_report/get_capital_gain_report_cubit.dart';
import '../cubits/neo_card/discovery/discovery_animation_cubit.dart';
import '../screens/contact_us/contact_us_screen.dart';
import '../../domain/entities/params/contact_us/get_category_questions_params.dart';
import '../cubits/contact_us/capture_faq_like_cubit/capture_faq_like_cubit.dart';
import '../cubits/contact_us/category_questions/category_questions_cubit.dart';
import '../cubits/contact_us/category_questions_detail/category_questions_detail_cubit.dart';
import '../cubits/contact_us/contact_us_cubit/contact_us_cubit.dart';
import '../cubits/contact_us/contact_us_form_cubit/contact_us_form_cubit.dart';
import '../cubits/contact_us/get_dislike_reasons/get_dislike_reasons_cubit.dart';
import '../screens/contact_us/category_questions_detail_screen.dart';
import '../screens/contact_us/category_questions_screen.dart';
import '../screens/contact_us/contact_us_form_screen.dart';
import '../screens/digital_gold/digital_gold_dashboard_screen.dart';
import '../screens/equity/component/equity_term_condition_screen.dart';
import '../screens/equity/component/smart_index.dart';
import '../screens/equity/component/smart_subsidiary_screen.dart';
import '../screens/equity/invest/explore/stock_details_screen.dart';
import '../../data/models/kyc/verify_pan_response_model.dart';
import '../../data/models/neobaskets/basket_redeem_order_response.dart';
import '../../domain/entities/params/neobaskets/basket_buy_order_param.dart';
import '../../domain/entities/params/neobaskets/basket_buy_transaction_params.dart';
import '../../domain/entities/params/neobaskets/basket_details_params.dart';
import '../../domain/entities/params/neobaskets/basket_portfolio_detail_params.dart';
import '../../domain/entities/params/neobaskets/basket_sell_order_param.dart';
import '../../domain/entities/params/neobaskets/basket_sell_transaction_params.dart';
import '../../domain/entities/params/neobaskets/basket_transaction_detail_params.dart';
import '../../domain/entities/params/neobaskets/get_basket_chart_params.dart';
import '../../domain/entities/params/neobaskets/neobaskets_discovery_params.dart';
import '../cubits/basket_redeem_order_verify/basket_redeem_order_verify_cubit.dart';
import '../cubits/neobaskets/basket_buy_order/basket_buy_order_cubit.dart';
import '../cubits/neobaskets/basket_buy_transactions/basket_buy_transactions_cubit.dart';
import '../cubits/neobaskets/basket_chart/basket_chart_cubit.dart';
import '../cubits/neobaskets/basket_individual_redeem_order/basket_individual_redeem_order_cubit.dart';
import '../cubits/neobaskets/basket_lumpsum_order/basket_lumpsum_order_cubit.dart';
import '../cubits/neobaskets/basket_lumpsum_order_verify/basket_lumpsum_order_verify_cubit.dart';
import '../cubits/neobaskets/basket_order_consent/basket_order_consent_cubit.dart';
import '../cubits/neobaskets/basket_order_details/basket_order_details_cubit.dart';
import '../cubits/neobaskets/basket_portfolio/basket_portfolio_cubit.dart';
import '../cubits/neobaskets/basket_portfolio_detail/basket_portfolio_detail_cubit.dart';
import '../cubits/neobaskets/basket_redeem_order/basket_redeem_order_cubit.dart';
import '../cubits/neobaskets/basket_sell_order/basket_sell_order_cubit.dart';
import '../cubits/neobaskets/basket_sell_transactions/basket_sell_transactions_cubit.dart';
import '../cubits/neobaskets/basket_sip_order/basket_sip_order_cubit.dart';
import '../cubits/neobaskets/basket_sip_order_verify/basket_sip_order_verify_cubit.dart';
import '../cubits/neobaskets/neobasket_discovery_details/basket_details_cubit.dart';
import '../cubits/neobaskets/neobaskets_discovery/neobasket_discovery_cubit.dart';
import '../cubits/onboarding/upload_proof_of_identity/upload_proof_of_identity_cubit.dart';
import '../screens/goal_planning/goal_choice/goal_choice_screen.dart';
import '../screens/goal_planning/goal_plan_dashboard_screen.dart';
import '../screens/goal_planning/goal_planning_onboard_screen.dart';
import '../screens/goal_planning/goal_planning_returning_user/goal_planning_returning_user.dart';
import '../screens/goal_planning/goal_setting_screen.dart';
import '../screens/mutual_funds/basket_details/basket_details_screen.dart';
import '../screens/mutual_funds/basket_order/basket_order_status.dart';
import '../screens/mutual_funds/basket_order/basket_order_summary_screen.dart';
import '../screens/mutual_funds/basket_order/basket_order_verify_screen.dart';
import '../screens/mutual_funds/basket_order/basket_order_screen.dart';
import '../screens/mutual_funds/cart/cart_screen.dart';
import '../screens/mutual_funds/cart/cart_transaction_payment_option_screen.dart';
import '../screens/mutual_funds/cart/cart_transaction_status_screen.dart';
import '../screens/mutual_funds/cart/cart_transaction_verify_otp_screen.dart';
import '../screens/mutual_funds/funds_list_by_category.dart';
import '../screens/mutual_funds/funds_list_by_investment_idea.dart';
import '../screens/mutual_funds/redeem_basket/redeem_basket.dart';
import '../screens/mutual_funds/redeem_basket/redeem_basket_order_summary.dart';
import '../screens/mutual_funds/redeem_basket/redeem_basket_otp_verify.dart';
import '../screens/mutual_funds/redeem_basket/redeem_basket_individual_fund.dart';
import '../screens/mutual_funds/redeem_basket/redeem_basket_individual_fund_selection.dart';
import '../screens/mutual_funds/redeem_basket/redeem_elss_basket_individual_fund_selection.dart';
import '../screens/mutual_funds/redeem_basket/redeem_not_allow.dart';
import '../screens/mutual_funds/redeem_basket/redeem_status.dart';
import '../../domain/entities/params/equity/equity_explore/stock_details_params.dart';
import '../cubits/equity/equity_explore/stock_chart_cubit.dart';
import '../cubits/equity/equity_explore/stock_details_cubit.dart';
import '../cubits/equity/login/get_all_brokers_cubit.dart';
import '../cubits/equity/login/smallcase_login_cubit.dart';
import '../cubits/equity/login/transactionid_cubit.dart';
import '../screens/equity/component/equity_notifiaction_screen.dart';
import '../screens/equity/equity_bottom_nav/equity_invest_screen.dart';
import '../screens/equity/invest/watchlist/smart_watchlist/smart_watchlist_holdings.dart';
import '../screens/equity/singin/equity_login_screen.dart';
import '../screens/equity/signup/equity_create_account_screen.dart';
import '../screens/logged_in_home/widgets/market_news/market_digest.dart';
import '../screens/logged_in_home/widgets/market_news/market_news.dart';
import '../screens/credit/credit_screen.dart';
import '../screens/mutual_funds/mf_dashboard_screen.dart';
import '../screens/my_portfolio/analysis/portfolio_analysis_screen.dart';
import '../../domain/entities/params/import_external_fund/validate_transaction_params.dart';
import '../cubits/authentication/login_with_apple/login_with_apple_cubit.dart';
import '../cubits/import_external_fund/broker_holdings_fund/broker_holdings_fund_cubit.dart';
import '../cubits/import_external_fund/import_holding_data/import_holding_data_cubit.dart';
import '../cubits/import_external_fund/portfolio_analysis/portfolio_analysis_cubit.dart';
import '../cubits/import_external_fund/transaction/transaction_cubit.dart';
import '../screens/external_mutual_funds/external_fund_fail_screen.dart';
import '../screens/external_mutual_funds/external_fund_otp_screen.dart';
import '../screens/external_mutual_funds/external_fund_account_screen.dart';
import '../screens/external_mutual_funds/external_fund_success_screen.dart';

import '../../data/models/assisted_service/unlock_assisted_service_response.dart';
import '../../di/get_it.dart';
import '../../domain/entities/enums.dart';
import '../../domain/entities/params/digital_gold/checkout_delivery_order_params.dart';
import '../../domain/entities/params/mutual_funds/get_systematic_plans_params.dart';
import '../../logger.dart';
import '../cubits/account/add_delivery_address_cubit/add_delivery_address_cubit.dart';
import '../cubits/account/add_user_bank_cubit/add_user_bank_cubit.dart';
import '../cubits/account/create_mandate_cubit/create_mandate_cubit.dart';
import '../cubits/account/delivery_address_cubit/delivery_address_cubit.dart';
import '../cubits/account/get_kyc_last_route_cubit/get_kyc_last_route_cubit.dart';
import '../cubits/account/get_primary_bank_cubit/get_primary_bank_cubit.dart';
import '../cubits/account/update_bank_ifsc_cubit/update_bank_ifsc_cubit.dart';
import '../cubits/account/update_primary_bank_cubit/update_primary_bank_cubit.dart';
import '../cubits/account/user_bank_details_cubit/user_bank_details_cubit.dart';
import '../cubits/account/user_mandate_cubit/user_mandate_cubit.dart';
import '../cubits/assisted_service/assisted_orders/assisted_orders_cubit.dart';
import '../cubits/assisted_service/assited_holdings_cubit/assisted_holdings_cubit.dart';
import '../cubits/assisted_service/get_assisted_service_details_cubit/get_assisted_service_details_cubit.dart';
import '../cubits/assisted_service/get_suggested_funds_cubit/get_suggested_funds_cubit.dart';
import '../cubits/assisted_service/initiate_suggested_funds_payment_cubit/initiate_suggested_funds_payment_cubit.dart';
import '../cubits/assisted_service/invest_suggested_funds_cubit/invest_suggested_funds_cubit.dart';
import '../cubits/assisted_service/questions_cubit/questions_cubit.dart';
import '../cubits/assisted_service/submit_choices_cubit/submit_choices_cubit.dart';
import '../cubits/assisted_service/unlock_assisted_service_cubit/unlock_assisted_service_cubit.dart';
import '../cubits/assisted_service/verify_assisted_service_pin/verify_assisted_service_pin_cubit.dart';
import '../cubits/authentication/auth/auth_cubit.dart';
import '../cubits/authentication/login_with_google/login_with_google_cubit.dart';
import '../cubits/authentication/social_login/social_login_cubit.dart';
import '../cubits/digital_gold/checkout_delivery_order_cubit/checkout_delivery_order_cubit.dart';
import '../cubits/digital_gold/create_delivery_order_cubit/create_delivery_order_cubit.dart';
import '../cubits/digital_gold/dg_delivery_transactions_cubit/dg_delivery_transaction_cubit.dart';
import '../cubits/digital_gold/dg_transactions_cubit/dg_transaction_cubit.dart';
import '../cubits/import_external_fund/account_details/account_details_cubit.dart';
import '../cubits/mpin/forgot_mpin/forgot_mpin_cubit.dart';
import '../cubits/mpin/mpin_login/mpin_login_cubit.dart';
import '../cubits/mpin/set_mpin/set_mpin_cubit.dart';
import '../cubits/mutual_funds/cancel_systematic_plan/cancel_systematic_plan_cubit.dart';
import '../cubits/mutual_funds/create_consent/create_consent_cubit.dart';
import '../cubits/mutual_funds/fp_fund_details/fp_fund_details_cubit.dart';
import '../cubits/mutual_funds/fund_details/fund_details_cubit.dart';
import '../cubits/mutual_funds/lumpsum_purchase/create_lumpsum_purchase_cubit.dart';
import '../cubits/mutual_funds/lumpsum_purchase/initiate_lumpsum_purchase_cubit.dart';
import '../cubits/mutual_funds/mandate_token_cubit/authorise_mandate_cubit.dart';
import '../cubits/mutual_funds/mf_chart/mf_chart_cubit.dart';
import '../cubits/mutual_funds/mf_orders/mf_orders_cubit.dart';
import '../cubits/mutual_funds/mf_orders_filter_sort/mf_orders_filter_sort_cubit.dart';
import '../cubits/mutual_funds/mf_transactions/mf_transactions_cubit.dart';
import '../cubits/mutual_funds/mf_user_holdings/mf_user_holdings_cubit.dart';
import '../cubits/mutual_funds/redeem/create_redeem_order/create_redeem_order_cubit.dart';
import '../cubits/mutual_funds/sip_order/sip_order_cubit.dart';
import '../cubits/mutual_funds/stp/create_stp_order/create_stp_order_cubit.dart';
import '../cubits/mutual_funds/stp/stp_funds_list/stp_funds_list_cubit.dart';
import '../cubits/mutual_funds/switch/create_switch_order/create_switch_order_cubit.dart';
import '../cubits/mutual_funds/switch/switch_funds_list_cubit.dart';
import '../cubits/mutual_funds/swp/create_swp_order/create_swp_order_cubit.dart';
import '../cubits/mutual_funds/systematic_plan_installments/systematic_plan_installments_cubit.dart';
import '../cubits/mutual_funds/systematic_plans/systematic_plans_cubit.dart';
import '../cubits/mutual_funds/verify_consent/verify_consent_cubit.dart';
import '../cubits/mutual_funds/verify_transaction_otp/verify_transaction_otp_cubit.dart';
import '../cubits/notifications/notification_action_cubit/notification_action_cubit.dart';
import '../cubits/notifications/notification_count_cubit/notification_count_cubit.dart';
import '../cubits/notifications/user_notification_cubit.dart';
import '../cubits/onboarding/get_bank_by_ifsc/get_bank_by_ifsc_cubit.dart';
import '../cubits/onboarding/onboarding_page_cubit.dart';
import '../cubits/onboarding/upload_nominee_details/upload_nominee_details_cubit.dart';
import '../cubits/onboarding/verify_pan/verify_pan_cubit.dart';
import '../cubits/util_cubits/post_payment_cubit/post_payment_cubit.dart';
import '../screens/auth_screen.dart';
import '../screens/bank_and_mandate/bank/add_profile_bank_details_screen.dart';
import '../screens/bank_and_mandate/bank/bank_details_screen.dart';
import '../screens/bank_and_mandate/bank/detailed_bank_view_screen.dart';
import '../screens/bank_and_mandate/bank/edit_bank_ifsc_screen.dart';
import '../screens/bank_and_mandate/mandate/authorise_mandate_webview.dart';
import '../screens/bank_and_mandate/mandate/auto_mandate_status_screen.dart';
import '../screens/bank_and_mandate/mandate/create_auto_mandate_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/digital_gold/delivery/delivery_detailed_view_screen.dart';
import '../screens/digital_gold/delivery/delivery_payment_screen.dart';
import '../screens/digital_gold/delivery/delivery_screen.dart';
import '../screens/digital_gold/delivery/select_delivery_screen.dart';
import '../screens/digital_gold/delivery_checkout_screen.dart';
import '../screens/digital_gold/digital_gold_investment_details_screen.dart';
import '../screens/digital_gold/digital_gold_order_status_screen.dart';
import '../screens/digital_gold/digital_gold_payment_screen.dart';
import '../screens/digital_gold/digital_gold_sips_screen.dart';
import '../screens/digital_gold/digital_gold_transaction_status_screen.dart';
import '../screens/digital_gold/digtal_gold_transactions.dart';
import '../screens/my_portfolio/basket/basket_transactions_screen.dart';
import '../screens/my_portfolio/capital_gain_report/capital_gain_details.dart';
import '../screens/my_portfolio/capital_gain_report/finacial_year_report_screen.dart';
import '../screens/my_portfolio/my_portfolio_basket_details.dart';
import '../screens/my_portfolio/widgets/importing_mutual_fund_screen.dart';
import '../screens/kyc/kyc_routing_screen.dart';
import '../screens/kyc/kyc_verified_flow_screen.dart';
import '../screens/kyc/non_kyc_flow_screen.dart';
import '../screens/logout_screen.dart';
import '../screens/mpin/forgot_mpin_otp_screen.dart';
import '../screens/mpin/mpin_fp_login_screen.dart';
import '../screens/mpin/reset_mpin_screen.dart';
import '../screens/mutual_funds/all_holdings_screen.dart';
import '../screens/mutual_funds/assisted_service/analyse_assisted_service_screen.dart';
import '../screens/mutual_funds/assisted_service/assisted_order_summary_screen.dart';
import '../screens/mutual_funds/assisted_service/assisted_service_payment_webview.dart';
import '../screens/mutual_funds/assisted_service/assisted_service_pin_screen.dart';
import '../screens/mutual_funds/assisted_service/assisted_service_quiz_screen.dart';
import '../screens/mutual_funds/assisted_service/fund_suggestion_screen.dart';
import '../screens/mutual_funds/assisted_service/start_assisted_service_screen.dart';
import '../screens/mutual_funds/assisted_service/unlock_assisted_service_info_screen.dart';
import '../screens/mutual_funds/fund_details/fund_details_screen.dart';
import '../screens/mutual_funds/lumpsum/invest_lumpsum_screen.dart';
import '../screens/mutual_funds/lumpsum/lumpsum_order_summary_screen.dart';
import '../screens/mutual_funds/mf_transaction_status_screen.dart';
import '../screens/mutual_funds/payment/payment_webview.dart';
import '../screens/mutual_funds/redemption_verify_otp_screen.dart';
import '../screens/mutual_funds/sip/cancel_sip_success_screen.dart';
import '../screens/mutual_funds/sip/invest_sip_screen.dart';
import '../screens/mutual_funds/sip/sip_detail_screen.dart';
import '../screens/mutual_funds/sip/sip_order_summary_screen.dart';
import '../screens/mutual_funds/stp/stp_detail_screen.dart';
import '../screens/mutual_funds/stp/stp_fund_list_screen.dart';
import '../screens/mutual_funds/stp/stp_fund_screen.dart';
import '../screens/mutual_funds/stp/stp_verify_otp_screen.dart';
import '../screens/mutual_funds/switch/switch_fund_list_screen.dart';
import '../screens/mutual_funds/switch/switch_fund_screen.dart';
import '../screens/mutual_funds/switch/switch_verify_otp_screen.dart';
import '../screens/mutual_funds/swp/swp_detail_screen.dart';
import '../screens/mutual_funds/swp/swp_fund_screen.dart';
import '../screens/mutual_funds/swp/swp_verify_otp_screen.dart';
import '../screens/mutual_funds/systematic_plans/my_systematic_plans_screen.dart';
import '../screens/my_portfolio/broker_holdings_fund_screen.dart';
import '../screens/my_portfolio/fund_transaction_screen.dart';
import '../screens/my_portfolio/order_status/mf_order_status_screen.dart';
import '../screens/my_portfolio/redeem_screen.dart';
import '../screens/neo_card/discovery/neo_card_discovery.dart';
import '../screens/notifications/notifications_screen.dart';
import '../screens/onboarding/digital_signature/digital_signature_capture_screen.dart';
import '../screens/onboarding/home_screen.dart';
import '../screens/onboarding/kyc_verification/confirm_poa_screen.dart';
import '../screens/onboarding/kyc_verification/esign_submit_webview_screen.dart';
import '../screens/onboarding/kyc_verification/confirm_pan_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/onboarding/setup_auto_mandate_screen.dart';
import '../screens/onboarding/sign_up_screen.dart';
import '../screens/onboarding/upload_nominee_screen.dart';
import '../screens/profile/about/about_us_screen.dart';
import '../screens/profile/about/about_webview.dart';
import '../screens/profile/account_details_screen.dart';
import '../screens/profile/delivery_address/add_address_screen.dart';
import '../screens/profile/delivery_address/delivery_address_screen.dart';
import '../screens/profile/nominee/view_edit_nominee_screen.dart';
import '../screens/profile/orders/gold_silver_orders/gold_orders_screen.dart';
import '../screens/profile/orders/mutual_funds_order/mf_orders_screen.dart';
import '../screens/profile/orders/neoBasketOrders/neo_basket_order_screen.dart';
import '../screens/profile/orders/neoBasketOrders/transaction_details_page.dart';
import '../screens/profile/orders/orders_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/reports/reports_screen.dart';
import '../screens/profile/security_screen.dart';
import '../screens/retirement_calculator/epf_details_screen.dart';
import '../screens/retirement_calculator/epf_transaction_details_screen.dart';
import '../screens/retirement_calculator/financial_details_screen.dart';
import '../screens/retirement_calculator/plan_your_future_screen.dart';
import '../screens/retirement_calculator/retirment_age_screen.dart';
import '../screens/retirement_calculator/tell_us_screen.dart';
import '../screens/retirement_calculator/widget/retirement_otp_screen.dart';
import 'route_arguments.dart';
import 'routes.dart';

const String _h = 'route_generator';

@lazySingleton
class RouteGenerator {
  VerifyPanCubit? _verifyPanCubit;

  DeliveryAddressCubit? _deliveryAddressCubit;

  //Cubits handling mfHoldingsCubit and pendingMfOrdersCubit
  MfUserHoldingsCubit? _mfUserHoldingsCubit;
  MfOrdersCubit? _mfPendingOrdersCubit;

  //Cubits handling assistedHoldingsCubit and pendingAssistedOrdersCubit
  AssistedHoldingsCubit? _assistedHoldingsCubit;
  AssistedOrdersCubit? _assistedPendingOrdersCubit;

  //Cubits handling digital gold transactions
  DgTransactionCubit? _dgTransactionCubit;
  DgDeliveryTransactionCubit? _dgDeliveryTransactionCubit;

  //Cubits handling active and inactive systematic plans
  SystematicPlansCubit? _activeSystematicPlansCubit;
  SystematicPlansCubit? _inactiveSystematicPlansCubit;

  //Cubit handling user bank details and mandate
  UserBankDetailsCubit? _userBankDetailsCubit;
  UserMandateCubit? _userMandateCubit;

  //Notification Count Cubit
  NotificationCountCubit? _notificationCountCubit;

  Route<dynamic> generateRoute(RouteSettings settings) {
    logDebugFine(_h, 'Route: ${settings.name}');

    if (kReleaseMode) {
      final Amplitude analytics = Amplitude.getInstance();

      analytics.logEvent('Route: /${settings.name}');
    }

    // return MaterialPageRoute(
    //   builder: (context) => const SetupAutoMandateScreen(),
    // );

    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(
          builder: (_) => AuthScreen(
            delay: settings.arguments as int?,
          ),
        );

      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.signUp:
        var args = settings.arguments;

        return MaterialPageRoute(
          builder: (_) => SignUpScreen(
            signUpArgs: args as SignUpArgs?,
          ),
        );
      case Routes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<LoginWithGoogleCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<LoginWithAppleCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<SocialLoginCubit>(),
              ),
            ],
            child: const HomeScreen(),
          ),
        );
      case Routes.logout:
        return PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const LogoutScreen();
          },
          transitionDuration: const Duration(milliseconds: 0),
          reverseTransitionDuration: const Duration(milliseconds: 0),
        );
      case Routes.forgotMPinOtp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgotMPinCubit>()..generateOtp(),
            child: const ForgotMPinOtpScreen(),
          ),
        );
      case Routes.newOrderScreen:
        return MaterialPageRoute(
          builder: (_) => const OrderScreen(),
        );
      case Routes.forgotMPinSetMPin:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SetMPinCubit>(),
            child: const ResetMPinScreen(),
          ),
        );

      case Routes.eSignSubmitWebView:
        final args = settings.arguments as ESignSubmitWebViewArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ESignSubmitWebViewScreen(url: args.url),
        );

      // case Routes.createMPin:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<SetMPinCubit>(),
      //       child: const CreateMPinScreen(),
      //     ),
      //   );
      case Routes.mPinFpLogin:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<MPinLoginCubit>(),
            child: const MPinFpLoginScreen(),
          ),
        );

      /// Onboarding Routes
      // case Routes.loginWithEmail:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<LoginWithEmailCubit>(),
      //       child: const LoginWithEmailScreen(),
      //     ),
      //   );
      // case Routes.enterMobile:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<MobileOtpCubit>(),
      //       child: const EnterMobileScreen(),
      //     ),
      //   );
      // case Routes.verifyMobile:
      //   final MobileNumberArgs args = settings.arguments as MobileNumberArgs;
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<VerifyMobileOtpCubit>(),
      //       child: VerifyMobileScreen(mobileNumber: args.mobileNumber),
      //     ),
      //   );
      // case Routes.verifyEmail:
      //   final VerifyEmailParams args = settings.arguments as VerifyEmailParams;
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<VerifyEmailOtpCubit>(),
      //       child: VerifyEmailScreen(verifyEmailParams: args),
      //     ),
      //   );
      // case Routes.verifyPan:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider(
      //           create: (context) => _verifyPanCubit = getIt<VerifyPanCubit>(),
      //         ),
      //         BlocProvider(
      //           create: (_) => getIt<OcrReadCubit>(),
      //         ),
      //       ],
      //       child: const VerifyPanScreen(),
      //     ),
      //   );
      case Routes.kycVerifiedFlowScreen:
        final kycData = (settings.arguments as KycFlowArgs);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<OnboardingPageCubit>()
                  ..setPage(
                    kycData.kycData.stepCount,
                    maxCompletedStep: kycData.kycData.maxStepCount,
                    isKycCompliant: kycData.kycData.kycCompliant,
                    lastRoute: kycData.kycData.lastRoute!,
                  ),
              ),
              BlocProvider(
                create: (context) =>
                    _verifyPanCubit ??= getIt<VerifyPanCubit>(),
              ),
            ],
            child: KycVerifiedFlowScreen(
              fullName: kycData.fullName,
              panNumber: kycData.panNumber,
            ),
          ),
        );
      case Routes.kycRoutingScreen:
        var args = settings.arguments as VerifyPanResponseModel;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<GetKycLastRouteCubit>()..getLastRoute(),
            child: KycRoutingScreen(
              verifyPanResponseModel: args,
            ),
          ),
        );
      case Routes.nonKycFlowScreen:
        final kycData = (settings.arguments as KycFlowArgs);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<OnboardingPageCubit>()
                  ..setPage(
                    kycData.kycData.stepCount,
                    maxCompletedStep: kycData.kycData.maxStepCount,
                    isKycCompliant: kycData.kycData.kycCompliant,
                    lastRoute: kycData.kycData.lastRoute!,
                  ),
              ),
              BlocProvider(
                create: (context) =>
                    _verifyPanCubit ??= getIt<VerifyPanCubit>(),
              ),
            ],
            child: NonKycFlowScreen(
              fullName: kycData.fullName,
              panNumber: kycData.panNumber,
              kycData: kycData.kycData,
            ),
          ),
        );
      case Routes.comfirmPanUpload:
        String imagePath = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<UploadProofOfIdentityCubit>(),
              ),
              BlocProvider.value(
                value: getIt<OnboardingPageCubit>(),
              ),
            ],
            child: ComfirmPanScreen(
              imagePath: imagePath,
            ),
          ),
        );
      case Routes.comfirmPOAUpload:
        ConfirmPoaUploadArgs confirmPoaArgs =
            settings.arguments as ConfirmPoaUploadArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ComfirmPOAScreen(
            imagePath: confirmPoaArgs.imagePath,
            documentType: confirmPoaArgs.documentType,
          ),
        );
      case Routes.addNomineeDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => getIt<UploadNomineeDetailsCubit>(),
            child: const UploadNomineeScreen(),
          ),
        );
      case Routes.digitalSignatureCapture:
        final dSArgs = settings.arguments as DigitalSignatureArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DigitalSignatureCaptureScreen(
              signatureController: dSArgs.signatureController),
        );

      // case Routes.kycCreateAccountScreen:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       final user = context.read<AuthCubit>().state.user!;
      //       return BlocProvider(
      //         create: (_) => getIt<KycCreateAccountCubit>()
      //           ..createInvestorAccountFunc(
      //             userId: user.id,
      //             retakeKyc: user.retakeKyc,
      //           ),
      //         child: const KycCreateScreen(),
      //       );
      //     },
      //   );

      ///Assisted Service
      case Routes.startAssistedService:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const StartAssistedServiceScreen(),
        );

      case Routes.assistedServiceOtp:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<VerifyAssistedServicePinCubit>(),
              ),
            ],
            child: const AssistedServicePinScreen(),
          ),
        );

      case Routes.assistedServiceQuiz:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<QuestionsCubit>()..getQuestions(),
              ),
              BlocProvider(
                create: (context) => getIt<SubmitChoicesCubit>(),
              ),
            ],
            child: const AssistedServiceQuizScreen(),
          ),
        );
      case Routes.analyseAssistedService:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AnalyseAssistedServiceScreen(),
        );
      case Routes.fundSuggestion:
        final args = settings.arguments as FundSuggestionArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<GetSuggestedFundsCubit>()
                    ..getSuggestedFunds(
                        userId: context.read<AuthCubit>().state.user!.id,
                        amount: args.amount,
                        tenure: args.tenure),
                ),
                BlocProvider(
                  create: (context) => getIt<InvestSuggestedFundsCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<CreateConsentCubit>(),
                ),
              ],
              child: FundSuggestionScreen(
                  amount: args.amount, tenure: args.tenure),
            );
          },
        );
      case Routes.unlockAssistedServiceInfo:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<UnlockAssistedServiceCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<GetAssistedServiceDetailsCubit>()
                  ..getAssistedServiceDetails(),
              ),
            ],
            child: const UnlockAssistedServiceInfoScreen(),
          ),
        );
      case Routes.assistedServicePaymentWebView:
        final args = settings.arguments as UnlockAssistedServiceResponse;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) => getIt<PostPaymentCubit>(),
                  child: AssistedServicePaymentWebView(response: args),
                ));
      case Routes.assistedOrderSummary:
        final args = settings.arguments as AssistedServiceOrderSummaryArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => getIt<InitiateSuggestedFundsPaymentCubit>(),
            child: AssistedOrderSummaryScreen(
              result: args.fundsResponse,
              totalAmount: args.amount,
            ),
          ),
        );

      ///  Bank and Mandate Routes

      case Routes.bankDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => _userBankDetailsCubit =
                    getIt<UserBankDetailsCubit>()..fetchBanks(),
              ),
              BlocProvider(
                create: (_) => getIt<UpdatePrimaryBankCubit>(),
              ),
            ],
            child: const BankDetailsScreen(),
          ),
        );

      case Routes.addBankErrorScreen:
        final args = settings.arguments as AddBankErrorScreenArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AddBankErrorScreen(
            errorType: args.errorType,
            msg: args.msg,
          ),
        );

      case Routes.addProfileBankDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<AddUserBankCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<GetBankByIfscCubit>(),
              ),
              BlocProvider<UserBankDetailsCubit>.value(
                value: _userBankDetailsCubit!,
              )
            ],
            child: const AddProfileBankDetailsScreen(),
          ),
        );

      case Routes.editBankIfsc:
        final args = settings.arguments as DetailedBankViewArgs;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<GetBankByIfscCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<UpdateBankIfscCubit>(),
              ),
              BlocProvider<UserBankDetailsCubit>.value(
                  value: _userBankDetailsCubit!),
            ],
            child: EditBankIfscScreen(bank: args.bank, index: args.index),
          ),
        );

      case Routes.detailedBankView:
        final args = settings.arguments as DetailedBankViewArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              args.isFromCreateMandatePopup
                  ? BlocProvider(
                      create: (context) =>
                          _userBankDetailsCubit = getIt<UserBankDetailsCubit>()
                            ..storeSingleBank(args.bank),
                    )
                  : BlocProvider.value(
                      value: _userBankDetailsCubit!,
                    ),
              BlocProvider(
                lazy: false,
                create: (_) {
                  _userMandateCubit = getIt<UserMandateCubit>();
                  if (args.bank.mandateId != null) {
                    _userMandateCubit!.fetchUserMandates(
                      bankId: args.bank.fpBankId!,
                    );
                  }
                  return _userMandateCubit!;
                },
              ),
            ],
            child: DetailedBankViewScreen(
              index: args.index,
            ),
          ),
        );

      case Routes.mandateDetails:
        final DetailedMandateArgs args =
            settings.arguments as DetailedMandateArgs;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<MandateSipsCubit>()
                    ..getSipsByMandate(
                      mandateId: args.userBankMandateModel.mandateId,
                    ),
                ),
                BlocProvider(
                  create: (context) => getIt<DeleteMandateCubit>(),
                ),
              ],
              child: DetailedMandateViewScreen(
                mandate: args.userBankMandateModel,
              ),
            );
          },
        );
      case Routes.closeAllSipScreen:
        final MandateCloseAllScreenArgs args =
            settings.arguments as MandateCloseAllScreenArgs;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<DeleteMandateCubit>(),
              ),
            ],
            child: CloseAllSipScreen(
              sips: args.sips,
              mandate: args.mandate,
            ),
          ),
        );
      case Routes.sipLinkedScreen:
        final MandateSwitchScreenArgs args =
            settings.arguments as MandateSwitchScreenArgs;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<DeleteMandateCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<GetUserSwitchableMandatesCubit>()
                  ..getUserSwitchableMandates(),
              ),
            ],
            child: SwitchSipMandateScreen(
              sips: args.sips,
              mandate: args.mandate,
            ),
          ),
        );

      case Routes.verifyDeleteMandateScreen:
        final args = settings.arguments as VerifyDeleteMandateScreenArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => getIt<VerifyDeleteMandateCubit>(),
            child: VerifyDeleteMandateScreen(
              deleteMandateRefId: args.deleteMandateRefId,
            ),
          ),
        );
      case Routes.setupAutoMandate:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SetupAutoMandateScreen(),
        );
      case Routes.createAutoMandate:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<UserBankDetailsCubit>.value(
                value: _userBankDetailsCubit!,
              ),
              BlocProvider(
                create: (_) => getIt<CreateMandateCubit>(),
              ),
              BlocProvider.value(value: _userMandateCubit!),
            ],
            child: const CreateAutoMandateScreen(),
          ),
        );
      case Routes.authoriseMandateWebView:
        final args = settings.arguments as AuthoriseMandateArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => getIt<AuthoriseMandateCubit>()
                    ..refreshMandate(mandateId: args.mandate.mandateId)),
              BlocProvider.value(value: _userMandateCubit!),
            ],
            child:
                AuthoriseMandateWebView(mandate: args.mandate, bank: args.bank),
          ),
        );
      case Routes.autoMandateStatus:
        final args = settings.arguments as AutoMandateStatusArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AutoMandateStatusScreen(
              bank: args.bank,
              isCreate: args.isCreate,
              mandate: args.mandate,
              isFailed: args.isFailed),
        );
      case Routes.dashboard:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              // Portfolio Cubit
              BlocProvider(
                create: (context) =>
                    _assistedHoldingsCubit = getIt<AssistedHoldingsCubit>()
                      ..getAssistedHoldings(
                          userId: context.read<AuthCubit>().state.user!.id),
              ),
              BlocProvider(
                create: (context) =>
                    _assistedPendingOrdersCubit = getIt<AssistedOrdersCubit>()
                      ..fetchPendingOrders(
                          userId: context.read<AuthCubit>().state.user!.id),
              ),
              BlocProvider(
                create: (context) =>
                    _mfUserHoldingsCubit = getIt<MfUserHoldingsCubit>()
                      ..getUserHoldings(
                          userId: context.read<AuthCubit>().state.user!.id),
              ),
              BlocProvider(
                create: (context) {
                  _mfPendingOrdersCubit = getIt<MfOrdersCubit>();
                  return _mfPendingOrdersCubit!
                    ..fetchPendingOrders(
                      userId: context.read<AuthCubit>().state.user!.id,
                    );
                },
              ),

              BlocProvider(
                create: (context) => getIt<ImportHoldingDataCubit>()
                  ..getImportedHoldingData(
                    userId: context.read<AuthCubit>().state.user!.id,
                  ),
              ),

              // Digital Gold Cubit
              BlocProvider(
                create: (context) =>
                    _dgTransactionCubit = getIt<DgTransactionCubit>(),
              ),
              BlocProvider(
                create: (context) => _dgDeliveryTransactionCubit =
                    getIt<DgDeliveryTransactionCubit>(),
              ),

              // Import External Fund Cubits
              BlocProvider(
                create: (context) =>
                    _notificationCountCubit = getIt<NotificationCountCubit>()
                      ..getUnreadNotificationCount(),
              ),
              BlocProvider(
                create: (context) => getIt<AccountDetailsCubit>()
                  ..getAccountDetails(
                    userId: context.read<AuthCubit>().state.user!.id,
                  ),
              ),
              BlocProvider(
                create: (context) => getIt<TransactionCubit>(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<BasketPortfolioCubit>()..getBasketPortfolio(),
              ),
            ],
            child: const DashboardScreen(),
          ),
        );
      case Routes.basketDetailsScreen:
        BasketDetailsParams args = settings.arguments as BasketDetailsParams;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<BasketDetailsCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<BasketChartCubit>(),
              ),
            ],
            child: BasketDetailScreen(
              basketId: args.basketId,
            ),
          ),
        );
      case Routes.basketTrasactionScreen:
        BasketTransactionArgs args =
            settings.arguments as BasketTransactionArgs;

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<BasketBuyTransactionsCubit>()
                  ..getBasketBuyTransactions(
                    BasketBuyTransactionParams(
                      basketId: args.basketId,
                      sortBy: 'DATE',
                    ),
                  ),
              ),
              BlocProvider(
                create: (_) => getIt<BasketSellTransactionsCubit>()
                  ..getBasketSellTransactions(
                    BasketSellTransactionParams(
                      basketId: args.basketId,
                      sortBy: 'DATE',
                    ),
                  ),
              ),
            ],
            child: BasketTransactionsScreen(
              basketId: args.basketId,
            ),
          ),
        );

      case Routes.buyBasketScreen:
        BasketOrderArgs args = settings.arguments as BasketOrderArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BasketOrderScreen(
            basketDetailsModel: args.basketDetails,
          ),
        );
      case Routes.buyBasketOrderSummaryScreen:
        BasketOrderSummaryArgs args =
            settings.arguments as BasketOrderSummaryArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<BasketLumpsumOrderCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<BasketSipOrderCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<BasketOrderConsentCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<GetPrimaryBankCubit>(),
              ),
            ],
            child: BasketOrderSummaryScreen(
              basketDetails: args.basketDetails,
              investmentAmount: args.investmentAmount,
              investmentType: args.basketInvestmentType,
              investmentDate: args.investmentDate,
              installments: args.installments,
            ),
          ),
        );
      case Routes.buyBasketOtpScreen:
        BasketOtpArgs args = settings.arguments as BasketOtpArgs;

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<BasketLumpsumOrderVerifyCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<BasketSipOrderVerifyCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<BasketOrderConsentCubit>(),
              ),
            ],
            child: BasketVerifyScreenScreen(
              basketInvestmentType: args.basketInvestmentType,
              orderRef: args.orderRef,
              consentId: args.consentId,
            ),
          ),
        );
      case Routes.buyBasketStatus:
        BasketTransactionStatus basketTransactionStatus =
            settings.arguments as BasketTransactionStatus;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BasketOrderStatusScreen(
            basketTransactionStatus: basketTransactionStatus,
          ),
        );

      case Routes.basketPortfolioDetail:
        final args = settings.arguments as BasketPortfolioDetailArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<BasketPortfolioDetailCubit>()
                  ..getBasketPortfolioDetail(
                    BasketPortfolioDetailParams(
                      basketId: args.portfolioBasket.basketId ?? '',
                    ),
                  ),
              ),
            ],
            child: MyPortfolioBasketDetailsPage(
              basket: args.portfolioBasket,
            ),
          ),
        );
      case Routes.redeemBasket:
        final args = settings.arguments as RedeemFundSelectionArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<BasketRedeemOrderCubit>(),
              ),
            ],
            child: RedeemBasket(
              basketPortfolioDetailResponse: args.basketPortfolioDetailResponse,
              basket: args.basket,
            ),
          ),
        );
      case Routes.redeemBasketNotAllow:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const BasketRedeemNotAllow(),
        );
      case Routes.redeemElssIndividualFundSelection:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RedeemElssBasketIndividualFundSelection(),
        );
      case Routes.redeemIndividualFundSelection:
        final args = settings.arguments as RedeemFundSelectionArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RedeemBasketIndividualFundSelection(
            basketPortfolioDetailResponse: args.basketPortfolioDetailResponse,
            basket: args.basket,
          ),
        );
      case Routes.redeemIndividualFund:
        RedeemIndividualFundArgs args =
            settings.arguments as RedeemIndividualFundArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<BasketIndividualRedeemOrderCubit>(),
              ),
            ],
            child: RedeemBasketIndividualFund(
              basket: args.basket,
              basketPortfolioDetailResponse: args.basketPortfolioDetailResponse,
              selectedFundIndex: args.index,
            ),
          ),
        );
      case Routes.redeemOrderSummary:
        final basketRedeemOrderResponse =
            settings.arguments as BasketRedeemOrderResponse;

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<BasketOrderConsentCubit>(),
              ),
            ],
            child: RedeemBasketOrderSummary(
              basketRedeemOrderResponse: basketRedeemOrderResponse,
            ),
          ),
        );
      case Routes.redeemBasketOtpVerify:
        final args = settings.arguments as RedeemBasketOtpVerifyArgs;

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<BasketRedeemOrderVerifyCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<BasketOrderConsentCubit>(),
              ),
            ],
            child: RedeemBasketOtpScreen(
              consentId: args.consentId,
              redeemptionRef: args.orderRef,
            ),
          ),
        );
      case Routes.redeemBasketStatusScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RedeemBasketStatusScreen(),
        );
      case Routes.mutualFunds:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<ImportHoldingDataCubit>()
                  ..getImportedHoldingData(
                    userId: context.read<AuthCubit>().state.user!.id,
                  ),
              ),
              BlocProvider(
                create: (context) => getIt<NeoBasketDiscoveryCubit>()
                  ..getNeoBasketDiscoveryBaskets(
                    NeobasketDiscoveryParams(
                      searchTerm: '',
                      sortBy: 'CAGR',
                    ),
                  ),
              ),
            ],
            child: const MFDashboardScreen(),
          ),
        );
      case Routes.mutualFundsCart:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<LumpsumCartCubit>()..getCartLumpsumFunds(),
              ),
              BlocProvider(
                create: (context) => getIt<SipCartCubit>()..getCartSipFunds(),
              ),
              BlocProvider(
                create: (context) => getIt<ClearCartCubit>(),
              ),
            ],
            child: const CartScreen(),
          ),
        );

      case Routes.selectCartPaymentOption:
        final args = settings.arguments as SelectCartPaymentOptionArgs;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<GetPrimaryBankCubit>()..getPrimaryBank(),
              ),
              BlocProvider(
                create: (context) => getIt<UserMandateCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<CartLumpsumPurchaseCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<CartSipPurchaseCubit>(),
              ),
            ],
            child: CartTransactionPaymentOptionScreen(
              transactionType: args.transactionType,
              cartValue: args.cartValue,
            ),
          ),
        );

      case Routes.verifyCartTrasaction:
        final args = settings.arguments as VerifyCartPurchaseArgs;

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CartLumpsumPurchaseCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<VerifyCartPurchaseOtpCubit>(),
              ),
            ],
            child: CartTransactionVerifyOtpScreen(
              orderRef: args.orderRef,
            ),
          ),
        );
      case Routes.statusCartTrasaction:
        final args = settings.arguments as MfTransactionStatus;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CartTransactionStatusScreen(
            mfTransactionStatus: args,
          ),
        );
      case Routes.fundsListBySubcategory:
        FundsListBySubCategoryArgs subCategoryArgs =
            settings.arguments as FundsListBySubCategoryArgs;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<GetFundBySubcategoryCubit>()
                    ..getFundsBySubcategory(
                      subCategory: subCategoryArgs.subCategory,
                      category: subCategoryArgs.category,
                    ),
                ),
              ],
              child: FundsListByCategory(
                category: subCategoryArgs.category,
                subCategory: subCategoryArgs.subCategory,
              ),
            );
          },
        );

      case Routes.fundsListByInvestmentIdea:
        String investmentIdea = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<GetInvestmentIdeaFiltersCubit>()
                    ..getInvestmentIdeaFilters(
                      viewKey: investmentIdea,
                    ),
                ),
                BlocProvider(
                  create: (context) => getIt<GetFundsByInvestmentIdeaCubit>(),
                ),
              ],
              child: FundsListByInvestmentIdeaScreen(
                investmentIdea: investmentIdea,
              ),
            );
          },
        );

      case Routes.investLumpsum:
        final PurchaseFundArgs args = settings.arguments as PurchaseFundArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<AddToCartCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<CreateLumpsumPurchaseCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<CreateConsentCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<VerifyConsentCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<IsSchemePresentCubit>()
                  ..isSchemePresent(
                      params: IsSchemePresentParams(
                    schemeID: args.fund.schemeCode,
                    purchaseType: args.purchaseType,
                  )),
              ),
            ],
            child: InvestLumpsumScreen(
                fund: args.fund,
                fundDetail: args.fundDetail,
                fpFundDetails: args.fpFundDetails),
          ),
        );
      case Routes.investSIP:
        final PurchaseFundArgs args = settings.arguments as PurchaseFundArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<SipOrderCubit>(),
              ),
              BlocProvider(
                create: (_) => getIt<GetPrimaryBankCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<CreateConsentCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<AddToCartCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<VerifyConsentCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<IsSchemePresentCubit>()
                  ..isSchemePresent(
                      params: IsSchemePresentParams(
                    schemeID: args.fund.schemeCode,
                    purchaseType: args.purchaseType,
                  )),
              ),
            ],
            child: InvestSIPScreen(
              fund: args.fund,
              fundDetail: args.fundDetail,
              fpFundDetails: args.fpFundDetails,
            ),
          ),
        );

      case Routes.detailedFundView:
        final DetailedFundViewArgs args =
            settings.arguments as DetailedFundViewArgs;
        // final Fund fund = args.fund.schemeCode;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<FundDetailsCubit>()
                  ..getFundDetails(schemeCode: args.schemeCode),
              ),
              BlocProvider(
                create: (context) => getIt<MFChartCubit>()
                  ..fetchMFChartData(
                      MutualFundTimePeriod.sixMonth, args.schemeCode),
              ),
              BlocProvider(
                create: (context) => getIt<GetFundCubit>()
                  ..getFundBySchemeCode(
                    schemeCode: args.schemeCode,
                  ),
              ),
              BlocProvider(
                create: (context) => getIt<FpFundDetailsCubit>(),
              ),
            ],
            child: const FundDetailsScreen(),
          ),
        );

      case Routes.allHoldingsScreen:
        final args = settings.arguments as AllHoldingArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AllHoldingsScreen(holdings: args.holdings),
        );

      //Digital Gold Routes
      case Routes.digitalGold:
        return MaterialPageRoute(
          builder: (context) => const DigitalGoldDashboardScreen(),
        );
      case Routes.digitalGoldSips:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DigitalGoldSipsScreen(),
        );
      case Routes.digitalGoldPayment:
        final args = settings.arguments as DigitalGoldPaymentArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<PostPaymentCubit>(),
              ),
            ],
            child: DigitalGoldPaymentScreen(
                createOrderParams: args.createOrderParams,
                createOrderResponseModel: args.createOrderResponseModel,
                timeOut: args.timeOut),
          ),
        );
      case Routes.deliveryPayment:
        final args = settings.arguments as DeliveryPaymentArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<PostPaymentCubit>(),
              ),
            ],
            child: DeliveryPaymentScreen(
              createDeliveryOrderParams: args.createDeliveryOrderParams,
              createOrderResponseModel: args.createOrderResponseModel,
            ),
          ),
        );
      case Routes.digitalGoldTransactionStatus:
        final args = settings.arguments as DigitalGoldTransactionStatusArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            ///If the transaction is success then refresh the processing transactions
            if (args.isSuccess) {
              ///We refresh the processing transactions of delivery only if the transaction is delivery
              ///as it will not change the other list.
              ///We also check if the cubit is not null as the value will be null until user access my
              ///portfolio. This scenario occurs when user directly tries to purchase gold or silver without
              ///opening my portfolio page.
              if (args.transactionType == DGTransactionType.delivery &&
                  _dgDeliveryTransactionCubit != null) {
                _dgDeliveryTransactionCubit!.fetchProcessingTransactions();
              } else if (_dgTransactionCubit != null) {
                _dgTransactionCubit!.fetchProcessingTransactions();
              }
            }
            return DigitalGoldTransactionStatusScreen(
              transactionType: args.transactionType,
              isSuccess: args.isSuccess,
              orderDetails: args.orderDetails,
              errorResponse: args.errorResponse,
            );
          },
        );
      case Routes.digitalGoldDelivery:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DigitalGoldDeliveryScreen(),
        );
      case Routes.digitalGoldDeliveryDetailedView:
        final args = settings.arguments as DigitalGoldDeliveryDetailedViewArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DeliveryDetailedViewScreen(
            deliveryProduct: args.deliveryProduct,
          ),
        );
      case Routes.neoBasketOrders:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<BasketBuyOrderCubit>()
                  ..getBasketBuyOrder(
                    const BasketBuyOrderParam(),
                  ),
              ),
              BlocProvider(
                create: (context) => getIt<BasketSellOrderCubit>()
                  ..getBasketSellOrder(
                    const BasketSellOrderParam(),
                  ),
              ),
            ],
            child: const NeoBasketOrderScreen(),
          ),
        );
      case Routes.basketOrderTransactionDetailsScreen:
        BasketTransactionDetailsArgs args =
            settings.arguments as BasketTransactionDetailsArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<BasketOrderDetailsCubit>()
                  ..getBasketOrderTransactionDetails(
                    BasketTransactionDetailParams(orderRef: args.orderRef),
                  ),
              ),
            ],
            child: const BasketOrderTransactionDetailsScreen(),
          ),
        );
      case Routes.profile:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => _notificationCountCubit =
                getIt<NotificationCountCubit>()..getUnreadNotificationCount(),
            child: const ProfileScreen(),
          ),
        );
      case Routes.viewEditNominee:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<UploadNomineeDetailsCubit>()..fetchNomineeDetails(),
            child: const ViewEditNomineeScreen(),
          ),
        );
      case Routes.accountDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AccountDetailsScreen(),
        );
      case Routes.selectDeliveryAddress:
        final args = settings.arguments as DeliveryProductArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) {
              _deliveryAddressCubit = getIt<DeliveryAddressCubit>()
                ..getDeliveryAddresses();
              return _deliveryAddressCubit!;
            },
            child: SelectDeliveryScreen(dP: args),
          ),
        );
      case Routes.digitalGoldOrderStatus:
        final args = settings.arguments as DgOrderStatusArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DigitalGoldOrderStatusScreen(
              transactionModel: args.transaction,
              transactionStatus: args.transactionStatus),
        );
      case Routes.digitalGoldInvestmentDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DigitalGoldInvestmentDetailsScreen(),
        );
      case Routes.digitalGoldTransactions:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<DgTransactionCubit>()
                  ..fetchTransactions(
                      transactionStatus: DgTransactionStatus.success),
              ),
              BlocProvider(
                create: (context) => getIt<DgDeliveryTransactionCubit>()
                  ..fetchTransactions(
                      transactionStatus: DgTransactionStatus.success),
              ),
            ],
            child: const DigitalGoldTransactionsScreen(),
          ),
        );
      case Routes.deliveryCheckOut:
        final args = settings.arguments as DeliveryCheckoutArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => getIt<CreateDeliveryOrderCubit>()),
              BlocProvider(
                create: (context) => getIt<CheckoutDeliveryOrderCubit>()
                  ..checkOutDeliveryOrder(CheckoutDeliveryOrderParams(
                      shippingUserAddressId:
                          args.createDeliveryOrderParams.shippingUserAddressId,
                      billingUserAddressId:
                          args.createDeliveryOrderParams.billingUserAddressId,
                      isShippingSameAsBilling: args
                          .createDeliveryOrderParams.isShippingSameAsBilling,
                      products: args.createDeliveryOrderParams.products)),
              ),
            ],
            child: DeliveryCheckoutScreen(
              createDeliveryOrderParams: args.createDeliveryOrderParams,
              deliveryProduct: args.deliveryProductModel,
            ),
          ),
        );
      case Routes.deliveryAddress:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) {
              _deliveryAddressCubit = getIt<DeliveryAddressCubit>()
                ..getDeliveryAddresses();
              return _deliveryAddressCubit!;
            },
            child: const DeliveryAddressScreen(),
          ),
        );
      case Routes.addDeliveryAddress:
        final args = settings.arguments as AddAddressScreenArgs?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _deliveryAddressCubit!,
              ),
              BlocProvider(
                create: (context) => getIt<AddDeliveryAddressCubit>(),
              ),
            ],
            child: AddAddressScreen(args: args),
          ),
        );

      case Routes.securityOptions:
        return MaterialPageRoute(builder: (_) => const SecurityScreen());
      case Routes.lumpsumOrderSummaryScreen:
        final args = settings.arguments as LumpsumOrderSummaryArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<InitiateLumpsumPurchaseCubit>(),
              ),
            ],
            child: LumpsumOrderSummaryScreen(
              fundDetail: args.fundDetail,
              lumpsumPurchase: args.lumpsumPurchase,
            ),
          ),
        );
      case Routes.sipOrderSummaryScreen:
        final args = settings.arguments as SipOrderSummaryArgs;
        return MaterialPageRoute(
            builder: (_) => SipOrderSummaryScreen(sipOrder: args.sipOrder));
      case Routes.paymentWebView:
        final args = settings.arguments as PaymentWebViewArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PaymentWebViewScreen(
              url: args.url, transactionType: args.transactionType),
        );

      case Routes.aboutUs:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AboutUsScreen(),
        );
      case Routes.aboutWebView:
        final args = settings.arguments as AboutWebViewArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AboutWebView(url: args.url, title: args.title),
        );
      case Routes.mySystematicPlans:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ActiveSystematicPlansCubit>(
                create: (context) {
                  _activeSystematicPlansCubit = getIt<SystematicPlansCubit>();
                  return _activeSystematicPlansCubit!
                    ..getSystematicPlans(
                      GetSystematicPlansParams(
                        userId: context.read<AuthCubit>().state.user!.id,
                        isActive: true,
                      ),
                    );
                },
              ),
              BlocProvider<InactiveSystematicPlansCubit>(
                create: (context) {
                  _inactiveSystematicPlansCubit = getIt<SystematicPlansCubit>();
                  return _inactiveSystematicPlansCubit!
                    ..getSystematicPlans(GetSystematicPlansParams(
                        userId: context.read<AuthCubit>().state.user!.id,
                        isActive: false));
                },
              ),
            ],
            child: const MySystematicPlanScreen(),
          ),
        );

      case Routes.sipDetail:
        final args = settings.arguments as SystematicPlanArgs;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<CancelSystematicPlanCubit>(),
                    ),
                    BlocProvider.value(
                      value: _activeSystematicPlansCubit!,
                    ),
                    BlocProvider(
                        create: (context) =>
                            getIt<SystematicPlanInstallmentsCubit>()
                              ..fetchSipInstallments(
                                  userId:
                                      context.read<AuthCubit>().state.user!.id,
                                  sipId: int.parse(args.plan.orderId!))),
                  ],
                  child: SipDetailScreen(
                    sip: args.plan,
                  ),
                ));
      case Routes.stpDetail:
        final args = settings.arguments as SystematicPlanArgs;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<CancelSystematicPlanCubit>(),
                    ),
                    BlocProvider.value(
                      value: _activeSystematicPlansCubit!,
                    ),
                    BlocProvider(
                        create: (context) =>
                            getIt<SystematicPlanInstallmentsCubit>()
                              ..fetchStpInstallments(
                                  userId:
                                      context.read<AuthCubit>().state.user!.id,
                                  stpId: args.plan.orderId!)),
                  ],
                  child: StpDetailScreen(
                    stp: args.plan,
                  ),
                ));
      case Routes.swpDetail:
        final args = settings.arguments as SystematicPlanArgs;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<CancelSystematicPlanCubit>(),
                    ),
                    BlocProvider.value(
                      value: _activeSystematicPlansCubit!,
                    ),
                    BlocProvider(
                        create: (context) =>
                            getIt<SystematicPlanInstallmentsCubit>()
                              ..fetchSwpInstallments(
                                  userId:
                                      context.read<AuthCubit>().state.user!.id,
                                  swpId: args.plan.orderId!)),
                  ],
                  child: SwpDetailScreen(
                    swp: args.plan,
                  ),
                ));

      case Routes.cancelSipSuccess:
        return MaterialPageRoute(
            builder: (_) => const CancelSipSuccessScreen());
      case Routes.fundTransactions:
        final args = settings.arguments as FundTransactionArgs;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<MfTransactionsCubit>()
                    ..fetchMfTransactions(
                        isin: args.scheme.isin,
                        folioNumber: args.scheme.folioNumber),
                  child: FundTransactionScreen(
                    scheme: args.scheme,
                    fund: args.fund,
                  ),
                ));
      case Routes.redeem:
        final args = settings.arguments as FundTransactionArgs;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<CreateRedeemOrderCubit>(),
                    ),
                    BlocProvider(
                      create: (context) =>
                          getIt<GetPrimaryBankCubit>()..getPrimaryBank(),
                    ),
                  ],
                  child: RedeemScreen(
                    scheme: args.scheme,
                    fund: args.fund,
                  ),
                ));

      case Routes.redeemVerifyOtp:
        final args = settings.arguments as RedeemTransactionArgs;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<VerifyTransactionOtpCubit>(),
                  child: RedemptionVerifyOtpScreen(
                    scheme: args.scheme,
                    redeemOrderResponse: args.redeemResponse,
                  ),
                ));

      case Routes.mfTransactionStatus:
        final args = settings.arguments as MfTransactionStatusArgs;
        return MaterialPageRoute(builder: (context) {
          ///We will be refreshing the users holdings and pending orders if the transaction is successful.
          if (args.transactionStatus == MfTransactionStatus.success) {
            /// For SIP and Lumpsum we need not refresh the holdings on success as the holdings data won't be changed.
            if (args.transactionType == MFTransactionTypes.sip ||
                args.transactionType == MFTransactionTypes.lumpsum) {
              /// Check for null as this can be null if user has never opened the my portfolio page and
              /// this is not initialised.
              if (_mfPendingOrdersCubit != null) {
                _mfPendingOrdersCubit!.refreshPendingOrders(
                  userId: context.read<AuthCubit>().state.user!.id,
                );
              }
            } else if (args.transactionType ==
                MFTransactionTypes.assistedService) {
              /// Check for null as this can be null if user has never opened the my portfolio page and this is not initialised.
              if (_assistedPendingOrdersCubit != null) {
                _assistedPendingOrdersCubit!.refreshPendingOrders(
                  userId: context.read<AuthCubit>().state.user!.id,
                );
              }
            } else {
              /// For other orders we need to refresh the holdings and pending orders as holdings data can be changed.
              ///
              /// Check for null as this can be null if user has never opened the my portfolio page and
              /// this is not initialised.
              ///
              /// Here we check if its assisted service as Redeem and Switch of Assisted Service holdings is different cubit.
              if (args.isAssistedService) {
                if (_assistedHoldingsCubit != null &&
                    _assistedPendingOrdersCubit != null) {
                  _assistedHoldingsCubit!.refreshAssistedHoldings(
                    userId: context.read<AuthCubit>().state.user!.id,
                  );
                  _assistedPendingOrdersCubit!.refreshPendingOrders(
                    userId: context.read<AuthCubit>().state.user!.id,
                  );
                }
              } else if (_mfUserHoldingsCubit != null &&
                  _mfPendingOrdersCubit != null) {
                _mfUserHoldingsCubit!.refreshUserHoldings(
                    userId: context.read<AuthCubit>().state.user!.id);
                _mfPendingOrdersCubit!.refreshPendingOrders(
                  userId: context.read<AuthCubit>().state.user!.id,
                );
              }
            }
          }
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<GetGoalPlanningDashboardDataCubit>()
                  ..getDashboardData(goaltype: ''),
              ),
              BlocProvider(
                create: (context) => getIt<CreateGoalInvestementsCubit>(),
              ),
            ],
            child: MFTransactionStatusScreen(
              // isSuccess: args.isSuccess,
              mfTransactionStatus: args.transactionStatus,
              transactionType: args.transactionType,
            ),
          );
        });

      case Routes.switchFundList:
        final args = settings.arguments as FundTransactionArgs;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<SwitchFundsListCubit>()
                    ..getSwitchFunds(
                        schemeCode: args.fund.schemeCode,
                        switchAmount: args.scheme.currentValue,
                        amcCode: args.fund.amcCode),
                  child: SwitchFundListScreen(
                      fund: args.fund, scheme: args.scheme),
                ));
      case Routes.switchFund:
        final args = settings.arguments as SwitchFundArgs;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<CreateSwitchOrderCubit>(),
                  child: SwitchFundScreen(
                    scheme: args.scheme,
                    switchFund: args.switchFund,
                    fund: args.fund,
                  ),
                ));
      case Routes.switchVerifyOtp:
        final args = settings.arguments as SwitchFundArgs;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => getIt<VerifyTransactionOtpCubit>(),
                child: SwitchFundVerifyOtpScreen(
                    fund: args.fund,
                    switchFund: args.switchFund,
                    scheme: args.scheme,
                    switchOrderResponse: args.switchResponse!)));
      case Routes.stpFundList:
        final args = settings.arguments as FundTransactionArgs;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<StpFundsListCubit>()
                    ..getStpFunds(
                        schemeCode: args.fund.schemeCode,
                        stpAmount: args.scheme.investedAmount,
                        amcCode: args.fund.amcCode),
                  child:
                      StpFundListScreen(fund: args.fund, scheme: args.scheme),
                ));
      case Routes.stpFund:
        final args = settings.arguments as StpFundArgs;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<CreateStpOrderCubit>(),
                    ),
                    BlocProvider(
                        create: (context) => getIt<FpFundDetailsCubit>()
                          ..fetchFpFundDetails(isin: args.scheme.isin)),
                  ],
                  child: StpFundScreen(
                    scheme: args.scheme,
                    stpFund: args.stpFund,
                    fund: args.fund,
                  ),
                ));
      case Routes.stpVerifyOtp:
        final args = settings.arguments as StpFundArgs;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => getIt<VerifyTransactionOtpCubit>(),
                child:
                    StpVerifyOtpScreen(stpOrderResponse: args.stpResponse!)));
      case Routes.swpFund:
        final args = settings.arguments as SwpFundArgs;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => getIt<CreateSwpOrderCubit>()),
                    BlocProvider(
                        create: (context) => getIt<FpFundDetailsCubit>()
                          ..fetchFpFundDetails(isin: args.scheme.isin)),
                    BlocProvider(
                      create: (context) =>
                          getIt<GetPrimaryBankCubit>()..getPrimaryBank(),
                    ),
                  ],
                  child: SwpFundScreen(fund: args.fund, scheme: args.scheme),
                ));
      case Routes.swpVerifyOtp:
        final args = settings.arguments as SwpFundArgs;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => getIt<VerifyTransactionOtpCubit>(),
                child: SwpFundVerifyOtpScreen(
                    swpOrderResponse: args.swpResponse!)));
      case Routes.mfOrderStatusScreen:
        final args = settings.arguments as MfOrderStatusArgs;
        return MaterialPageRoute(
            builder: (_) => MfOrderStatusScreen(mfOrder: args.mfOrder));
      case Routes.reports:
        return MaterialPageRoute(
          builder: (_) => const ReportsScreen(),
        );
      case Routes.contactUs:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<ContactUsCubit>()..fetchContactUsCategories(),
              ),
              BlocProvider(
                create: (context) => getIt<CategoryQuestionsCubit>()
                  ..fetchQuestions(GetCategoryQuestionsParams()),
              ),
            ],
            child: const ContactUsScreen(),
          ),
        );
      case Routes.categoryQuestions:
        final args = settings.arguments as CategoryQuestionsArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<CategoryQuestionsCubit>()
              ..fetchQuestions(
                GetCategoryQuestionsParams(
                  size: '10',
                  category: args.category,
                  query: args.query,
                ),
              ),
            child: CategoryQuestionsScreen(
                title: args.title, category: args.category),
          ),
        );
      case Routes.categoryQuestionsDetail:
        final args = settings.arguments as CategoryQuestionsDetailArgs;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CategoryQuestionsDetailCubit>()
                  ..fetchQuestionAnswer(),
              ),
              BlocProvider(
                create: (context) => getIt<CategoryQuestionsCubit>()
                  ..fetchQuestions(
                      GetCategoryQuestionsParams(query: args.query)),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<GetDislikeReasonsCubit>()..fetchDislikeReasons(),
              ),
              BlocProvider(
                create: (context) => getIt<CaptureFaqLikeCubit>(),
              ),
            ],
            child: CategoryQuestionsDetailScreen(
              title: args.title,
              articletitle: args.articletitle,
              articleid: args.articleid,
              query: args.query,
            ),
          ),
        );
      case Routes.contactUsForm:
        // final args = settings.arguments as MfOrderStatusArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ContactUsFormCubit>(),
            child: const ContactUsFormScreen(),
          ),
        );

      case Routes.mFOrdersScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<MfOrdersCubit>()
                  ..fetchOrders(
                    userId: context.read<AuthCubit>().state.user!.id,
                  ),
              ),
              BlocProvider(
                create: (context) => getIt<MfOrdersFilterSortCubit>(),
              ),
            ],
            child: const MFOrdersScreen(),
          ),
        );

      case Routes.goldOrdersScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<DgTransactionCubit>()
                  ..fetchTransactions(
                      transactionStatus: DgTransactionStatus.all),
              ),
            ],
            child: const GoldOrdersScreen(),
          ),
        );

      case Routes.notifications:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<UserNotificationCubit>()..fetchUserNotifications(),
              ),
              BlocProvider(
                create: (context) => getIt<NotificationActionCubit>(),
              ),
              BlocProvider.value(value: _notificationCountCubit!),
            ],
            child: const NotificationsScreen(),
          ),
        );
      case Routes.importExternalFundsPan:
        return MaterialPageRoute(
          builder: (context) {
            // final user = context.read<AuthCubit>().state.user!;
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<AccountDetailsCubit>()
                    ..getAccountDetails(
                      userId: context.read<AuthCubit>().state.user!.id,
                    ),
                ),
                BlocProvider(
                  create: (context) => getIt<TransactionCubit>(),
                ),
              ],
              child: const ImportExternalFundsAccountScreen(),
            );
          },
        );
      case Routes.importExternalFundsVerifyOtp:
        final params = settings.arguments as ValidateTransactionParams;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (BuildContext context) => getIt<TransactionCubit>(),
            child: ImportExternalFundsVerifyOtpScreen(
              userId: params.userID,
              panNumber: params.panNumber,
              phoneNumber: params.phoneNumber,
              transactionId: params.transactionID,
            ),
          ),
        );

      case Routes.brokerHoldingFundScreen:
        final args = settings.arguments as BrokerFundInvestmentArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<BrokerHoldingsFundCubit>()
                  ..getBrokerHoldingsFund(
                    userId: args.userId,
                    brokerName: args.brokerName,
                  ),
              ),
            ],
            child: BrokerHoldingsFundScreen(
              brokerName: args.brokerName,
              currentAssetValue: args.currentAssetValue,
              investedValue: args.investedValue,
              returnValue: args.returnValue,
            ),
          ),
        );

      case Routes.importingFundScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ImportingMutualFund(),
        );
      case Routes.marketNews:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MarketNews(),
        );
      case Routes.marketDigest:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MarketDigest(),
        );
      case Routes.importFundSuccess:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ImportFundSuccessScreen(),
        );
      case Routes.importFundFail:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ImportExternalFundFailScreen(),
        );
      case Routes.portfolioAnalysis:
        final args = settings.arguments as PortfolioAnalysisArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (BuildContext context) => getIt<PortfolioAnalysisCubit>()
              ..getPortfolioAnalysis(
                userId: context.read<AuthCubit>().state.user!.id,
              ),
            child: PortfolioAnalysisScreen(
              debtPercentage: args.debtPercentage,
              equityPercentage: args.equityPercentage,
              hybridPercentage: args.hybridPercentage,
              xirr: args.xirr,
              holdingsCount: args.holdingsCount,
            ),
          ),
        );
      case Routes.lamf:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CreditScreen());
      case Routes.smartIndex:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) => getIt<FetchSmartIndicesCubit>()
                    ..getSmartIndices(FetchIndicesParams(
                      page: '',
                      size: '',
                      sort: '',
                      category: '',
                      searchString: '',
                    )),
                  child: const SmartIndex(),
                ));
      case Routes.smartSubsidiaryScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) =>
                      getIt<GetBusinessHousesCubit>()..getBusinessHouses(),
                  child: const SmartSubsidiaryScreen(),
                ));
      case Routes.allIndexScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (context) => getIt<FetchSmartIndicesCubit>()
                    ..getSmartIndices(FetchIndicesParams(
                      page: '',
                      size: '',
                      sort: '',
                      category: '',
                      searchString: '',
                    )),
                  child: const AllIndexScreen(),
                ));
      case Routes.pledgedMFScreen:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) =>
                getIt<LamfLoanClosureCubit>()..lamfLoanClosure(),
            child: const PledgedMFsScreen(),
          );
        });

      case Routes.equity:
        return MaterialPageRoute(
          builder: (_) => const EquityInvestScreens(),
        );

      case Routes.equityLogin:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<TransactionidCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<GetAllBrokersCubit>()..fetchBroker(),
              ),
              BlocProvider(
                create: (context) => getIt<SmallcaseLoginCubit>(),
              ),
            ],
            child: const EquityLogin(),
          ),
        );

      case Routes.equityHomeNotification:
        return MaterialPageRoute(
          builder: (_) => const EquityNotification(),
        );

      case Routes.equitySignup:
        return MaterialPageRoute(
          builder: (_) => const CreateAcc(),
        );

      case Routes.equityTermsConditions:
        return MaterialPageRoute(
          builder: (_) => const EquityTermCondition(),
        );

      case Routes.exploreStockDetail:
        final args = settings.arguments as StockDetailsArgs;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => getIt<StockDetailsCubit>()
                    ..fetchStockDetails(
                        StockDetailsParams(symbol: args.symbolName))),
              BlocProvider(
                  create: (context) => getIt<StockChartCubit>()
                    ..fetchChartData(
                        EquityChartTimePeriod.oneMonth, args.symbolName)),
              // BlocProvider(create: (context) => getIt<BuySellTransactionCubit>()),
            ],
            child: StockDetailsScreen(
              sybNmae: args.symbolName,
              industry: args.industry,
              percentage: args.percentage,
              change: args.change,
              close: args.close,
              name: args.name,
              icon: args.icon,
            ),
          ),
        );

      case Routes.equitySmartWatchlistHoldings:
        return MaterialPageRoute(
          builder: (holdinContext) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<SmartWatchlistSearchCubit>(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<SmartWatchlistHoldingsCubit>()..fetchHoldings(),
              ),
            ],
            child: const SmartWatchlistHoldings(),
          ),
        );

      case Routes.equityInvesScreen:
        return MaterialPageRoute(
          builder: (_) => const EquityInvestScreens(),
        );

      case Routes.importLoanFormScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<LoanImportDetailsCubit>()..getLoanImportDetails(),
              ),
              BlocProvider(
                create: (context) => getIt<GetInitiateImportLoansCubit>(),
              )
            ],
            child: const ImportLoanForm(),
          ),
        );

      case Routes.importLoanPhoneValidation:
        final args = settings.arguments as ImportLoanPhoneValidationArgs;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<NavCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<SubmitImportOtpCubit>(),
              ),
            ],
            child: ImportLoanPhoneValidationScreen(args: args),
          ),
        );

      case Routes.otherLoansDetailedScreen:
        final args = settings.arguments as OtherLoanDetailScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<GetLoanDataCubit>()
              ..getLoanData(GetLoanDataParams(accountID: args.accountID)),
            child: OtherLoanDetailsScreen(accountID: args),
          ),
        );

      case Routes.neoCardDiscovery:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<DiscoveryAnimationCubit>(),
              )
            ],
            child: const NeoCardDiscovery(),
          ),
        );

      case Routes.retirementOTPScreen:
        final args = settings.arguments as RetirementCorpusArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<SubmitRetirementOtpCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<GenerateRetirementOtpCubit>(),
              )
            ],
            child: RetirementOTPScreen(
              monthlyIncome: args.monthlyIncome,
              retirementAge: args.retirementAge,
              existingSavings: args.existingSavings,
              investmentStyle: args.investmentStyle,
              monthlyExpense: args.monthlyExpense,
              postRetirementStyle: args.postRetirementStyle,
              requestId: args.requestID,
            ),
          ),
        );

      case Routes.planYourFutureScreen:
        final args = settings.arguments as RetirementCorpusArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<RetirementCorpusCubit>()
                  ..fetchRetirementCorpus(
                    RetirementCorpusParams(
                        monthlyIncome: args.monthlyIncome,
                        retirementAge: args.retirementAge,
                        existingSavings: args.existingSavings,
                        investmentStyle: args.investmentStyle,
                        monthlyExpense: args.monthlyExpense,
                        postRetirementStyle: args.postRetirementStyle),
                  ),
              ),
              BlocProvider(
                create: (context) => getIt<RetirementInflationCalculatorCubit>()
                  ..fetchInflationCalculator(
                    RetirementInflationCalculatorParams(
                        currentExpense: args.monthlyExpense,
                        retirementAge: args.retirementAge,
                        inflation: 6),
                  ),
              ),
              BlocProvider(
                create: (context) => getIt<RetirementPassbookCubit>()
                  ..fetchEPFReport(
                    RetirementPassbookParams(
                      requestId: args.requestID,
                      refreshNeeded: 'false',
                    ),
                  ),
              )
            ],
            child: PlanYourFutureScreen(
              monthlyIncome: args.monthlyIncome,
              retirementAge: args.retirementAge,
              existingSavings: args.existingSavings,
              investmentStyle: args.investmentStyle,
              monthlyExpense: args.monthlyExpense,
              postRetirementStyle: args.postRetirementStyle,
              requestID: args.requestID,
            ),
          ),
        );

      case Routes.financialDetailsScreens:
        return MaterialPageRoute(
          builder: (_) => const FinancialDetailsScreens(),
        );

      case Routes.tellUsScreen:
        final args = settings.arguments as RetirementFinancialDetailsArgs;
        return MaterialPageRoute(
          builder: (_) => TellUsScreen(
            expence: args.expence,
            income: args.income,
            saving: args.saving,
          ),
        );

      case Routes.retirementEPFTransactionDetails:
        final args = settings.arguments as RetirementEPFTransactionDetailsArgs;
        return MaterialPageRoute(
          builder: (_) => EPFTransactionDetails(
            company: args.company,
            name: args.name,
            uan: args.uan,
          ),
        );

      case Routes.retirementAgeScreen:
        final args = settings.arguments as RetirementAgeArgs;
        return MaterialPageRoute(
          builder: (_) => RetirementAgeScreen(
            expence: args.expence,
            income: args.income,
            saving: args.saving,
            selectedOption: args.selectedOption,
            isSafe: args.isSafe,
          ),
        );

      case Routes.retirementETFDetailsScreen:
        final args = settings.arguments as RetirementPassBookArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<RetirementPassbookCubit>()
                  ..fetchEPFReport(
                    RetirementPassbookParams(
                      requestId: args.requestID,
                      refreshNeeded: args.refreshNeeded,
                    ),
                  ),
              )
            ],
            child: EPFDetailsScreen(requestId: args.requestID),
          ),
        );

      case Routes.capitalGainDetails:
        final args = settings.arguments as CapitalGainReportArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<GetCapitalGainReportCubit>()
                  ..fetchCapitalGainReport(
                    CapitalGainReportParams(financialYear: args.financialYear),
                  ),
              ),
              BlocProvider(
                create: (context) => getIt<GenerateCapitalGainsFileCubit>(),
              ),
            ],
            child: CapitalGainDetails(financialYear: args.financialYear),
          ),
        );

      case Routes.finacialYearReportScreen:
        return MaterialPageRoute(
          builder: (_) => const FinacialYearReportScreen(),
        );

      case Routes.goalPlanningOnboardScreen:
        return MaterialPageRoute(
          builder: (_) => const GoalPlanningOnboardScreen(),
        );

      case Routes.goalPlanningReturnUser:
        return MaterialPageRoute(
          builder: (_) => const GoalPlanningReturnUser(),
        );

      case Routes.goalChoiceScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<GetGoalsCoreDataCubit>()..fetchGoalCoreData(),
              )
            ],
            child: const GoalChoiceScreen(),
          ),
        );

      case Routes.goalSettingScreen:
        final args = settings.arguments as GoalSettingArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CreateUserGoalsCubit>(),
              )
            ],
            child: GoalSettingScreen(
              goalName: args.goalName,
              goalType: args.goalType,
            ),
          ),
        );

      case Routes.goalPlanDashboardScreen:
        final args = settings.arguments as GoalDashboardArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<GetGoalDetailsCubit>()
                  ..fetchGoalDetails(
                    GetGoalsDetailsParams(id: args.id),
                  ),
              )
            ],
            child: GoalPlanDashboardScreen(
              goalName: args.goalName,
              id: args.id,
            ),
          ),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  void dispose() {
    _verifyPanCubit?.isClosed ?? false ? _verifyPanCubit?.close() : null;
  }
}
