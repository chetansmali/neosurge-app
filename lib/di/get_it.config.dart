// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:dio/dio.dart' as _i29;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/api/api_client.dart' as _i31;
import '../core/api/injection_module.dart' as _i536;
import '../core/token_service.dart' as _i30;
import '../data/data_sources/local/account_local_data_source.dart' as _i3;
import '../data/data_sources/local/digital_gold_local_data_source.dart' as _i6;
import '../data/data_sources/local/dropdown_local_data_source.dart' as _i8;
import '../data/data_sources/local/kyc_local_data_source.dart' as _i11;
import '../data/data_sources/local/mutual_fund_local_data_source.dart' as _i19;
import '../data/data_sources/local/token_local_data_source.dart' as _i26;
import '../data/data_sources/remote/account_remote_data_source.dart' as _i223;
import '../data/data_sources/remote/assisted_service_remote_data_source.dart'
    as _i32;
import '../data/data_sources/remote/contact_us_remote_data_source.dart' as _i35;
import '../data/data_sources/remote/digital_gold_remote_data_source.dart'
    as _i38;
import '../data/data_sources/remote/dropdown_remote_data_source.dart' as _i41;
import '../data/data_sources/remote/equity_remote_data_source.dart' as _i44;
import '../data/data_sources/remote/external_fund_remote_data_source.dart'
    as _i47;
import '../data/data_sources/remote/goal_planning_remote_data_source.dart'
    as _i110;
import '../data/data_sources/remote/kyc_remote_data_source.dart' as _i123;
import '../data/data_sources/remote/lamf_remote_data_source.dart' as _i126;
import '../data/data_sources/remote/market_news_remote_data_source.dart'
    as _i130;
import '../data/data_sources/remote/mutual_fund_remote_data_source.dart'
    as _i133;
import '../data/data_sources/remote/neobasket_remote_data_source.dart' as _i136;
import '../data/data_sources/remote/notification_remote_data_source.dart'
    as _i139;
import '../data/data_sources/remote/retirement_calculator_remote_data_source.dart'
    as _i163;
import '../data/repositories/account_repository_impl.dart' as _i225;
import '../data/repositories/assisted_service_repository_impl.dart' as _i34;
import '../data/repositories/contact_us_repository_impl.dart' as _i37;
import '../data/repositories/digital_gold_repository_impl.dart' as _i40;
import '../data/repositories/dropdown_repository_impl.dart' as _i43;
import '../data/repositories/equity_repository_impl.dart' as _i46;
import '../data/repositories/external_fund_repository_impl.dart' as _i49;
import '../data/repositories/goal_planning_repository_impl.dart' as _i112;
import '../data/repositories/kyc_repository_impl.dart' as _i125;
import '../data/repositories/lamf_repository_impl.dart' as _i128;
import '../data/repositories/market_news_repository_impl.dart' as _i132;
import '../data/repositories/mutual_fund_repository_impl.dart' as _i135;
import '../data/repositories/neobaskets_repository_impl.dart' as _i138;
import '../data/repositories/notification_repository_impl.dart' as _i141;
import '../data/repositories/retirement_calculator_repository_impl.dart'
    as _i165;
import '../data/repositories/token_repository_impl.dart' as _i28;
import '../domain/repositories/account_repository.dart' as _i224;
import '../domain/repositories/assisted_service_repository.dart' as _i33;
import '../domain/repositories/contact_us_repository.dart' as _i36;
import '../domain/repositories/digital_gold_repository.dart' as _i39;
import '../domain/repositories/dropdown_repository.dart' as _i42;
import '../domain/repositories/equity_respository.dart' as _i45;
import '../domain/repositories/external_fund_repository.dart' as _i48;
import '../domain/repositories/goal_planning_repository.dart' as _i111;
import '../domain/repositories/kyc_repository.dart' as _i124;
import '../domain/repositories/lamf_repository.dart' as _i127;
import '../domain/repositories/market_news_repository.dart' as _i131;
import '../domain/repositories/mutual_fund_repository.dart' as _i134;
import '../domain/repositories/neobaskets_repository.dart' as _i137;
import '../domain/repositories/notification_repository.dart' as _i140;
import '../domain/repositories/retirement_calculator_repository.dart' as _i164;
import '../domain/repositories/token_repository.dart' as _i27;
import '../domain/usecases/account/add_delivery_address.dart' as _i226;
import '../domain/usecases/account/add_profile_bank_details.dart' as _i229;
import '../domain/usecases/account/add_user_mandate.dart' as _i234;
import '../domain/usecases/account/authorise_mandate.dart' as _i238;
import '../domain/usecases/account/delete_delivery_address.dart' as _i291;
import '../domain/usecases/account/delete_user_mandate.dart' as _i296;
import '../domain/usecases/account/delete_user_mandate_by_id.dart' as _i297;
import '../domain/usecases/account/get_all_switchable_mandates.dart' as _i316;
import '../domain/usecases/account/get_delivery_address_list.dart' as _i338;
import '../domain/usecases/account/get_kyc_last_route.dart' as _i362;
import '../domain/usecases/account/get_sips_by_mandate.dart' as _i390;
import '../domain/usecases/account/get_user.dart' as _i398;
import '../domain/usecases/account/get_user_bank_list.dart' as _i400;
import '../domain/usecases/account/get_user_mandate_by_id.dart' as _i402;
import '../domain/usecases/account/get_user_mandates.dart' as _i403;
import '../domain/usecases/account/get_user_mandates_by_bank.dart' as _i404;
import '../domain/usecases/account/get_user_primary_bank.dart' as _i406;
import '../domain/usecases/account/logout_user.dart' as _i15;
import '../domain/usecases/account/set_user.dart' as _i459;
import '../domain/usecases/account/update_primary_bank_account.dart' as _i469;
import '../domain/usecases/account/update_profile_bank_ifsc.dart' as _i471;
import '../domain/usecases/account/update_profile_photo.dart' as _i472;
import '../domain/usecases/account/verify_delete_mandate.dart' as _i489;
import '../domain/usecases/assisted_service/get_assisted_holdings.dart' as _i56;
import '../domain/usecases/assisted_service/get_assisted_orders.dart' as _i57;
import '../domain/usecases/assisted_service/get_assisted_service_details.dart'
    as _i58;
import '../domain/usecases/assisted_service/get_assisted_switch_funds.dart'
    as _i60;
import '../domain/usecases/assisted_service/get_questions.dart' as _i90;
import '../domain/usecases/assisted_service/get_suggested_funds.dart' as _i103;
import '../domain/usecases/assisted_service/initiate_suggested_funds_payment.dart'
    as _i119;
import '../domain/usecases/assisted_service/invest_suggested_funds.dart'
    as _i121;
import '../domain/usecases/assisted_service/post_payment_assisted_service.dart'
    as _i148;
import '../domain/usecases/assisted_service/submit_choices.dart' as _i180;
import '../domain/usecases/assisted_service/unlock_assisted_service.dart'
    as _i187;
import '../domain/usecases/assisted_service/verify_assisted_service_pin.dart'
    as _i204;
import '../domain/usecases/contact_us/capture_faq_dislike.dart' as _i246;
import '../domain/usecases/contact_us/capture_faq_like.dart' as _i248;
import '../domain/usecases/contact_us/get_category_question_detail.dart'
    as _i66;
import '../domain/usecases/contact_us/get_category_questions_list.dart' as _i67;
import '../domain/usecases/contact_us/get_contact_us_categories_list.dart'
    as _i70;
import '../domain/usecases/contact_us/get_dislike_reasons_list.dart' as _i76;
import '../domain/usecases/contact_us/post_support_email.dart' as _i150;
import '../domain/usecases/digital_gold/checkout_delivery_order.dart' as _i252;
import '../domain/usecases/digital_gold/create_delivery_order.dart' as _i267;
import '../domain/usecases/digital_gold/create_gold_kyc.dart' as _i270;
import '../domain/usecases/digital_gold/create_gold_user.dart' as _i271;
import '../domain/usecases/digital_gold/create_order.dart' as _i278;
import '../domain/usecases/digital_gold/dg_accept_terms.dart' as _i290;
import '../domain/usecases/digital_gold/dg_add_bank_account.dart' as _i228;
import '../domain/usecases/digital_gold/get_checkout_rates.dart' as _i68;
import '../domain/usecases/digital_gold/get_delivery_products.dart' as _i72;
import '../domain/usecases/digital_gold/get_dg_delivery_transactions.dart'
    as _i73;
import '../domain/usecases/digital_gold/get_dg_transactions.dart' as _i74;
import '../domain/usecases/digital_gold/get_digital_gold_graph.dart' as _i75;
import '../domain/usecases/digital_gold/get_gold_silver_rates.dart' as _i83;
import '../domain/usecases/digital_gold/get_gold_user.dart' as _i84;
import '../domain/usecases/digital_gold/post_payment.dart' as _i147;
import '../domain/usecases/digital_gold/sell_gold_silver.dart' as _i166;
import '../domain/usecases/dropdown/get_all_countries.dart' as _i55;
import '../domain/usecases/equity/add_stock_watchlist.dart' as _i151;
import '../domain/usecases/equity/filter_by_sector_industry.dart' as _i50;
import '../domain/usecases/equity/get_alert_details.dart' as _i53;
import '../domain/usecases/equity/get_all_stocks.dart' as _i100;
import '../domain/usecases/equity/get_all_watchlist.dart' as _i106;
import '../domain/usecases/equity/get_brokers.dart' as _i62;
import '../domain/usecases/equity/get_business_houses.dart' as _i63;
import '../domain/usecases/equity/get_buy_sell_transation.dart' as _i65;
import '../domain/usecases/equity/get_create_watchlist.dart' as _i71;
import '../domain/usecases/equity/get_equity_holdings_token.dart' as _i79;
import '../domain/usecases/equity/get_etf_fund_houses.dart' as _i77;
import '../domain/usecases/equity/get_etfs.dart' as _i78;
import '../domain/usecases/equity/get_gobal_search.dart' as _i82;
import '../domain/usecases/equity/get_holdings.dart' as _i80;
import '../domain/usecases/equity/get_index_price.dart' as _i86;
import '../domain/usecases/equity/get_orders.dart' as _i87;
import '../domain/usecases/equity/get_position.dart' as _i89;
import '../domain/usecases/equity/get_sector_and_industries.dart' as _i91;
import '../domain/usecases/equity/get_smallcase_funds.dart' as _i93;
import '../domain/usecases/equity/get_smallcase_login.dart' as _i94;
import '../domain/usecases/equity/get_smallcase_transaction_id.dart' as _i105;
import '../domain/usecases/equity/get_smart_indices.dart' as _i95;
import '../domain/usecases/equity/get_smart_watchlist_holdings.dart' as _i96;
import '../domain/usecases/equity/get_smart_watchlist_search.dart' as _i97;
import '../domain/usecases/equity/get_stock_chart.dart' as _i81;
import '../domain/usecases/equity/get_stock_details.dart' as _i98;
import '../domain/usecases/equity/get_stocks_by_index.dart' as _i99;
import '../domain/usecases/equity/get_subsidiaries.dart' as _i101;
import '../domain/usecases/equity/get_users_alerts.dart' as _i107;
import '../domain/usecases/equity/get_watchlist_symbol.dart' as _i108;
import '../domain/usecases/equity/remove_alert.dart' as _i153;
import '../domain/usecases/equity/remove_watchlist.dart' as _i156;
import '../domain/usecases/equity/remove_watchlist_symbol.dart' as _i158;
import '../domain/usecases/equity/set_alert.dart' as _i168;
import '../domain/usecases/goal_planning/create_custom_user_goals.dart'
    as _i266;
import '../domain/usecases/goal_planning/create_goal_investment.dart' as _i269;
import '../domain/usecases/goal_planning/get_goal_planning_dashboard.dart'
    as _i346;
import '../domain/usecases/goal_planning/get_goals_core_data.dart' as _i348;
import '../domain/usecases/goal_planning/get_goals_details.dart' as _i350;
import '../domain/usecases/import_external_fund/get_account_details.dart'
    as _i52;
import '../domain/usecases/import_external_fund/get_broker_holding.dart'
    as _i61;
import '../domain/usecases/import_external_fund/get_holding_data.dart' as _i85;
import '../domain/usecases/import_external_fund/get_portfolio_analysis.dart'
    as _i88;
import '../domain/usecases/import_external_fund/initialise_transaction.dart'
    as _i118;
import '../domain/usecases/import_external_fund/validate_transaction.dart'
    as _i203;
import '../domain/usecases/kyc/cheque_ocr_read.dart' as _i254;
import '../domain/usecases/kyc/confirm_pan.dart' as _i257;
import '../domain/usecases/kyc/create_investor_account.dart' as _i272;
import '../domain/usecases/kyc/create_kyc_request.dart' as _i273;
import '../domain/usecases/kyc/create_mf_account.dart' as _i277;
import '../domain/usecases/kyc/delete_nominee_details.dart' as _i293;
import '../domain/usecases/kyc/esign_submit.dart' as _i301;
import '../domain/usecases/kyc/get_bank_details_by_ifsc.dart' as _i319;
import '../domain/usecases/kyc/get_decentro_address.dart' as _i336;
import '../domain/usecases/kyc/get_kyc_address_details.dart' as _i358;
import '../domain/usecases/kyc/get_kyc_bank_details.dart' as _i359;
import '../domain/usecases/kyc/get_kyc_data.dart' as _i360;
import '../domain/usecases/kyc/get_kyc_fatca_details.dart' as _i361;
import '../domain/usecases/kyc/get_kyc_nominee_details.dart' as _i364;
import '../domain/usecases/kyc/get_kyc_personal_details.dart' as _i365;
import '../domain/usecases/kyc/get_kyc_video_otp.dart' as _i366;
import '../domain/usecases/kyc/get_pincode_data.dart' as _i382;
import '../domain/usecases/kyc/ocr_read.dart' as _i142;
import '../domain/usecases/kyc/retake_kyc.dart' as _i161;
import '../domain/usecases/kyc/update_investor_account.dart' as _i189;
import '../domain/usecases/kyc/upload_address_details.dart' as _i191;
import '../domain/usecases/kyc/upload_adhaar_number.dart' as _i192;
import '../domain/usecases/kyc/upload_bank_details.dart' as _i193;
import '../domain/usecases/kyc/upload_cancelled_cheque.dart' as _i194;
import '../domain/usecases/kyc/upload_digital_signature.dart' as _i195;
import '../domain/usecases/kyc/upload_fatca_details.dart' as _i196;
import '../domain/usecases/kyc/upload_kyc_video.dart' as _i197;
import '../domain/usecases/kyc/upload_nominee_details.dart' as _i198;
import '../domain/usecases/kyc/upload_personal_details.dart' as _i199;
import '../domain/usecases/kyc/upload_proof_of_address.dart' as _i200;
import '../domain/usecases/kyc/upload_proof_of_identity.dart' as _i201;
import '../domain/usecases/kyc/upload_selfie.dart' as _i202;
import '../domain/usecases/kyc/verify_bank_account.dart' as _i206;
import '../domain/usecases/kyc/verify_pan.dart' as _i214;
import '../domain/usecases/lamf/get_avail_loan.dart' as _i318;
import '../domain/usecases/lamf/get_cibil_refresh.dart' as _i334;
import '../domain/usecases/lamf/get_credit_limit.dart' as _i335;
import '../domain/usecases/lamf/get_import_loan_data.dart' as _i352;
import '../domain/usecases/lamf/get_import_loans.dart' as _i353;
import '../domain/usecases/lamf/get_initiate_import_loans.dart' as _i354;
import '../domain/usecases/lamf/get_lamf_landing_page.dart' as _i368;
import '../domain/usecases/lamf/get_loan_data.dart' as _i370;
import '../domain/usecases/lamf/get_loan_import_details.dart' as _i372;
import '../domain/usecases/lamf/get_loan_user.dart' as _i373;
import '../domain/usecases/lamf/get_pledged_funds.dart' as _i383;
import '../domain/usecases/lamf/get_transactions.dart' as _i396;
import '../domain/usecases/lamf/initiate_loan_closure.dart' as _i411;
import '../domain/usecases/lamf/initiate_payment.dart' as _i414;
import '../domain/usecases/lamf/initiate_withdrawal.dart' as _i415;
import '../domain/usecases/lamf/loan_closure.dart' as _i129;
import '../domain/usecases/lamf/submit_import_otp.dart' as _i182;
import '../domain/usecases/lamf/update_loan_status.dart' as _i190;
import '../domain/usecases/market_news/get_market_news.dart' as _i375;
import '../domain/usecases/mpin/forgot_mpin_generate_otp.dart' as _i309;
import '../domain/usecases/mpin/forgot_mpin_verify_otp.dart' as _i310;
import '../domain/usecases/mpin/login_with_mpin.dart' as _i434;
import '../domain/usecases/mpin/set_mpin.dart' as _i457;
import '../domain/usecases/mutual_funds/add_to_cart.dart' as _i231;
import '../domain/usecases/mutual_funds/clear_cart_funds.dart' as _i256;
import '../domain/usecases/mutual_funds/create_lumpsum_purchase.dart' as _i274;
import '../domain/usecases/mutual_funds/create_redemption_order.dart' as _i280;
import '../domain/usecases/mutual_funds/create_sip_order.dart' as _i281;
import '../domain/usecases/mutual_funds/create_stp_order.dart' as _i282;
import '../domain/usecases/mutual_funds/create_switch_order.dart' as _i284;
import '../domain/usecases/mutual_funds/create_swp_order.dart' as _i286;
import '../domain/usecases/mutual_funds/edit_cart.dart' as _i302;
import '../domain/usecases/mutual_funds/generate_capital_gains_file.dart'
    as _i313;
import '../domain/usecases/mutual_funds/generate_holdings_report.dart' as _i311;
import '../domain/usecases/mutual_funds/get_active_sips.dart' as _i314;
import '../domain/usecases/mutual_funds/get_cancelled_sips.dart' as _i329;
import '../domain/usecases/mutual_funds/get_capital_gain-report.dart' as _i330;
import '../domain/usecases/mutual_funds/get_cart_lumpsum_funds.dart' as _i332;
import '../domain/usecases/mutual_funds/get_cart_sip_funds.dart' as _i333;
import '../domain/usecases/mutual_funds/get_explore_diy_data.dart' as _i340;
import '../domain/usecases/mutual_funds/get_fp_fund_details.dart' as _i341;
import '../domain/usecases/mutual_funds/get_fund_by_subcategory.dart' as _i345;
import '../domain/usecases/mutual_funds/get_fund_holdings.dart' as _i342;
import '../domain/usecases/mutual_funds/get_funds_by_investment_idea.dart'
    as _i343;
import '../domain/usecases/mutual_funds/get_holding_analysis.dart' as _i351;
import '../domain/usecases/mutual_funds/get_investment_idea_filters.dart'
    as _i355;
import '../domain/usecases/mutual_funds/get_investment_returns.dart' as _i357;
import '../domain/usecases/mutual_funds/get_mf_nav_history.dart' as _i374;
import '../domain/usecases/mutual_funds/get_mf_orders.dart' as _i376;
import '../domain/usecases/mutual_funds/get_mf_transactions.dart' as _i377;
import '../domain/usecases/mutual_funds/get_mutual_fund_by_isin.dart' as _i378;
import '../domain/usecases/mutual_funds/get_mutual_fund_details.dart' as _i379;
import '../domain/usecases/mutual_funds/get_mutual_funds.dart' as _i380;
import '../domain/usecases/mutual_funds/get_sector_allocation.dart' as _i388;
import '../domain/usecases/mutual_funds/get_sip_installments.dart' as _i389;
import '../domain/usecases/mutual_funds/get_stp_funds.dart' as _i391;
import '../domain/usecases/mutual_funds/get_stp_installments.dart' as _i392;
import '../domain/usecases/mutual_funds/get_switch_funds.dart' as _i393;
import '../domain/usecases/mutual_funds/get_swp_installments.dart' as _i394;
import '../domain/usecases/mutual_funds/get_systematic_plans.dart' as _i395;
import '../domain/usecases/mutual_funds/get_user_mf_holdings.dart' as _i401;
import '../domain/usecases/mutual_funds/initiate_cart_lumpsum_purchase.dart'
    as _i409;
import '../domain/usecases/mutual_funds/initiate_cart_sip_purchase.dart'
    as _i410;
import '../domain/usecases/mutual_funds/initiate_lumpsum_purchase.dart'
    as _i412;
import '../domain/usecases/mutual_funds/is_scheme_present.dart' as _i417;
import '../domain/usecases/mutual_funds/remove_fund_from_cart.dart' as _i155;
import '../domain/usecases/mutual_funds/resend_transaction_otp.dart' as _i159;
import '../domain/usecases/mutual_funds/stop_sip_order.dart' as _i177;
import '../domain/usecases/mutual_funds/stop_stp_order.dart' as _i178;
import '../domain/usecases/mutual_funds/stop_swp_order.dart' as _i179;
import '../domain/usecases/mutual_funds/verify_cart_purchase_otp.dart' as _i211;
import '../domain/usecases/mutual_funds/verify_redemption_otp.dart' as _i216;
import '../domain/usecases/mutual_funds/verify_stp_otp.dart' as _i217;
import '../domain/usecases/mutual_funds/verify_switch_otp.dart' as _i218;
import '../domain/usecases/mutual_funds/verify_swp_otp.dart' as _i219;
import '../domain/usecases/neobaskets/create_basket_individual_order.dart'
    as _i260;
import '../domain/usecases/neobaskets/create_basket_lumpsum_order.dart'
    as _i261;
import '../domain/usecases/neobaskets/create_basket_order_consent.dart'
    as _i262;
import '../domain/usecases/neobaskets/create_basket_redeem_order.dart' as _i263;
import '../domain/usecases/neobaskets/create_basket_sip_order.dart' as _i264;
import '../domain/usecases/neobaskets/delete_sip.dart' as _i294;
import '../domain/usecases/neobaskets/get_basket_buy_order.dart' as _i320;
import '../domain/usecases/neobaskets/get_basket_buy_transactions.dart'
    as _i321;
import '../domain/usecases/neobaskets/get_basket_chart_data.dart' as _i322;
import '../domain/usecases/neobaskets/get_basket_details.dart' as _i323;
import '../domain/usecases/neobaskets/get_basket_order_transaction_details.dart'
    as _i324;
import '../domain/usecases/neobaskets/get_basket_portfolio.dart' as _i325;
import '../domain/usecases/neobaskets/get_basket_portfolio_detail.dart'
    as _i326;
import '../domain/usecases/neobaskets/get_basket_sell_order.dart' as _i327;
import '../domain/usecases/neobaskets/get_basket_sell_transactions.dart'
    as _i328;
import '../domain/usecases/neobaskets/get_neobaskets.dart' as _i381;
import '../domain/usecases/neobaskets/verify_basket_lumpsum_consent.dart'
    as _i208;
import '../domain/usecases/neobaskets/verify_basket_redeem_consent.dart'
    as _i209;
import '../domain/usecases/neobaskets/verify_basket_sip_consent.dart' as _i210;
import '../domain/usecases/notifications/get_unread_notification_count.dart'
    as _i397;
import '../domain/usecases/notifications/get_user_notifications.dart' as _i405;
import '../domain/usecases/notifications/mark_all_notifcations_as_read.dart'
    as _i439;
import '../domain/usecases/notifications/mark_notification_as_read.dart'
    as _i440;
import '../domain/usecases/onboarding/generate_mobile_otp.dart' as _i312;
import '../domain/usecases/onboarding/login_with_email.dart' as _i432;
import '../domain/usecases/onboarding/social_login.dart' as _i462;
import '../domain/usecases/onboarding/verify_email_otp.dart' as _i491;
import '../domain/usecases/onboarding/verify_mobile_otp.dart' as _i493;
import '../domain/usecases/retirement_calculator/get_retirement_corpus.dart'
    as _i385;
import '../domain/usecases/retirement_calculator/get_retirement_inflation_calculation.dart'
    as _i386;
import '../domain/usecases/retirement_calculator/get_retirement_OTP.dart'
    as _i384;
import '../domain/usecases/retirement_calculator/get_retirement_passbook.dart'
    as _i387;
import '../domain/usecases/retirement_calculator/submit_retirement_OTP.dart'
    as _i184;
import '../presentation/cubits/account/add_delivery_address_cubit/add_delivery_address_cubit.dart'
    as _i227;
import '../presentation/cubits/account/add_user_bank_cubit/add_user_bank_cubit.dart'
    as _i233;
import '../presentation/cubits/account/create_mandate_cubit/create_mandate_cubit.dart'
    as _i276;
import '../presentation/cubits/account/delete_delivery_address_cubit/delete_delivery_address_cubit.dart'
    as _i292;
import '../presentation/cubits/account/delete_mandate_cubit/delete_mandate_cubit.dart'
    as _i517;
import '../presentation/cubits/account/delivery_address_cubit/delivery_address_cubit.dart'
    as _i518;
import '../presentation/cubits/account/get_kyc_last_route_cubit/get_kyc_last_route_cubit.dart'
    as _i363;
import '../presentation/cubits/account/get_primary_bank_cubit/get_primary_bank_cubit.dart'
    as _i534;
import '../presentation/cubits/account/get_user_switchable_mandates_cubit/get_user_switchable_mandates_cubit.dart'
    as _i407;
import '../presentation/cubits/account/mandate_sips_cubit/mandate_sips_cubit.dart'
    as _i438;
import '../presentation/cubits/account/update_bank_ifsc_cubit/update_bank_ifsc_cubit.dart'
    as _i535;
import '../presentation/cubits/account/update_primary_bank_cubit/update_primary_bank_cubit.dart'
    as _i470;
import '../presentation/cubits/account/update_profile_photo_cubit/update_profile_photo_cubit.dart'
    as _i473;
import '../presentation/cubits/account/user_bank_details_cubit/user_bank_details_cubit.dart'
    as _i486;
import '../presentation/cubits/account/user_mandate_cubit/user_mandate_cubit.dart'
    as _i487;
import '../presentation/cubits/account/verify_delete_mandate_cubit/verify_delete_mandate_cubit.dart'
    as _i490;
import '../presentation/cubits/assisted_service/assisted_orders/assisted_orders_cubit.dart'
    as _i237;
import '../presentation/cubits/assisted_service/assited_holdings_cubit/assisted_holdings_cubit.dart'
    as _i236;
import '../presentation/cubits/assisted_service/get_assisted_service_details_cubit/get_assisted_service_details_cubit.dart'
    as _i59;
import '../presentation/cubits/assisted_service/get_suggested_funds_cubit/get_suggested_funds_cubit.dart'
    as _i104;
import '../presentation/cubits/assisted_service/initiate_suggested_funds_payment_cubit/initiate_suggested_funds_payment_cubit.dart'
    as _i120;
import '../presentation/cubits/assisted_service/invest_suggested_funds_cubit/invest_suggested_funds_cubit.dart'
    as _i122;
import '../presentation/cubits/assisted_service/questions_cubit/questions_cubit.dart'
    as _i152;
import '../presentation/cubits/assisted_service/submit_choices_cubit/submit_choices_cubit.dart'
    as _i181;
import '../presentation/cubits/assisted_service/unlock_assisted_service_cubit/unlock_assisted_service_cubit.dart'
    as _i188;
import '../presentation/cubits/assisted_service/verify_assisted_service_pin/verify_assisted_service_pin_cubit.dart'
    as _i205;
import '../presentation/cubits/authentication/auth/auth_cubit.dart' as _i496;
import '../presentation/cubits/authentication/login_with_apple/login_with_apple_cubit.dart'
    as _i13;
import '../presentation/cubits/authentication/login_with_email/login_with_email_cubit.dart'
    as _i433;
import '../presentation/cubits/authentication/login_with_google/login_with_google_cubit.dart'
    as _i14;
import '../presentation/cubits/authentication/mobile_otp_cubit/mobile_otp_cubit.dart'
    as _i445;
import '../presentation/cubits/authentication/resend_otp_cubit/resend_otp_cubit.dart'
    as _i452;
import '../presentation/cubits/authentication/social_login/social_login_cubit.dart'
    as _i463;
import '../presentation/cubits/authentication/verify_email_otp/verify_email_otp_cubit.dart'
    as _i492;
import '../presentation/cubits/authentication/verify_mobile_otp/verify_mobile_otp_cubit.dart'
    as _i494;
import '../presentation/cubits/basket_redeem_order_verify/basket_redeem_order_verify_cubit.dart'
    as _i241;
import '../presentation/cubits/contact_us/capture_faq_dislike_cubit/capture_faq_dislike_cubit.dart'
    as _i247;
import '../presentation/cubits/contact_us/capture_faq_like_cubit/capture_faq_like_cubit.dart'
    as _i249;
import '../presentation/cubits/contact_us/category_questions/category_questions_cubit.dart'
    as _i250;
import '../presentation/cubits/contact_us/category_questions_detail/category_questions_detail_cubit.dart'
    as _i251;
import '../presentation/cubits/contact_us/contact_us_cubit/contact_us_cubit.dart'
    as _i258;
import '../presentation/cubits/contact_us/contact_us_form_cubit/contact_us_form_cubit.dart'
    as _i259;
import '../presentation/cubits/contact_us/get_dislike_reasons/get_dislike_reasons_cubit.dart'
    as _i339;
import '../presentation/cubits/digital_gold/checkout_delivery_order_cubit/checkout_delivery_order_cubit.dart'
    as _i253;
import '../presentation/cubits/digital_gold/checkout_rates_cubit/get_checkout_rates_cubit.dart'
    as _i69;
import '../presentation/cubits/digital_gold/create_delivery_order_cubit/create_delivery_order_cubit.dart'
    as _i268;
import '../presentation/cubits/digital_gold/create_order_cubit/create_order_cubit.dart'
    as _i279;
import '../presentation/cubits/digital_gold/delivery_product_cubit/delivery_product_cubit.dart'
    as _i298;
import '../presentation/cubits/digital_gold/dg_delivery_transactions_cubit/dg_delivery_transaction_cubit.dart'
    as _i299;
import '../presentation/cubits/digital_gold/dg_transactions_cubit/dg_transaction_cubit.dart'
    as _i300;
import '../presentation/cubits/digital_gold/gold_chart_cubit/gold_chart_cubit.dart'
    as _i113;
import '../presentation/cubits/digital_gold/gold_silver_rates/gold_silver_rates_cubit.dart'
    as _i114;
import '../presentation/cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart'
    as _i115;
import '../presentation/cubits/digital_gold/sell_gold_silver_cubit/sell_gold_silver_cubit.dart'
    as _i167;
import '../presentation/cubits/digital_gold/silver_chart_cubit/silver_chart_cubit.dart'
    as _i170;
import '../presentation/cubits/equity/buy_sell_transaction_cubit.dart' as _i244;
import '../presentation/cubits/equity/equity_explore/all_stocks_cubit.dart'
    as _i235;
import '../presentation/cubits/equity/equity_explore/index_price_banner_cubit.dart'
    as _i117;
import '../presentation/cubits/equity/equity_explore/stock_chart_cubit.dart'
    as _i175;
import '../presentation/cubits/equity/equity_explore/stock_details_cubit.dart'
    as _i176;
import '../presentation/cubits/equity/equity_nav_cubit.dart' as _i9;
import '../presentation/cubits/equity/equity_orders/equity_orders_cubit.dart'
    as _i304;
import '../presentation/cubits/equity/equity_portfolio/portfolio_holdings_cubit.dart'
    as _i144;
import '../presentation/cubits/equity/equity_portfolio/portfolio_holdings_token_cubit.dart'
    as _i145;
import '../presentation/cubits/equity/equity_portfolio/portfolio_positions_cubit.dart'
    as _i146;
import '../presentation/cubits/equity/equity_portfolio/smallcase_funds_cubit.dart'
    as _i171;
import '../presentation/cubits/equity/equity_search/global_search_cubit.dart'
    as _i109;
import '../presentation/cubits/equity/equity_smart_filtering/cubit/fetch_smart_indices_cubit.dart'
    as _i307;
import '../presentation/cubits/equity/equity_smart_filtering/cubit/filter_by_index_cubit.dart'
    as _i308;
import '../presentation/cubits/equity/equity_smart_filtering/cubit/filter_by_sector_industry_cubit.dart'
    as _i51;
import '../presentation/cubits/equity/equity_smart_filtering/cubit/get_sectors_and_industries_cubit.dart'
    as _i92;
import '../presentation/cubits/equity/equity_smart_watchlist/get_alert_details_cubit.dart'
    as _i54;
import '../presentation/cubits/equity/equity_smart_watchlist/get_user_alerts_cubit.dart'
    as _i399;
import '../presentation/cubits/equity/equity_smart_watchlist/remove_alert_cubit.dart'
    as _i154;
import '../presentation/cubits/equity/equity_smart_watchlist/set_alert_cubit.dart'
    as _i169;
import '../presentation/cubits/equity/equity_smart_watchlist/smart_watchlist_holdings_cubit.dart'
    as _i173;
import '../presentation/cubits/equity/equity_smart_watchlist/smart_watchlist_search_cubit.dart'
    as _i174;
import '../presentation/cubits/equity/equity_watchlist/add_stock_watchlist_cubit.dart'
    as _i230;
import '../presentation/cubits/equity/equity_watchlist/create_watchlist_cubit.dart'
    as _i289;
import '../presentation/cubits/equity/equity_watchlist/get_all_user_watchlis_cubit.dart'
    as _i317;
import '../presentation/cubits/equity/equity_watchlist/remove_symbol_watchlist_cubit.dart'
    as _i450;
import '../presentation/cubits/equity/equity_watchlist/remove_watchlist_cubit.dart'
    as _i157;
import '../presentation/cubits/equity/equity_watchlist/watchlist_symbol_cubit.dart'
    as _i221;
import '../presentation/cubits/equity/etf_fund_houses_cubit.dart' as _i305;
import '../presentation/cubits/equity/etf_stocks_cubit.dart' as _i306;
import '../presentation/cubits/equity/login/get_all_brokers_cubit.dart'
    as _i315;
import '../presentation/cubits/equity/login/smallcase_login_cubit.dart'
    as _i172;
import '../presentation/cubits/equity/login/transactionid_cubit.dart' as _i186;
import '../presentation/cubits/equity/smart_filter_subsidiaries/cubit/get_business_houses_cubit.dart'
    as _i64;
import '../presentation/cubits/equity/smart_filter_subsidiaries/cubit/get_subsidiaries_cubit.dart'
    as _i102;
import '../presentation/cubits/goal_planning/create_goal_investements_cubit.dart'
    as _i515;
import '../presentation/cubits/goal_planning/create_user_goals_cubit.dart'
    as _i288;
import '../presentation/cubits/goal_planning/get_goal_details_cubit.dart'
    as _i531;
import '../presentation/cubits/goal_planning/get_goal_planning_dashboard_data_cubit.dart'
    as _i347;
import '../presentation/cubits/goal_planning/get_goals_core_data_cubit.dart'
    as _i349;
import '../presentation/cubits/import_external_fund/account_details/account_details_cubit.dart'
    as _i222;
import '../presentation/cubits/import_external_fund/broker_holdings_fund/broker_holdings_fund_cubit.dart'
    as _i243;
import '../presentation/cubits/import_external_fund/import_holding_data/import_holding_data_cubit.dart'
    as _i116;
import '../presentation/cubits/import_external_fund/portfolio_analysis/portfolio_analysis_cubit.dart'
    as _i143;
import '../presentation/cubits/import_external_fund/transaction/transaction_cubit.dart'
    as _i468;
import '../presentation/cubits/lamf/get_initiate_import_loans/get_initiate_import_loans_cubit.dart'
    as _i532;
import '../presentation/cubits/lamf/get_lamf_landing_page/get_lamf_landing_page_cubit.dart'
    as _i369;
import '../presentation/cubits/lamf/get_loan_data/get_loan_data_cubit.dart'
    as _i371;
import '../presentation/cubits/lamf/lamf_avail_loans/lamf_avail_loan_cubit.dart'
    as _i420;
import '../presentation/cubits/lamf/lamf_get_credit_limit/lamf_get_credit_limit_cubit.dart'
    as _i421;
import '../presentation/cubits/lamf/lamf_get_loan_data/lamf_get_loan_data_cubit.dart'
    as _i422;
import '../presentation/cubits/lamf/lamf_get_transactions/lamf_get_transactions_cubit.dart'
    as _i423;
import '../presentation/cubits/lamf/lamf_get_user/lamf_get_user_cubit.dart'
    as _i424;
import '../presentation/cubits/lamf/lamf_import_loans/lamf_import_loans_cubit.dart'
    as _i425;
import '../presentation/cubits/lamf/lamf_initiate_payment/lamf_initiate_payment_cubit.dart'
    as _i426;
import '../presentation/cubits/lamf/lamf_initiate_withdrawl/lamf_initiate_withdrawal_cubit.dart'
    as _i427;
import '../presentation/cubits/lamf/lamf_loan_closure/lamf_loan_closure_cubit.dart'
    as _i428;
import '../presentation/cubits/lamf/lamf_pledged_funds/lamf_pledged_funds_cubit.dart'
    as _i429;
import '../presentation/cubits/lamf/lamf_update_loan_status/lamf_update_loan_status_cubit.dart'
    as _i430;
import '../presentation/cubits/lamf/loan_import_details/loan_import_details_cubit.dart'
    as _i431;
import '../presentation/cubits/lamf/submit_import_otp/submit_import_otp_cubit.dart'
    as _i183;
import '../presentation/cubits/market_news/market_news_cubit.dart' as _i441;
import '../presentation/cubits/mpin/forgot_mpin/forgot_mpin_cubit.dart'
    as _i521;
import '../presentation/cubits/mpin/mpin_login/mpin_login_cubit.dart' as _i437;
import '../presentation/cubits/mpin/set_mpin/set_mpin_cubit.dart' as _i458;
import '../presentation/cubits/mutual_funds/add_to_cart/add_to_cart_cubit.dart'
    as _i232;
import '../presentation/cubits/mutual_funds/all_funds/all_funds_cubit.dart'
    as _i495;
import '../presentation/cubits/mutual_funds/cancel_systematic_plan/cancel_systematic_plan_cubit.dart'
    as _i245;
import '../presentation/cubits/mutual_funds/Capital_gain_report/generate_capital_gains_file_cubit.dart'
    as _i525;
import '../presentation/cubits/mutual_funds/Capital_gain_report/get_capital_gain_report_cubit.dart'
    as _i331;
import '../presentation/cubits/mutual_funds/cart_lumpsum_purchase/cart_lumpsum_purchase_cubit.dart'
    as _i511;
import '../presentation/cubits/mutual_funds/cart_sip_purchase/cart_sip_purchase_cubit.dart'
    as _i512;
import '../presentation/cubits/mutual_funds/clear_cart/clear_cart_cubit.dart'
    as _i513;
import '../presentation/cubits/mutual_funds/create_consent/create_consent_cubit.dart'
    as _i265;
import '../presentation/cubits/mutual_funds/edit_cart/edit_cart_cubit.dart'
    as _i303;
import '../presentation/cubits/mutual_funds/explore_fund/explore_diy_data_cubit.dart'
    as _i520;
import '../presentation/cubits/mutual_funds/filter_sort/filter_sort_cubit.dart'
    as _i10;
import '../presentation/cubits/mutual_funds/fp_fund_details/fp_fund_details_cubit.dart'
    as _i522;
import '../presentation/cubits/mutual_funds/fund_details/fund_details_cubit.dart'
    as _i523;
import '../presentation/cubits/mutual_funds/fund_holdings/fund_holdings_cubit.dart'
    as _i524;
import '../presentation/cubits/mutual_funds/get_fund/get_fund_cubit.dart'
    as _i530;
import '../presentation/cubits/mutual_funds/get_fund_by_isin/get_fund_by_isin_cubit.dart'
    as _i528;
import '../presentation/cubits/mutual_funds/get_fund_by_subcategory/get_funds_by_subcategory_cubit.dart'
    as _i529;
import '../presentation/cubits/mutual_funds/get_funds_by_investment_idea/get_funds_by_investment_idea_cubit.dart'
    as _i344;
import '../presentation/cubits/mutual_funds/get_investment_idea_filters/get_investment_idea_filters_cubit.dart'
    as _i356;
import '../presentation/cubits/mutual_funds/holding_analysis/holding_analysis_cubit.dart'
    as _i408;
import '../presentation/cubits/mutual_funds/investment_returns/investment_returns_cubit.dart'
    as _i416;
import '../presentation/cubits/mutual_funds/is_scheme_present/is_scheme_present_cubit.dart'
    as _i418;
import '../presentation/cubits/mutual_funds/lumpsum_cart/lumpsum_cart_cubit.dart'
    as _i435;
import '../presentation/cubits/mutual_funds/lumpsum_purchase/create_lumpsum_purchase_cubit.dart'
    as _i275;
import '../presentation/cubits/mutual_funds/lumpsum_purchase/initiate_lumpsum_purchase_cubit.dart'
    as _i413;
import '../presentation/cubits/mutual_funds/mandate_token_cubit/authorise_mandate_cubit.dart'
    as _i239;
import '../presentation/cubits/mutual_funds/mf_chart/mf_chart_cubit.dart'
    as _i436;
import '../presentation/cubits/mutual_funds/mf_orders/mf_orders_cubit.dart'
    as _i442;
import '../presentation/cubits/mutual_funds/mf_orders_filter_sort/mf_orders_filter_sort_cubit.dart'
    as _i16;
import '../presentation/cubits/mutual_funds/mf_sort_by_switch/mf_sort_by_switch_cubit.dart'
    as _i18;
import '../presentation/cubits/mutual_funds/mf_transactions/mf_transactions_cubit.dart'
    as _i443;
import '../presentation/cubits/mutual_funds/mf_user_holdings/mf_user_holdings_cubit.dart'
    as _i444;
import '../presentation/cubits/mutual_funds/popular_funds/popular_funds_cubit.dart'
    as _i24;
import '../presentation/cubits/mutual_funds/redeem/create_redeem_order/create_redeem_order_cubit.dart'
    as _i516;
import '../presentation/cubits/mutual_funds/report/report_cubit.dart' as _i451;
import '../presentation/cubits/mutual_funds/resend_transaction_otp/resend_transaction_otp_cubit.dart'
    as _i160;
import '../presentation/cubits/mutual_funds/returns_switch/mf_returns_switch_cubit.dart'
    as _i17;
import '../presentation/cubits/mutual_funds/search_funds/search_fund_cubit.dart'
    as _i456;
import '../presentation/cubits/mutual_funds/sip_cart/sip_cart_cubit.dart'
    as _i460;
import '../presentation/cubits/mutual_funds/sip_order/sip_order_cubit.dart'
    as _i461;
import '../presentation/cubits/mutual_funds/stp/create_stp_order/create_stp_order_cubit.dart'
    as _i283;
import '../presentation/cubits/mutual_funds/stp/stp_funds_list/stp_funds_list_cubit.dart'
    as _i464;
import '../presentation/cubits/mutual_funds/switch/create_switch_order/create_switch_order_cubit.dart'
    as _i285;
import '../presentation/cubits/mutual_funds/switch/switch_funds_list_cubit.dart'
    as _i465;
import '../presentation/cubits/mutual_funds/swp/create_swp_order/create_swp_order_cubit.dart'
    as _i287;
import '../presentation/cubits/mutual_funds/systematic_plan_installments/systematic_plan_installments_cubit.dart'
    as _i466;
import '../presentation/cubits/mutual_funds/systematic_plans/systematic_plans_cubit.dart'
    as _i467;
import '../presentation/cubits/mutual_funds/verify_cart_purchase_otp/verify_cart_purchase_otp_cubit.dart'
    as _i212;
import '../presentation/cubits/mutual_funds/verify_consent/verify_consent_cubit.dart'
    as _i213;
import '../presentation/cubits/mutual_funds/verify_transaction_otp/verify_transaction_otp_cubit.dart'
    as _i220;
import '../presentation/cubits/neo_card/discovery/discovery_animation_cubit.dart'
    as _i7;
import '../presentation/cubits/neobaskets/basket_buy_order/basket_buy_order_cubit.dart'
    as _i497;
import '../presentation/cubits/neobaskets/basket_buy_transactions/basket_buy_transactions_cubit.dart'
    as _i498;
import '../presentation/cubits/neobaskets/basket_chart/basket_chart_cubit.dart'
    as _i499;
import '../presentation/cubits/neobaskets/basket_individual_redeem_order/basket_individual_redeem_order_cubit.dart'
    as _i501;
import '../presentation/cubits/neobaskets/basket_lumpsum_order/basket_lumpsum_order_cubit.dart'
    as _i502;
import '../presentation/cubits/neobaskets/basket_lumpsum_order_verify/basket_lumpsum_order_verify_cubit.dart'
    as _i240;
import '../presentation/cubits/neobaskets/basket_order_consent/basket_order_consent_cubit.dart'
    as _i503;
import '../presentation/cubits/neobaskets/basket_order_details/basket_order_details_cubit.dart'
    as _i504;
import '../presentation/cubits/neobaskets/basket_portfolio/basket_portfolio_cubit.dart'
    as _i505;
import '../presentation/cubits/neobaskets/basket_portfolio_detail/basket_portfolio_detail_cubit.dart'
    as _i506;
import '../presentation/cubits/neobaskets/basket_redeem_order/basket_redeem_order_cubit.dart'
    as _i507;
import '../presentation/cubits/neobaskets/basket_sell_order/basket_sell_order_cubit.dart'
    as _i508;
import '../presentation/cubits/neobaskets/basket_sell_transactions/basket_sell_transactions_cubit.dart'
    as _i509;
import '../presentation/cubits/neobaskets/basket_sip_order/basket_sip_order_cubit.dart'
    as _i510;
import '../presentation/cubits/neobaskets/basket_sip_order_verify/basket_sip_order_verify_cubit.dart'
    as _i242;
import '../presentation/cubits/neobaskets/delete_sip/delete_sip_cubit.dart'
    as _i295;
import '../presentation/cubits/neobaskets/neobasket_discovery_details/basket_details_cubit.dart'
    as _i500;
import '../presentation/cubits/neobaskets/neobaskets_discovery/neobasket_discovery_cubit.dart'
    as _i446;
import '../presentation/cubits/notifications/notification_action_cubit/notification_action_cubit.dart'
    as _i448;
import '../presentation/cubits/notifications/notification_count_cubit/notification_count_cubit.dart'
    as _i449;
import '../presentation/cubits/notifications/user_notification_cubit.dart'
    as _i488;
import '../presentation/cubits/onboarding/cheque_ocr_read/cheque_ocr_read_cubit.dart'
    as _i255;
import '../presentation/cubits/onboarding/confirm_pan/confirm_pan_cubit.dart'
    as _i514;
import '../presentation/cubits/onboarding/create_kyc_request/create_kyc_request_cubit.dart'
    as _i5;
import '../presentation/cubits/onboarding/e_sign_cubit/e_sign_cubit.dart'
    as _i519;
import '../presentation/cubits/onboarding/get_bank_by_ifsc/get_bank_by_ifsc_cubit.dart'
    as _i527;
import '../presentation/cubits/onboarding/get_data_from_pincode/get_pincode_data_cubit.dart'
    as _i533;
import '../presentation/cubits/onboarding/get_decentro_address/get_decentro_address_cubit.dart'
    as _i337;
import '../presentation/cubits/onboarding/get_kyc_video_otp/get_kyc_video_otp_cubit.dart'
    as _i367;
import '../presentation/cubits/onboarding/kyc_create_account/kyc_create_account_cubit.dart'
    as _i419;
import '../presentation/cubits/onboarding/non_kyc_create_account/non_kyc_create_account_cubit.dart'
    as _i447;
import '../presentation/cubits/onboarding/onboarding_page_cubit.dart' as _i23;
import '../presentation/cubits/onboarding/retake_kyc/retake_kyc_cubit.dart'
    as _i162;
import '../presentation/cubits/onboarding/upload_address_details/upload_address_details_cubit.dart'
    as _i475;
import '../presentation/cubits/onboarding/upload_adhaar_number/upload_adhaar_number_cubit.dart'
    as _i474;
import '../presentation/cubits/onboarding/upload_bank_details/upload_bank_details_cubit.dart'
    as _i476;
import '../presentation/cubits/onboarding/upload_bank_details/upload_cheque_cubit.dart'
    as _i477;
import '../presentation/cubits/onboarding/upload_digital_signature/upload_digital_signature_cubit.dart'
    as _i478;
import '../presentation/cubits/onboarding/upload_fatca_details/upload_fatca_details_cubit.dart'
    as _i479;
import '../presentation/cubits/onboarding/upload_kyc_video/upload_kyc_video_cubit.dart'
    as _i480;
import '../presentation/cubits/onboarding/upload_nominee_details/upload_nominee_details_cubit.dart'
    as _i481;
import '../presentation/cubits/onboarding/upload_personal_details/upload_personal_details_cubit.dart'
    as _i482;
import '../presentation/cubits/onboarding/upload_proof_of_address/upload_proof_of_address_cubit.dart'
    as _i483;
import '../presentation/cubits/onboarding/upload_proof_of_identity/upload_proof_of_identity_cubit.dart'
    as _i484;
import '../presentation/cubits/onboarding/upload_selfie/upload_selfie_cubit.dart'
    as _i485;
import '../presentation/cubits/onboarding/verify_bank_account/verify_bank_account_cubit.dart'
    as _i207;
import '../presentation/cubits/onboarding/verify_pan/verify_pan_cubit.dart'
    as _i215;
import '../presentation/cubits/retirement_calculator/generate_retirement_otp_cubit.dart'
    as _i526;
import '../presentation/cubits/retirement_calculator/retirement_corpus_cubit.dart'
    as _i453;
import '../presentation/cubits/retirement_calculator/retirement_inflation_calculator_cubit.dart'
    as _i454;
import '../presentation/cubits/retirement_calculator/retirement_passbook_cubit.dart'
    as _i455;
import '../presentation/cubits/retirement_calculator/submit_retirement_otp_cubit.dart'
    as _i185;
import '../presentation/cubits/util_cubits/loading_cubit.dart' as _i12;
import '../presentation/cubits/util_cubits/nav_cubit.dart' as _i20;
import '../presentation/cubits/util_cubits/network/network_cubit.dart' as _i21;
import '../presentation/cubits/util_cubits/ocr_read_cubit.dart' as _i22;
import '../presentation/cubits/util_cubits/post_payment_cubit/post_payment_cubit.dart'
    as _i149;
import '../presentation/routes/route_generator.dart' as _i25;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final injectionModule = _$InjectionModule();
  gh.lazySingleton<_i3.AccountLocalDataSource>(
      () => _i3.AccountLocalDataSourceImpl());
  gh.lazySingleton<_i4.Connectivity>(() => injectionModule.connectivity());
  gh.factory<_i5.CreateKycRequestCubit>(() => _i5.CreateKycRequestCubit());
  gh.lazySingleton<_i6.DigitalGoldLocalDataSource>(
      () => _i6.DigitalGoldLocalDataSourceImpl());
  gh.factory<_i7.DiscoveryAnimationCubit>(() => _i7.DiscoveryAnimationCubit());
  gh.lazySingleton<_i8.DropdownLocalDataSource>(
      () => _i8.DropdownLocalDataSourceImpl());
  gh.factory<_i9.EquityNavCubit>(() => _i9.EquityNavCubit());
  gh.factory<_i10.FilterSortCubit>(() => _i10.FilterSortCubit());
  gh.lazySingleton<_i11.KycLocalDataSource>(
      () => _i11.KycLocalDataSourceImpl());
  gh.lazySingleton<_i12.LoadingCubit>(() => _i12.LoadingCubit());
  gh.factory<_i13.LoginWithAppleCubit>(() => _i13.LoginWithAppleCubit());
  gh.factory<_i14.LoginWithGoogleCubit>(() => _i14.LoginWithGoogleCubit());
  gh.factory<_i15.LogoutUser>(() => _i15.LogoutUser());
  gh.factory<_i16.MfOrdersFilterSortCubit>(
      () => _i16.MfOrdersFilterSortCubit());
  gh.factory<_i17.MfReturnsSwitchCubit>(() => _i17.MfReturnsSwitchCubit());
  gh.factory<_i18.MfSortBySwitchCubit>(() => _i18.MfSortBySwitchCubit());
  gh.lazySingleton<_i19.MutualFundLocalDataSource>(
      () => _i19.MutualFundLocalDataSourceImpl());
  gh.factory<_i20.NavCubit>(() => _i20.NavCubit());
  gh.lazySingleton<_i21.NetworkCubit>(
      () => _i21.NetworkCubit(gh<_i4.Connectivity>()));
  gh.factory<_i22.OcrReadCubit>(() => _i22.OcrReadCubit());
  gh.lazySingleton<_i23.OnboardingPageCubit>(() => _i23.OnboardingPageCubit());
  gh.factory<_i24.PopularFundsCubit>(() => _i24.PopularFundsCubit());
  gh.lazySingleton<_i25.RouteGenerator>(() => _i25.RouteGenerator());
  gh.factory<String>(
    () => injectionModule.baseUrl,
    instanceName: 'baseUrl',
  );
  gh.lazySingleton<_i26.TokenLocalDataSource>(
      () => _i26.TokenLocalDataSourceImpl());
  gh.lazySingleton<_i27.TokenRepository>(
      () => _i28.TokenRepositoryImpl(gh<_i26.TokenLocalDataSource>()));
  gh.lazySingleton<_i29.Dio>(
      () => injectionModule.dio(gh<String>(instanceName: 'baseUrl')));
  gh.lazySingleton<_i30.TokenService>(() => _i30.TokenService(
        gh<_i29.Dio>(),
        gh<_i27.TokenRepository>(),
      ));
  gh.lazySingleton<_i31.ApiClient>(() => _i31.ApiClient(
        gh<_i29.Dio>(),
        gh<_i30.TokenService>(),
      ));
  gh.lazySingleton<_i32.AssistedServiceRemoteDataSource>(
      () => _i32.AssistedServiceRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i33.AssistedServiceRepository>(() =>
      _i34.AssistedServiceRepositoryImpl(
          gh<_i32.AssistedServiceRemoteDataSource>()));
  gh.lazySingleton<_i35.ContactUsRemoteDataSource>(
      () => _i35.ContactUsRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i36.ContactUsRepository>(
      () => _i37.ContactUsRepositoryImpl(gh<_i35.ContactUsRemoteDataSource>()));
  gh.lazySingleton<_i38.DigitalGoldRemoteDataSource>(
      () => _i38.DigitalGoldRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i39.DigitalGoldRepository>(() =>
      _i40.DigitalGoldRepositoryImpl(gh<_i38.DigitalGoldRemoteDataSource>()));
  gh.lazySingleton<_i41.DropdownRemoteDataSource>(
      () => _i41.DropdownRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i42.DropdownRepository>(
      () => _i43.DropdownRepositoryImpl(gh<_i41.DropdownRemoteDataSource>()));
  gh.lazySingleton<_i44.EquityRemoteDataSource>(
      () => _i44.EquityRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i45.EquityRespository>(
      () => _i46.EquityRespositoryImpl(gh<_i44.EquityRemoteDataSource>()));
  gh.lazySingleton<_i47.ExternalFundRemoteDataSource>(
      () => _i47.ExternalFundRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i48.ExternalFundRepository>(() =>
      _i49.ExternalFundRepositoryImpl(gh<_i47.ExternalFundRemoteDataSource>()));
  gh.factory<_i50.FilterBySectorIndustry>(
      () => _i50.FilterBySectorIndustry(gh<_i45.EquityRespository>()));
  gh.factory<_i51.FilterBySectorIndustryCubit>(() =>
      _i51.FilterBySectorIndustryCubit(gh<_i50.FilterBySectorIndustry>()));
  gh.factory<_i52.GetAccountDetails>(
      () => _i52.GetAccountDetails(gh<_i48.ExternalFundRepository>()));
  gh.factory<_i53.GetAlertDetails>(
      () => _i53.GetAlertDetails(gh<_i45.EquityRespository>()));
  gh.factory<_i54.GetAlertDetailsCubit>(
      () => _i54.GetAlertDetailsCubit(gh<_i53.GetAlertDetails>()));
  gh.factory<_i55.GetAllCountries>(
      () => _i55.GetAllCountries(gh<_i42.DropdownRepository>()));
  gh.factory<_i56.GetAssistedHoldings>(
      () => _i56.GetAssistedHoldings(gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i57.GetAssistedOrders>(
      () => _i57.GetAssistedOrders(gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i58.GetAssistedServiceDetails>(() =>
      _i58.GetAssistedServiceDetails(gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i59.GetAssistedServiceDetailsCubit>(() =>
      _i59.GetAssistedServiceDetailsCubit(
          gh<_i58.GetAssistedServiceDetails>()));
  gh.factory<_i60.GetAssistedSwitchFunds>(
      () => _i60.GetAssistedSwitchFunds(gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i61.GetBrokerHoldings>(
      () => _i61.GetBrokerHoldings(gh<_i48.ExternalFundRepository>()));
  gh.factory<_i62.GetBrokers>(
      () => _i62.GetBrokers(gh<_i45.EquityRespository>()));
  gh.factory<_i63.GetBusinessHouses>(
      () => _i63.GetBusinessHouses(gh<_i45.EquityRespository>()));
  gh.factory<_i64.GetBusinessHousesCubit>(
      () => _i64.GetBusinessHousesCubit(gh<_i63.GetBusinessHouses>()));
  gh.factory<_i65.GetBuySellTrasaction>(
      () => _i65.GetBuySellTrasaction(gh<_i45.EquityRespository>()));
  gh.factory<_i66.GetCategoryQuestionDetail>(
      () => _i66.GetCategoryQuestionDetail(gh<_i36.ContactUsRepository>()));
  gh.factory<_i67.GetCategoryQuestionsList>(
      () => _i67.GetCategoryQuestionsList(gh<_i36.ContactUsRepository>()));
  gh.factory<_i68.GetCheckoutRates>(
      () => _i68.GetCheckoutRates(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i69.GetCheckoutRatesCubit>(
      () => _i69.GetCheckoutRatesCubit(gh<_i68.GetCheckoutRates>()));
  gh.factory<_i70.GetContactUsCategoriesList>(
      () => _i70.GetContactUsCategoriesList(gh<_i36.ContactUsRepository>()));
  gh.factory<_i71.GetCreateWatchlist>(
      () => _i71.GetCreateWatchlist(gh<_i45.EquityRespository>()));
  gh.factory<_i72.GetDeliveryProducts>(
      () => _i72.GetDeliveryProducts(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i73.GetDgDeliveryTransactions>(
      () => _i73.GetDgDeliveryTransactions(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i74.GetDgTransactions>(
      () => _i74.GetDgTransactions(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i75.GetDigitalGoldGraph>(
      () => _i75.GetDigitalGoldGraph(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i76.GetDislikeReasonsList>(
      () => _i76.GetDislikeReasonsList(gh<_i36.ContactUsRepository>()));
  gh.factory<_i77.GetETFFundHouses>(
      () => _i77.GetETFFundHouses(gh<_i45.EquityRespository>()));
  gh.factory<_i78.GetETFList>(
      () => _i78.GetETFList(gh<_i45.EquityRespository>()));
  gh.factory<_i79.GetEquityHoldingsToken>(
      () => _i79.GetEquityHoldingsToken(gh<_i45.EquityRespository>()));
  gh.factory<_i80.GetEquityholdings>(
      () => _i80.GetEquityholdings(gh<_i45.EquityRespository>()));
  gh.factory<_i81.GetExploreStockChart>(
      () => _i81.GetExploreStockChart(gh<_i45.EquityRespository>()));
  gh.factory<_i82.GetGobalSearch>(
      () => _i82.GetGobalSearch(gh<_i45.EquityRespository>()));
  gh.factory<_i83.GetGoldSilverRates>(
      () => _i83.GetGoldSilverRates(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i84.GetGoldUser>(
      () => _i84.GetGoldUser(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i85.GetHoldingData>(
      () => _i85.GetHoldingData(gh<_i48.ExternalFundRepository>()));
  gh.factory<_i86.GetIndexPrice>(
      () => _i86.GetIndexPrice(gh<_i45.EquityRespository>()));
  gh.factory<_i87.GetOrders>(
      () => _i87.GetOrders(gh<_i45.EquityRespository>()));
  gh.factory<_i88.GetPortfolioAnalysis>(
      () => _i88.GetPortfolioAnalysis(gh<_i48.ExternalFundRepository>()));
  gh.factory<_i89.GetPositions>(
      () => _i89.GetPositions(gh<_i45.EquityRespository>()));
  gh.factory<_i90.GetQuestions>(
      () => _i90.GetQuestions(gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i91.GetSectorAndIndustries>(
      () => _i91.GetSectorAndIndustries(gh<_i45.EquityRespository>()));
  gh.factory<_i92.GetSectorsAndIndustriesCubit>(() =>
      _i92.GetSectorsAndIndustriesCubit(gh<_i91.GetSectorAndIndustries>()));
  gh.factory<_i93.GetSmallcaseFunds>(
      () => _i93.GetSmallcaseFunds(gh<_i45.EquityRespository>()));
  gh.factory<_i94.GetSmallcaseLogin>(
      () => _i94.GetSmallcaseLogin(gh<_i45.EquityRespository>()));
  gh.factory<_i95.GetSmartIndices>(
      () => _i95.GetSmartIndices(gh<_i45.EquityRespository>()));
  gh.factory<_i96.GetSmartWatchlistHoldings>(
      () => _i96.GetSmartWatchlistHoldings(gh<_i45.EquityRespository>()));
  gh.factory<_i97.GetSmartWatchlistSearch>(
      () => _i97.GetSmartWatchlistSearch(gh<_i45.EquityRespository>()));
  gh.factory<_i98.GetStockDetail>(
      () => _i98.GetStockDetail(gh<_i45.EquityRespository>()));
  gh.factory<_i99.GetStocksByIndex>(
      () => _i99.GetStocksByIndex(gh<_i45.EquityRespository>()));
  gh.factory<_i100.GetStocksList>(
      () => _i100.GetStocksList(gh<_i45.EquityRespository>()));
  gh.factory<_i101.GetSubsidiaries>(
      () => _i101.GetSubsidiaries(gh<_i45.EquityRespository>()));
  gh.factory<_i102.GetSubsidiariesCubit>(
      () => _i102.GetSubsidiariesCubit(gh<_i101.GetSubsidiaries>()));
  gh.factory<_i103.GetSuggestedFunds>(
      () => _i103.GetSuggestedFunds(gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i104.GetSuggestedFundsCubit>(
      () => _i104.GetSuggestedFundsCubit(gh<_i103.GetSuggestedFunds>()));
  gh.factory<_i105.GetTransactionId>(
      () => _i105.GetTransactionId(gh<_i45.EquityRespository>()));
  gh.factory<_i106.GetUserAllWatchlist>(
      () => _i106.GetUserAllWatchlist(gh<_i45.EquityRespository>()));
  gh.factory<_i107.GetUsersAlerts>(
      () => _i107.GetUsersAlerts(gh<_i45.EquityRespository>()));
  gh.factory<_i108.GetWatchlistSymbol>(
      () => _i108.GetWatchlistSymbol(gh<_i45.EquityRespository>()));
  gh.factory<_i109.GlobalSearchCubit>(
      () => _i109.GlobalSearchCubit(gh<_i82.GetGobalSearch>()));
  gh.lazySingleton<_i110.GoalPlanningRemoteDataSource>(
      () => _i110.GoalPlanningRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i111.GoalPlanningRepository>(() =>
      _i112.GoalPlanningRepositoryImpl(
          gh<_i110.GoalPlanningRemoteDataSource>()));
  gh.factory<_i113.GoldChartCubit>(
      () => _i113.GoldChartCubit(gh<_i75.GetDigitalGoldGraph>()));
  gh.factory<_i114.GoldSilverRatesCubit>(
      () => _i114.GoldSilverRatesCubit(gh<_i83.GetGoldSilverRates>()));
  gh.factory<_i115.GoldUserCubit>(
      () => _i115.GoldUserCubit(gh<_i84.GetGoldUser>()));
  gh.factory<_i116.ImportHoldingDataCubit>(
      () => _i116.ImportHoldingDataCubit(gh<_i85.GetHoldingData>()));
  gh.factory<_i117.IndexPriceBannerCubit>(
      () => _i117.IndexPriceBannerCubit(gh<_i86.GetIndexPrice>()));
  gh.factory<_i118.InitialiseTransaction>(
      () => _i118.InitialiseTransaction(gh<_i48.ExternalFundRepository>()));
  gh.factory<_i119.InitiateSuggestedFundsPayment>(() =>
      _i119.InitiateSuggestedFundsPayment(
          gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i120.InitiateSuggestedFundsPaymentCubit>(
      () => _i120.InitiateSuggestedFundsPaymentCubit(
            gh<_i119.InitiateSuggestedFundsPayment>(),
            gh<_i12.LoadingCubit>(),
          ));
  gh.factory<_i121.InvestSuggestedFunds>(
      () => _i121.InvestSuggestedFunds(gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i122.InvestSuggestedFundsCubit>(
      () => _i122.InvestSuggestedFundsCubit(
            gh<_i121.InvestSuggestedFunds>(),
            gh<_i12.LoadingCubit>(),
          ));
  gh.lazySingleton<_i123.KycRemoteDataSource>(
      () => _i123.KycRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i124.KycRepository>(
      () => _i125.KycRepositoryImpl(gh<_i123.KycRemoteDataSource>()));
  gh.lazySingleton<_i126.LAMFRemoteDataSource>(
      () => _i126.LAMFRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i127.LAMFRepository>(
      () => _i128.LAMFRepositoryImpl(gh<_i126.LAMFRemoteDataSource>()));
  gh.factory<_i129.LoanClosure>(
      () => _i129.LoanClosure(gh<_i127.LAMFRepository>()));
  gh.lazySingleton<_i130.MarketNewsRemoteDataSource>(
      () => _i130.MarketNewsRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i131.MarketNewsRepository>(() =>
      _i132.MarketNewsRepositoryImpl(gh<_i130.MarketNewsRemoteDataSource>()));
  gh.lazySingleton<_i133.MutualFundRemoteDataSource>(
      () => _i133.MutualFundRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i134.MutualFundRepository>(() =>
      _i135.MutualFundRepositoryImpl(gh<_i133.MutualFundRemoteDataSource>()));
  gh.lazySingleton<_i136.NeoBasketRemoteDataSource>(
      () => _i136.NeoBasketRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i137.NeobasketsRepository>(() =>
      _i138.NeoBasketRepositoryImpl(gh<_i136.NeoBasketRemoteDataSource>()));
  gh.lazySingleton<_i139.NotificationRemoteDataSource>(
      () => _i139.NotificationRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i140.NotificationRepository>(() =>
      _i141.NotificationRepositoryImpl(
          gh<_i139.NotificationRemoteDataSource>()));
  gh.factory<_i142.OcrRead>(() => _i142.OcrRead(gh<_i124.KycRepository>()));
  gh.factory<_i143.PortfolioAnalysisCubit>(
      () => _i143.PortfolioAnalysisCubit(gh<_i88.GetPortfolioAnalysis>()));
  gh.factory<_i144.PortfolioHoldingsCubit>(
      () => _i144.PortfolioHoldingsCubit(gh<_i80.GetEquityholdings>()));
  gh.factory<_i145.PortfolioHoldingsTokenCubit>(() =>
      _i145.PortfolioHoldingsTokenCubit(gh<_i79.GetEquityHoldingsToken>()));
  gh.factory<_i146.PortfolioPositionsCubit>(
      () => _i146.PortfolioPositionsCubit(gh<_i89.GetPositions>()));
  gh.factory<_i147.PostDigitalGoldPayment>(
      () => _i147.PostDigitalGoldPayment(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i148.PostPaymentAssistedService>(() =>
      _i148.PostPaymentAssistedService(gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i149.PostPaymentCubit>(() => _i149.PostPaymentCubit(
        gh<_i147.PostDigitalGoldPayment>(),
        gh<_i148.PostPaymentAssistedService>(),
      ));
  gh.factory<_i150.PostSupportEmail>(
      () => _i150.PostSupportEmail(gh<_i36.ContactUsRepository>()));
  gh.factory<_i151.PutStockToWatchlist>(
      () => _i151.PutStockToWatchlist(gh<_i45.EquityRespository>()));
  gh.factory<_i152.QuestionsCubit>(
      () => _i152.QuestionsCubit(gh<_i90.GetQuestions>()));
  gh.factory<_i153.RemoveAlert>(
      () => _i153.RemoveAlert(gh<_i45.EquityRespository>()));
  gh.factory<_i154.RemoveAlertCubit>(
      () => _i154.RemoveAlertCubit(gh<_i153.RemoveAlert>()));
  gh.factory<_i155.RemoveFundFromCart>(
      () => _i155.RemoveFundFromCart(gh<_i134.MutualFundRepository>()));
  gh.factory<_i156.RemoveWatchlist>(
      () => _i156.RemoveWatchlist(gh<_i45.EquityRespository>()));
  gh.factory<_i157.RemoveWatchlistCubit>(
      () => _i157.RemoveWatchlistCubit(gh<_i156.RemoveWatchlist>()));
  gh.factory<_i158.RemoveWatchlistSymbol>(
      () => _i158.RemoveWatchlistSymbol(gh<_i45.EquityRespository>()));
  gh.factory<_i159.ResendTransactionOtp>(
      () => _i159.ResendTransactionOtp(gh<_i134.MutualFundRepository>()));
  gh.factory<_i160.ResendTransactionOtpCubit>(
      () => _i160.ResendTransactionOtpCubit(
            gh<_i159.ResendTransactionOtp>(),
            gh<_i12.LoadingCubit>(),
          ));
  gh.factory<_i161.RetakeKyc>(() => _i161.RetakeKyc(gh<_i124.KycRepository>()));
  gh.factory<_i162.RetakeKycCubit>(() => _i162.RetakeKycCubit(
        gh<_i161.RetakeKyc>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.lazySingleton<_i163.RetirementCalculatorRemoteDataSource>(() =>
      _i163.RetirementCalculatorRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i164.RetirementCalculatorRepository>(() =>
      _i165.RetirementCalculatorRepositoryImpl(
          gh<_i163.RetirementCalculatorRemoteDataSource>()));
  gh.factory<_i166.SellGoldSilver>(
      () => _i166.SellGoldSilver(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i167.SellGoldSilverCubit>(
      () => _i167.SellGoldSilverCubit(gh<_i166.SellGoldSilver>()));
  gh.factory<_i168.SetAlert>(
      () => _i168.SetAlert(gh<_i45.EquityRespository>()));
  gh.factory<_i169.SetAlertCubit>(
      () => _i169.SetAlertCubit(gh<_i168.SetAlert>()));
  gh.factory<_i170.SilverChartCubit>(
      () => _i170.SilverChartCubit(gh<_i75.GetDigitalGoldGraph>()));
  gh.factory<_i171.SmallcaseFundsCubit>(
      () => _i171.SmallcaseFundsCubit(gh<_i93.GetSmallcaseFunds>()));
  gh.factory<_i172.SmallcaseLoginCubit>(
      () => _i172.SmallcaseLoginCubit(gh<_i94.GetSmallcaseLogin>()));
  gh.factory<_i173.SmartWatchlistHoldingsCubit>(() =>
      _i173.SmartWatchlistHoldingsCubit(gh<_i96.GetSmartWatchlistHoldings>()));
  gh.factory<_i174.SmartWatchlistSearchCubit>(() =>
      _i174.SmartWatchlistSearchCubit(gh<_i97.GetSmartWatchlistSearch>()));
  gh.factory<_i175.StockChartCubit>(
      () => _i175.StockChartCubit(gh<_i81.GetExploreStockChart>()));
  gh.factory<_i176.StockDetailsCubit>(
      () => _i176.StockDetailsCubit(gh<_i98.GetStockDetail>()));
  gh.factory<_i177.StopSipOrder>(
      () => _i177.StopSipOrder(gh<_i134.MutualFundRepository>()));
  gh.factory<_i178.StopStpOrder>(
      () => _i178.StopStpOrder(gh<_i134.MutualFundRepository>()));
  gh.factory<_i179.StopSwpOrder>(
      () => _i179.StopSwpOrder(gh<_i134.MutualFundRepository>()));
  gh.factory<_i180.SubmitChoices>(
      () => _i180.SubmitChoices(gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i181.SubmitChoicesCubit>(() => _i181.SubmitChoicesCubit(
        gh<_i180.SubmitChoices>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.factory<_i182.SubmitImportOtp>(
      () => _i182.SubmitImportOtp(gh<_i127.LAMFRepository>()));
  gh.factory<_i183.SubmitImportOtpCubit>(
      () => _i183.SubmitImportOtpCubit(gh<_i182.SubmitImportOtp>()));
  gh.factory<_i184.SubmitRetirementOTP>(() =>
      _i184.SubmitRetirementOTP(gh<_i164.RetirementCalculatorRepository>()));
  gh.factory<_i185.SubmitRetirementOtpCubit>(
      () => _i185.SubmitRetirementOtpCubit(gh<_i184.SubmitRetirementOTP>()));
  gh.factory<_i186.TransactionidCubit>(
      () => _i186.TransactionidCubit(gh<_i105.GetTransactionId>()));
  gh.factory<_i187.UnlockAssistedService>(
      () => _i187.UnlockAssistedService(gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i188.UnlockAssistedServiceCubit>(
      () => _i188.UnlockAssistedServiceCubit(
            gh<_i187.UnlockAssistedService>(),
            gh<_i12.LoadingCubit>(),
          ));
  gh.factory<_i189.UpdateInvestorAccount>(
      () => _i189.UpdateInvestorAccount(gh<_i124.KycRepository>()));
  gh.factory<_i190.UpdateLoanStatus>(
      () => _i190.UpdateLoanStatus(gh<_i127.LAMFRepository>()));
  gh.factory<_i191.UploadAddressDetails>(
      () => _i191.UploadAddressDetails(gh<_i124.KycRepository>()));
  gh.factory<_i192.UploadAdhaarNumber>(
      () => _i192.UploadAdhaarNumber(gh<_i124.KycRepository>()));
  gh.factory<_i193.UploadBankDetails>(
      () => _i193.UploadBankDetails(gh<_i124.KycRepository>()));
  gh.factory<_i194.UploadCancelledCheque>(
      () => _i194.UploadCancelledCheque(gh<_i124.KycRepository>()));
  gh.factory<_i195.UploadDigitalSignature>(
      () => _i195.UploadDigitalSignature(gh<_i124.KycRepository>()));
  gh.factory<_i196.UploadFatcaDetails>(
      () => _i196.UploadFatcaDetails(gh<_i124.KycRepository>()));
  gh.factory<_i197.UploadKycVideo>(
      () => _i197.UploadKycVideo(gh<_i124.KycRepository>()));
  gh.factory<_i198.UploadNomineeDetails>(
      () => _i198.UploadNomineeDetails(gh<_i124.KycRepository>()));
  gh.factory<_i199.UploadPersonalDetails>(
      () => _i199.UploadPersonalDetails(gh<_i124.KycRepository>()));
  gh.factory<_i200.UploadProofOfAddress>(
      () => _i200.UploadProofOfAddress(gh<_i124.KycRepository>()));
  gh.factory<_i201.UploadProofOfIdentity>(
      () => _i201.UploadProofOfIdentity(gh<_i124.KycRepository>()));
  gh.factory<_i202.UploadSelfie>(
      () => _i202.UploadSelfie(gh<_i124.KycRepository>()));
  gh.factory<_i203.ValidateTransaction>(
      () => _i203.ValidateTransaction(gh<_i48.ExternalFundRepository>()));
  gh.factory<_i204.VerifyAssistedServicePin>(() =>
      _i204.VerifyAssistedServicePin(gh<_i33.AssistedServiceRepository>()));
  gh.factory<_i205.VerifyAssistedServicePinCubit>(
      () => _i205.VerifyAssistedServicePinCubit(
            gh<_i204.VerifyAssistedServicePin>(),
            gh<_i12.LoadingCubit>(),
          ));
  gh.factory<_i206.VerifyBankAccount>(
      () => _i206.VerifyBankAccount(gh<_i124.KycRepository>()));
  gh.factory<_i207.VerifyBankAccountCubit>(
      () => _i207.VerifyBankAccountCubit(gh<_i206.VerifyBankAccount>()));
  gh.factory<_i208.VerifyBasketLumpsumConsent>(
      () => _i208.VerifyBasketLumpsumConsent(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i209.VerifyBasketRedeemConsent>(
      () => _i209.VerifyBasketRedeemConsent(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i210.VerifyBasketSipConsent>(
      () => _i210.VerifyBasketSipConsent(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i211.VerifyCartPurchaseOtp>(
      () => _i211.VerifyCartPurchaseOtp(gh<_i134.MutualFundRepository>()));
  gh.factory<_i212.VerifyCartPurchaseOtpCubit>(() =>
      _i212.VerifyCartPurchaseOtpCubit(gh<_i211.VerifyCartPurchaseOtp>()));
  gh.factory<_i213.VerifyConsentCubit>(
      () => _i213.VerifyConsentCubit(gh<_i134.MutualFundRepository>()));
  gh.factory<_i214.VerifyPan>(() => _i214.VerifyPan(gh<_i124.KycRepository>()));
  gh.factory<_i215.VerifyPanCubit>(
      () => _i215.VerifyPanCubit(gh<_i214.VerifyPan>()));
  gh.factory<_i216.VerifyRedemptionOtp>(
      () => _i216.VerifyRedemptionOtp(gh<_i134.MutualFundRepository>()));
  gh.factory<_i217.VerifyStpOtp>(
      () => _i217.VerifyStpOtp(gh<_i134.MutualFundRepository>()));
  gh.factory<_i218.VerifySwitchOtp>(
      () => _i218.VerifySwitchOtp(gh<_i134.MutualFundRepository>()));
  gh.factory<_i219.VerifySwpOtp>(
      () => _i219.VerifySwpOtp(gh<_i134.MutualFundRepository>()));
  gh.factory<_i220.VerifyTransactionOtpCubit>(
      () => _i220.VerifyTransactionOtpCubit(
            gh<_i216.VerifyRedemptionOtp>(),
            gh<_i218.VerifySwitchOtp>(),
            gh<_i219.VerifySwpOtp>(),
            gh<_i217.VerifyStpOtp>(),
          ));
  gh.factory<_i221.WatchlistSymbolCubit>(
      () => _i221.WatchlistSymbolCubit(gh<_i108.GetWatchlistSymbol>()));
  gh.factory<_i222.AccountDetailsCubit>(
      () => _i222.AccountDetailsCubit(gh<_i52.GetAccountDetails>()));
  gh.lazySingleton<_i223.AccountRemoteDataSource>(
      () => _i223.AccountRemoteDataSourceImpl(gh<_i31.ApiClient>()));
  gh.lazySingleton<_i224.AccountRepository>(() => _i225.AccountRepositoryImpl(
        gh<_i223.AccountRemoteDataSource>(),
        gh<_i3.AccountLocalDataSource>(),
        gh<_i26.TokenLocalDataSource>(),
      ));
  gh.factory<_i226.AddDeliveryAddress>(
      () => _i226.AddDeliveryAddress(gh<_i224.AccountRepository>()));
  gh.factory<_i227.AddDeliveryAddressCubit>(() => _i227.AddDeliveryAddressCubit(
        gh<_i226.AddDeliveryAddress>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.factory<_i228.AddDgBankAccount>(
      () => _i228.AddDgBankAccount(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i229.AddProfileBankDetails>(
      () => _i229.AddProfileBankDetails(gh<_i224.AccountRepository>()));
  gh.factory<_i230.AddStockWatchlistCubit>(
      () => _i230.AddStockWatchlistCubit(gh<_i151.PutStockToWatchlist>()));
  gh.factory<_i231.AddToCart>(
      () => _i231.AddToCart(gh<_i134.MutualFundRepository>()));
  gh.factory<_i232.AddToCartCubit>(
      () => _i232.AddToCartCubit(gh<_i231.AddToCart>()));
  gh.factory<_i233.AddUserBankCubit>(() => _i233.AddUserBankCubit(
        gh<_i229.AddProfileBankDetails>(),
        gh<_i189.UpdateInvestorAccount>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.factory<_i234.AddUserMandate>(
      () => _i234.AddUserMandate(gh<_i224.AccountRepository>()));
  gh.factory<_i235.AllStocksCubit>(
      () => _i235.AllStocksCubit(gh<_i100.GetStocksList>()));
  gh.factory<_i236.AssistedHoldingsCubit>(
      () => _i236.AssistedHoldingsCubit(gh<_i56.GetAssistedHoldings>()));
  gh.factory<_i237.AssistedOrdersCubit>(
      () => _i237.AssistedOrdersCubit(gh<_i57.GetAssistedOrders>()));
  gh.factory<_i238.AuthoriseMandate>(
      () => _i238.AuthoriseMandate(gh<_i224.AccountRepository>()));
  gh.factory<_i239.AuthoriseMandateCubit>(
      () => _i239.AuthoriseMandateCubit(gh<_i238.AuthoriseMandate>()));
  gh.factory<_i240.BasketLumpsumOrderVerifyCubit>(() =>
      _i240.BasketLumpsumOrderVerifyCubit(
          gh<_i208.VerifyBasketLumpsumConsent>()));
  gh.factory<_i241.BasketRedeemOrderVerifyCubit>(() =>
      _i241.BasketRedeemOrderVerifyCubit(
          gh<_i209.VerifyBasketRedeemConsent>()));
  gh.factory<_i242.BasketSipOrderVerifyCubit>(() =>
      _i242.BasketSipOrderVerifyCubit(gh<_i210.VerifyBasketSipConsent>()));
  gh.factory<_i243.BrokerHoldingsFundCubit>(
      () => _i243.BrokerHoldingsFundCubit(gh<_i61.GetBrokerHoldings>()));
  gh.factory<_i244.BuySellTransactionCubit>(
      () => _i244.BuySellTransactionCubit(gh<_i65.GetBuySellTrasaction>()));
  gh.factory<_i245.CancelSystematicPlanCubit>(
      () => _i245.CancelSystematicPlanCubit(
            gh<_i177.StopSipOrder>(),
            gh<_i178.StopStpOrder>(),
            gh<_i179.StopSwpOrder>(),
            gh<_i12.LoadingCubit>(),
          ));
  gh.factory<_i246.CaptureFaqDislike>(
      () => _i246.CaptureFaqDislike(gh<_i36.ContactUsRepository>()));
  gh.factory<_i247.CaptureFaqDislikeCubit>(
      () => _i247.CaptureFaqDislikeCubit(gh<_i246.CaptureFaqDislike>()));
  gh.factory<_i248.CaptureFaqLike>(
      () => _i248.CaptureFaqLike(gh<_i36.ContactUsRepository>()));
  gh.factory<_i249.CaptureFaqLikeCubit>(
      () => _i249.CaptureFaqLikeCubit(gh<_i248.CaptureFaqLike>()));
  gh.factory<_i250.CategoryQuestionsCubit>(
      () => _i250.CategoryQuestionsCubit(gh<_i67.GetCategoryQuestionsList>()));
  gh.factory<_i251.CategoryQuestionsDetailCubit>(() =>
      _i251.CategoryQuestionsDetailCubit(gh<_i66.GetCategoryQuestionDetail>()));
  gh.factory<_i252.CheckoutDeliveryOrder>(
      () => _i252.CheckoutDeliveryOrder(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i253.CheckoutDeliveryOrderCubit>(() =>
      _i253.CheckoutDeliveryOrderCubit(gh<_i252.CheckoutDeliveryOrder>()));
  gh.factory<_i254.ChequeOcrRead>(
      () => _i254.ChequeOcrRead(gh<_i124.KycRepository>()));
  gh.factory<_i255.ChequeOcrReadCubit>(
      () => _i255.ChequeOcrReadCubit(gh<_i254.ChequeOcrRead>()));
  gh.factory<_i256.ClearCartFunds>(
      () => _i256.ClearCartFunds(gh<_i134.MutualFundRepository>()));
  gh.factory<_i257.ConfirmPan>(
      () => _i257.ConfirmPan(gh<_i124.KycRepository>()));
  gh.factory<_i258.ContactUsCubit>(
      () => _i258.ContactUsCubit(gh<_i70.GetContactUsCategoriesList>()));
  gh.factory<_i259.ContactUsFormCubit>(
      () => _i259.ContactUsFormCubit(gh<_i150.PostSupportEmail>()));
  gh.factory<_i260.CreateBasketIndividualOrder>(() =>
      _i260.CreateBasketIndividualOrder(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i261.CreateBasketLumpsumOrder>(
      () => _i261.CreateBasketLumpsumOrder(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i262.CreateBasketOrderConsent>(
      () => _i262.CreateBasketOrderConsent(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i263.CreateBasketRedeemOrder>(
      () => _i263.CreateBasketRedeemOrder(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i264.CreateBasketSipOrder>(
      () => _i264.CreateBasketSipOrder(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i265.CreateConsentCubit>(
      () => _i265.CreateConsentCubit(gh<_i134.MutualFundRepository>()));
  gh.factory<_i266.CreateCustomUserGoals>(
      () => _i266.CreateCustomUserGoals(gh<_i111.GoalPlanningRepository>()));
  gh.factory<_i267.CreateDeliveryOrder>(
      () => _i267.CreateDeliveryOrder(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i268.CreateDeliveryOrderCubit>(
      () => _i268.CreateDeliveryOrderCubit(gh<_i267.CreateDeliveryOrder>()));
  gh.factory<_i269.CreateGoalInvestment>(
      () => _i269.CreateGoalInvestment(gh<_i111.GoalPlanningRepository>()));
  gh.factory<_i270.CreateGoldKyc>(
      () => _i270.CreateGoldKyc(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i271.CreateGoldUser>(
      () => _i271.CreateGoldUser(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i272.CreateInvestorAccount>(
      () => _i272.CreateInvestorAccount(gh<_i124.KycRepository>()));
  gh.factory<_i273.CreateKycRequest>(
      () => _i273.CreateKycRequest(gh<_i124.KycRepository>()));
  gh.factory<_i274.CreateLumpsumPurchase>(
      () => _i274.CreateLumpsumPurchase(gh<_i134.MutualFundRepository>()));
  gh.factory<_i275.CreateLumpsumPurchaseCubit>(
      () => _i275.CreateLumpsumPurchaseCubit(
            gh<_i274.CreateLumpsumPurchase>(),
            gh<_i12.LoadingCubit>(),
          ));
  gh.factory<_i276.CreateMandateCubit>(
      () => _i276.CreateMandateCubit(gh<_i234.AddUserMandate>()));
  gh.factory<_i277.CreateMfAccount>(
      () => _i277.CreateMfAccount(gh<_i124.KycRepository>()));
  gh.factory<_i278.CreateOrder>(
      () => _i278.CreateOrder(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i279.CreateOrderCubit>(
      () => _i279.CreateOrderCubit(gh<_i278.CreateOrder>()));
  gh.factory<_i280.CreateRedemptionOrder>(
      () => _i280.CreateRedemptionOrder(gh<_i134.MutualFundRepository>()));
  gh.factory<_i281.CreateSipOrder>(
      () => _i281.CreateSipOrder(gh<_i134.MutualFundRepository>()));
  gh.factory<_i282.CreateStpOrder>(
      () => _i282.CreateStpOrder(gh<_i134.MutualFundRepository>()));
  gh.factory<_i283.CreateStpOrderCubit>(
      () => _i283.CreateStpOrderCubit(gh<_i282.CreateStpOrder>()));
  gh.factory<_i284.CreateSwitchOrder>(
      () => _i284.CreateSwitchOrder(gh<_i134.MutualFundRepository>()));
  gh.factory<_i285.CreateSwitchOrderCubit>(
      () => _i285.CreateSwitchOrderCubit(gh<_i284.CreateSwitchOrder>()));
  gh.factory<_i286.CreateSwpOrder>(
      () => _i286.CreateSwpOrder(gh<_i134.MutualFundRepository>()));
  gh.factory<_i287.CreateSwpOrderCubit>(
      () => _i287.CreateSwpOrderCubit(gh<_i286.CreateSwpOrder>()));
  gh.factory<_i288.CreateUserGoalsCubit>(
      () => _i288.CreateUserGoalsCubit(gh<_i266.CreateCustomUserGoals>()));
  gh.factory<_i289.CreateWatchlistCubit>(
      () => _i289.CreateWatchlistCubit(gh<_i71.GetCreateWatchlist>()));
  gh.factory<_i290.DGAcceptTerms>(
      () => _i290.DGAcceptTerms(gh<_i39.DigitalGoldRepository>()));
  gh.factory<_i291.DeleteDeliveryAddress>(
      () => _i291.DeleteDeliveryAddress(gh<_i224.AccountRepository>()));
  gh.factory<_i292.DeleteDeliveryAddressCubit>(() =>
      _i292.DeleteDeliveryAddressCubit(gh<_i291.DeleteDeliveryAddress>()));
  gh.factory<_i293.DeleteNomineeDetails>(
      () => _i293.DeleteNomineeDetails(gh<_i124.KycRepository>()));
  gh.factory<_i294.DeleteSip>(
      () => _i294.DeleteSip(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i295.DeleteSipCubit>(
      () => _i295.DeleteSipCubit(gh<_i294.DeleteSip>()));
  gh.factory<_i296.DeleteUserMandate>(
      () => _i296.DeleteUserMandate(gh<_i224.AccountRepository>()));
  gh.factory<_i297.DeleteUserMandateById>(
      () => _i297.DeleteUserMandateById(gh<_i224.AccountRepository>()));
  gh.factory<_i298.DeliveryProductCubit>(
      () => _i298.DeliveryProductCubit(gh<_i72.GetDeliveryProducts>()));
  gh.factory<_i299.DgDeliveryTransactionCubit>(() =>
      _i299.DgDeliveryTransactionCubit(gh<_i73.GetDgDeliveryTransactions>()));
  gh.factory<_i300.DgTransactionCubit>(
      () => _i300.DgTransactionCubit(gh<_i74.GetDgTransactions>()));
  gh.factory<_i301.ESignSubmit>(
      () => _i301.ESignSubmit(gh<_i124.KycRepository>()));
  gh.factory<_i302.EditCart>(
      () => _i302.EditCart(gh<_i134.MutualFundRepository>()));
  gh.factory<_i303.EditCartCubit>(
      () => _i303.EditCartCubit(gh<_i302.EditCart>()));
  gh.factory<_i304.EquityOrdersCubit>(
      () => _i304.EquityOrdersCubit(gh<_i87.GetOrders>()));
  gh.factory<_i305.EtfFundHousesCubit>(
      () => _i305.EtfFundHousesCubit(gh<_i77.GetETFFundHouses>()));
  gh.factory<_i306.EtfStocksCubit>(
      () => _i306.EtfStocksCubit(gh<_i78.GetETFList>()));
  gh.factory<_i307.FetchSmartIndicesCubit>(
      () => _i307.FetchSmartIndicesCubit(gh<_i95.GetSmartIndices>()));
  gh.factory<_i308.FilterByIndexCubit>(
      () => _i308.FilterByIndexCubit(gh<_i99.GetStocksByIndex>()));
  gh.factory<_i309.ForgotMPinGenerateOtp>(
      () => _i309.ForgotMPinGenerateOtp(gh<_i224.AccountRepository>()));
  gh.factory<_i310.ForgotMPinVerifyOtp>(
      () => _i310.ForgotMPinVerifyOtp(gh<_i224.AccountRepository>()));
  gh.factory<_i311.GenerateHoldingsReport>(
      () => _i311.GenerateHoldingsReport(gh<_i134.MutualFundRepository>()));
  gh.factory<_i312.GenerateMobileOtp>(
      () => _i312.GenerateMobileOtp(gh<_i224.AccountRepository>()));
  gh.factory<_i313.GenereteCapitalGainsFile>(
      () => _i313.GenereteCapitalGainsFile(gh<_i134.MutualFundRepository>()));
  gh.factory<_i314.GetActiveSips>(
      () => _i314.GetActiveSips(gh<_i134.MutualFundRepository>()));
  gh.factory<_i315.GetAllBrokersCubit>(
      () => _i315.GetAllBrokersCubit(gh<_i62.GetBrokers>()));
  gh.factory<_i316.GetAllSwitchableMandates>(
      () => _i316.GetAllSwitchableMandates(gh<_i224.AccountRepository>()));
  gh.factory<_i317.GetAllUserWatchlisCubit>(
      () => _i317.GetAllUserWatchlisCubit(gh<_i106.GetUserAllWatchlist>()));
  gh.factory<_i318.GetAvailLoan>(
      () => _i318.GetAvailLoan(gh<_i127.LAMFRepository>()));
  gh.factory<_i319.GetBankDetailsByIfscCode>(
      () => _i319.GetBankDetailsByIfscCode(gh<_i124.KycRepository>()));
  gh.factory<_i320.GetBasketBuyOrder>(
      () => _i320.GetBasketBuyOrder(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i321.GetBasketBuyTransactions>(
      () => _i321.GetBasketBuyTransactions(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i322.GetBasketChartData>(
      () => _i322.GetBasketChartData(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i323.GetBasketDetails>(
      () => _i323.GetBasketDetails(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i324.GetBasketOrderTransactionDetails>(() =>
      _i324.GetBasketOrderTransactionDetails(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i325.GetBasketPortfolio>(
      () => _i325.GetBasketPortfolio(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i326.GetBasketPortfolioDetail>(
      () => _i326.GetBasketPortfolioDetail(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i327.GetBasketSellOrder>(
      () => _i327.GetBasketSellOrder(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i328.GetBasketSellTransactions>(
      () => _i328.GetBasketSellTransactions(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i329.GetCancelledSips>(
      () => _i329.GetCancelledSips(gh<_i134.MutualFundRepository>()));
  gh.factory<_i330.GetCapitalGainReport>(
      () => _i330.GetCapitalGainReport(gh<_i134.MutualFundRepository>()));
  gh.factory<_i331.GetCapitalGainReportCubit>(
      () => _i331.GetCapitalGainReportCubit(gh<_i330.GetCapitalGainReport>()));
  gh.factory<_i332.GetCartLumpsumFunds>(
      () => _i332.GetCartLumpsumFunds(gh<_i134.MutualFundRepository>()));
  gh.factory<_i333.GetCartSipFunds>(
      () => _i333.GetCartSipFunds(gh<_i134.MutualFundRepository>()));
  gh.factory<_i334.GetCibilRefresh>(
      () => _i334.GetCibilRefresh(gh<_i127.LAMFRepository>()));
  gh.factory<_i335.GetCreditLimit>(
      () => _i335.GetCreditLimit(gh<_i127.LAMFRepository>()));
  gh.factory<_i336.GetDecentroAddress>(
      () => _i336.GetDecentroAddress(gh<_i124.KycRepository>()));
  gh.factory<_i337.GetDecentroAddressCubit>(
      () => _i337.GetDecentroAddressCubit(gh<_i336.GetDecentroAddress>()));
  gh.factory<_i338.GetDeliveryAddressList>(
      () => _i338.GetDeliveryAddressList(gh<_i224.AccountRepository>()));
  gh.factory<_i339.GetDislikeReasonsCubit>(
      () => _i339.GetDislikeReasonsCubit(gh<_i76.GetDislikeReasonsList>()));
  gh.factory<_i340.GetExploreDIYData>(
      () => _i340.GetExploreDIYData(gh<_i134.MutualFundRepository>()));
  gh.factory<_i341.GetFpFundDetails>(
      () => _i341.GetFpFundDetails(gh<_i134.MutualFundRepository>()));
  gh.factory<_i342.GetFundHoldings>(
      () => _i342.GetFundHoldings(gh<_i134.MutualFundRepository>()));
  gh.factory<_i343.GetFundsByInvestmentIdea>(
      () => _i343.GetFundsByInvestmentIdea(gh<_i134.MutualFundRepository>()));
  gh.factory<_i344.GetFundsByInvestmentIdeaCubit>(() =>
      _i344.GetFundsByInvestmentIdeaCubit(
          gh<_i343.GetFundsByInvestmentIdea>()));
  gh.factory<_i345.GetFundsBySubCategory>(
      () => _i345.GetFundsBySubCategory(gh<_i134.MutualFundRepository>()));
  gh.factory<_i346.GetGoalPlanningDashboard>(
      () => _i346.GetGoalPlanningDashboard(gh<_i111.GoalPlanningRepository>()));
  gh.factory<_i347.GetGoalPlanningDashboardDataCubit>(() =>
      _i347.GetGoalPlanningDashboardDataCubit(
          gh<_i346.GetGoalPlanningDashboard>()));
  gh.factory<_i348.GetGoalsCoreData>(
      () => _i348.GetGoalsCoreData(gh<_i111.GoalPlanningRepository>()));
  gh.factory<_i349.GetGoalsCoreDataCubit>(
      () => _i349.GetGoalsCoreDataCubit(gh<_i348.GetGoalsCoreData>()));
  gh.factory<_i350.GetGoalsDetails>(
      () => _i350.GetGoalsDetails(gh<_i111.GoalPlanningRepository>()));
  gh.factory<_i351.GetHoldingAnalysis>(
      () => _i351.GetHoldingAnalysis(gh<_i134.MutualFundRepository>()));
  gh.factory<_i352.GetImportLoanData>(
      () => _i352.GetImportLoanData(gh<_i127.LAMFRepository>()));
  gh.factory<_i353.GetImportLoans>(
      () => _i353.GetImportLoans(gh<_i127.LAMFRepository>()));
  gh.factory<_i354.GetInititateImportLoans>(
      () => _i354.GetInititateImportLoans(gh<_i127.LAMFRepository>()));
  gh.factory<_i355.GetInvestmentIdeaFilters>(
      () => _i355.GetInvestmentIdeaFilters(gh<_i134.MutualFundRepository>()));
  gh.factory<_i356.GetInvestmentIdeaFiltersCubit>(() =>
      _i356.GetInvestmentIdeaFiltersCubit(
          gh<_i355.GetInvestmentIdeaFilters>()));
  gh.factory<_i357.GetInvestmentReturns>(
      () => _i357.GetInvestmentReturns(gh<_i134.MutualFundRepository>()));
  gh.factory<_i358.GetKycAddressDetails>(
      () => _i358.GetKycAddressDetails(gh<_i124.KycRepository>()));
  gh.factory<_i359.GetKycBankDetails>(
      () => _i359.GetKycBankDetails(gh<_i124.KycRepository>()));
  gh.factory<_i360.GetKycData>(
      () => _i360.GetKycData(gh<_i124.KycRepository>()));
  gh.factory<_i361.GetKycFatcaDetails>(
      () => _i361.GetKycFatcaDetails(gh<_i124.KycRepository>()));
  gh.factory<_i362.GetKycLastRoute>(
      () => _i362.GetKycLastRoute(gh<_i224.AccountRepository>()));
  gh.factory<_i363.GetKycLastRouteCubit>(
      () => _i363.GetKycLastRouteCubit(gh<_i362.GetKycLastRoute>()));
  gh.factory<_i364.GetKycNomineeDetails>(
      () => _i364.GetKycNomineeDetails(gh<_i124.KycRepository>()));
  gh.factory<_i365.GetKycPersonalDetails>(
      () => _i365.GetKycPersonalDetails(gh<_i124.KycRepository>()));
  gh.factory<_i366.GetKycVideoOtp>(
      () => _i366.GetKycVideoOtp(gh<_i124.KycRepository>()));
  gh.factory<_i367.GetKycVideoOtpCubit>(() => _i367.GetKycVideoOtpCubit(
        gh<_i366.GetKycVideoOtp>(),
        gh<_i273.CreateKycRequest>(),
      ));
  gh.factory<_i368.GetLAMFLandingPage>(
      () => _i368.GetLAMFLandingPage(gh<_i127.LAMFRepository>()));
  gh.factory<_i369.GetLamfLandingPageCubit>(() => _i369.GetLamfLandingPageCubit(
        gh<_i368.GetLAMFLandingPage>(),
        gh<_i334.GetCibilRefresh>(),
      ));
  gh.factory<_i370.GetLoanData>(
      () => _i370.GetLoanData(gh<_i127.LAMFRepository>()));
  gh.factory<_i371.GetLoanDataCubit>(
      () => _i371.GetLoanDataCubit(gh<_i352.GetImportLoanData>()));
  gh.factory<_i372.GetLoanImportDetails>(
      () => _i372.GetLoanImportDetails(gh<_i127.LAMFRepository>()));
  gh.factory<_i373.GetLoanUser>(
      () => _i373.GetLoanUser(gh<_i127.LAMFRepository>()));
  gh.factory<_i374.GetMFNavHistory>(
      () => _i374.GetMFNavHistory(gh<_i134.MutualFundRepository>()));
  gh.factory<_i375.GetMarketNews>(
      () => _i375.GetMarketNews(gh<_i131.MarketNewsRepository>()));
  gh.factory<_i376.GetMfOrders>(
      () => _i376.GetMfOrders(gh<_i134.MutualFundRepository>()));
  gh.factory<_i377.GetMfTransactions>(
      () => _i377.GetMfTransactions(gh<_i134.MutualFundRepository>()));
  gh.factory<_i378.GetMutualFundByIsin>(
      () => _i378.GetMutualFundByIsin(gh<_i134.MutualFundRepository>()));
  gh.factory<_i379.GetMutualFundDetail>(
      () => _i379.GetMutualFundDetail(gh<_i134.MutualFundRepository>()));
  gh.factory<_i380.GetMutualFunds>(
      () => _i380.GetMutualFunds(gh<_i134.MutualFundRepository>()));
  gh.factory<_i381.GetNeoBasket>(
      () => _i381.GetNeoBasket(gh<_i137.NeobasketsRepository>()));
  gh.factory<_i382.GetPincodeData>(
      () => _i382.GetPincodeData(gh<_i124.KycRepository>()));
  gh.factory<_i383.GetPledgedFunds>(
      () => _i383.GetPledgedFunds(gh<_i127.LAMFRepository>()));
  gh.factory<_i384.GetReterementOTP>(
      () => _i384.GetReterementOTP(gh<_i164.RetirementCalculatorRepository>()));
  gh.factory<_i385.GetRetirementCorpus>(() =>
      _i385.GetRetirementCorpus(gh<_i164.RetirementCalculatorRepository>()));
  gh.factory<_i386.GetRetirementInflationCalculation>(() =>
      _i386.GetRetirementInflationCalculation(
          gh<_i164.RetirementCalculatorRepository>()));
  gh.factory<_i387.GetRetirementPassbook>(() =>
      _i387.GetRetirementPassbook(gh<_i164.RetirementCalculatorRepository>()));
  gh.factory<_i388.GetSectorAllocation>(
      () => _i388.GetSectorAllocation(gh<_i134.MutualFundRepository>()));
  gh.factory<_i389.GetSipInstallments>(
      () => _i389.GetSipInstallments(gh<_i134.MutualFundRepository>()));
  gh.factory<_i390.GetSipsByMandate>(
      () => _i390.GetSipsByMandate(gh<_i224.AccountRepository>()));
  gh.factory<_i391.GetStpFunds>(
      () => _i391.GetStpFunds(gh<_i134.MutualFundRepository>()));
  gh.factory<_i392.GetStpInstallments>(
      () => _i392.GetStpInstallments(gh<_i134.MutualFundRepository>()));
  gh.factory<_i393.GetSwitchFunds>(
      () => _i393.GetSwitchFunds(gh<_i134.MutualFundRepository>()));
  gh.factory<_i394.GetSwpInstallments>(
      () => _i394.GetSwpInstallments(gh<_i134.MutualFundRepository>()));
  gh.factory<_i395.GetSystematicPlans>(
      () => _i395.GetSystematicPlans(gh<_i134.MutualFundRepository>()));
  gh.factory<_i396.GetTransactions>(
      () => _i396.GetTransactions(gh<_i127.LAMFRepository>()));
  gh.factory<_i397.GetUnreadNotificationCount>(() =>
      _i397.GetUnreadNotificationCount(gh<_i140.NotificationRepository>()));
  gh.factory<_i398.GetUser>(() => _i398.GetUser(gh<_i224.AccountRepository>()));
  gh.factory<_i399.GetUserAlertsCubit>(
      () => _i399.GetUserAlertsCubit(gh<_i107.GetUsersAlerts>()));
  gh.factory<_i400.GetUserBankList>(
      () => _i400.GetUserBankList(gh<_i224.AccountRepository>()));
  gh.factory<_i401.GetUserMFHoldings>(
      () => _i401.GetUserMFHoldings(gh<_i134.MutualFundRepository>()));
  gh.factory<_i402.GetUserMandateById>(
      () => _i402.GetUserMandateById(gh<_i224.AccountRepository>()));
  gh.factory<_i403.GetUserMandates>(
      () => _i403.GetUserMandates(gh<_i224.AccountRepository>()));
  gh.factory<_i404.GetUserMandatesByBank>(
      () => _i404.GetUserMandatesByBank(gh<_i224.AccountRepository>()));
  gh.factory<_i405.GetUserNotifications>(
      () => _i405.GetUserNotifications(gh<_i140.NotificationRepository>()));
  gh.factory<_i406.GetUserPrimaryBank>(
      () => _i406.GetUserPrimaryBank(gh<_i224.AccountRepository>()));
  gh.factory<_i407.GetUserSwitchableMandatesCubit>(() =>
      _i407.GetUserSwitchableMandatesCubit(
          gh<_i316.GetAllSwitchableMandates>()));
  gh.factory<_i408.HoldingAnalysisCubit>(() => _i408.HoldingAnalysisCubit(
        gh<_i351.GetHoldingAnalysis>(),
        gh<_i388.GetSectorAllocation>(),
      ));
  gh.factory<_i409.InitiateCartLumpsumPurchase>(() =>
      _i409.InitiateCartLumpsumPurchase(gh<_i134.MutualFundRepository>()));
  gh.factory<_i410.InitiateCartSipPurchase>(
      () => _i410.InitiateCartSipPurchase(gh<_i134.MutualFundRepository>()));
  gh.factory<_i411.InitiateLoanClosure>(
      () => _i411.InitiateLoanClosure(gh<_i127.LAMFRepository>()));
  gh.factory<_i412.InitiateLumpsumPurchase>(
      () => _i412.InitiateLumpsumPurchase(gh<_i134.MutualFundRepository>()));
  gh.factory<_i413.InitiateLumpsumPurchaseCubit>(
      () => _i413.InitiateLumpsumPurchaseCubit(
            gh<_i412.InitiateLumpsumPurchase>(),
            gh<_i12.LoadingCubit>(),
          ));
  gh.factory<_i414.InitiatePayment>(
      () => _i414.InitiatePayment(gh<_i127.LAMFRepository>()));
  gh.factory<_i415.InitiateWithdrawal>(
      () => _i415.InitiateWithdrawal(gh<_i127.LAMFRepository>()));
  gh.factory<_i416.InvestmentReturnsCubit>(
      () => _i416.InvestmentReturnsCubit(gh<_i357.GetInvestmentReturns>()));
  gh.factory<_i417.IsSchemePresent>(
      () => _i417.IsSchemePresent(gh<_i134.MutualFundRepository>()));
  gh.factory<_i418.IsSchemePresentCubit>(
      () => _i418.IsSchemePresentCubit(gh<_i417.IsSchemePresent>()));
  gh.factory<_i419.KycCreateAccountCubit>(() => _i419.KycCreateAccountCubit(
        gh<_i272.CreateInvestorAccount>(),
        gh<_i277.CreateMfAccount>(),
        gh<_i271.CreateGoldUser>(),
        gh<_i290.DGAcceptTerms>(),
        gh<_i228.AddDgBankAccount>(),
        gh<_i270.CreateGoldKyc>(),
      ));
  gh.factory<_i420.LamfAvailLoanCubit>(
      () => _i420.LamfAvailLoanCubit(gh<_i318.GetAvailLoan>()));
  gh.factory<_i421.LamfGetCreditLimitCubit>(
      () => _i421.LamfGetCreditLimitCubit(gh<_i335.GetCreditLimit>()));
  gh.factory<_i422.LamfGetLoanDataCubit>(
      () => _i422.LamfGetLoanDataCubit(gh<_i370.GetLoanData>()));
  gh.factory<_i423.LamfGetTransactionsCubit>(
      () => _i423.LamfGetTransactionsCubit(gh<_i396.GetTransactions>()));
  gh.factory<_i424.LamfGetUserCubit>(
      () => _i424.LamfGetUserCubit(gh<_i373.GetLoanUser>()));
  gh.factory<_i425.LamfImportLoansCubit>(
      () => _i425.LamfImportLoansCubit(gh<_i353.GetImportLoans>()));
  gh.factory<_i426.LamfInitiatePaymentCubit>(
      () => _i426.LamfInitiatePaymentCubit(gh<_i414.InitiatePayment>()));
  gh.factory<_i427.LamfInitiateWithdrawalCubit>(
      () => _i427.LamfInitiateWithdrawalCubit(gh<_i415.InitiateWithdrawal>()));
  gh.factory<_i428.LamfLoanClosureCubit>(
      () => _i428.LamfLoanClosureCubit(gh<_i129.LoanClosure>()));
  gh.factory<_i429.LamfPledgedFundsCubit>(
      () => _i429.LamfPledgedFundsCubit(gh<_i383.GetPledgedFunds>()));
  gh.factory<_i430.LamfUpdateLoanStatusCubit>(
      () => _i430.LamfUpdateLoanStatusCubit(gh<_i190.UpdateLoanStatus>()));
  gh.factory<_i431.LoanImportDetailsCubit>(
      () => _i431.LoanImportDetailsCubit(gh<_i372.GetLoanImportDetails>()));
  gh.factory<_i432.LoginWithEmail>(
      () => _i432.LoginWithEmail(gh<_i224.AccountRepository>()));
  gh.factory<_i433.LoginWithEmailCubit>(
      () => _i433.LoginWithEmailCubit(gh<_i432.LoginWithEmail>()));
  gh.factory<_i434.LoginWithMPin>(
      () => _i434.LoginWithMPin(gh<_i224.AccountRepository>()));
  gh.factory<_i435.LumpsumCartCubit>(() => _i435.LumpsumCartCubit(
        gh<_i332.GetCartLumpsumFunds>(),
        gh<_i155.RemoveFundFromCart>(),
      ));
  gh.factory<_i436.MFChartCubit>(
      () => _i436.MFChartCubit(gh<_i374.GetMFNavHistory>()));
  gh.factory<_i437.MPinLoginCubit>(() => _i437.MPinLoginCubit(
        gh<_i434.LoginWithMPin>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.factory<_i438.MandateSipsCubit>(
      () => _i438.MandateSipsCubit(gh<_i390.GetSipsByMandate>()));
  gh.factory<_i439.MarkAllNotificationsAsRead>(() =>
      _i439.MarkAllNotificationsAsRead(gh<_i140.NotificationRepository>()));
  gh.factory<_i440.MarkNotificationAsRead>(
      () => _i440.MarkNotificationAsRead(gh<_i140.NotificationRepository>()));
  gh.factory<_i441.MarketNewsCubit>(
      () => _i441.MarketNewsCubit(gh<_i375.GetMarketNews>()));
  gh.factory<_i442.MfOrdersCubit>(
      () => _i442.MfOrdersCubit(gh<_i376.GetMfOrders>()));
  gh.factory<_i443.MfTransactionsCubit>(
      () => _i443.MfTransactionsCubit(gh<_i377.GetMfTransactions>()));
  gh.factory<_i444.MfUserHoldingsCubit>(
      () => _i444.MfUserHoldingsCubit(gh<_i401.GetUserMFHoldings>()));
  gh.factory<_i445.MobileOtpCubit>(
      () => _i445.MobileOtpCubit(gh<_i312.GenerateMobileOtp>()));
  gh.factory<_i446.NeoBasketDiscoveryCubit>(
      () => _i446.NeoBasketDiscoveryCubit(gh<_i381.GetNeoBasket>()));
  gh.factory<_i447.NonKycCreateAccountCubit>(
      () => _i447.NonKycCreateAccountCubit(
            gh<_i273.CreateKycRequest>(),
            gh<_i271.CreateGoldUser>(),
            gh<_i290.DGAcceptTerms>(),
            gh<_i228.AddDgBankAccount>(),
            gh<_i270.CreateGoldKyc>(),
          ));
  gh.factory<_i448.NotificationActionCubit>(() => _i448.NotificationActionCubit(
        gh<_i12.LoadingCubit>(),
        gh<_i440.MarkNotificationAsRead>(),
        gh<_i439.MarkAllNotificationsAsRead>(),
      ));
  gh.factory<_i449.NotificationCountCubit>(() =>
      _i449.NotificationCountCubit(gh<_i397.GetUnreadNotificationCount>()));
  gh.factory<_i450.RemoveSymbolWatchlistCubit>(() =>
      _i450.RemoveSymbolWatchlistCubit(gh<_i158.RemoveWatchlistSymbol>()));
  gh.factory<_i451.ReportCubit>(
      () => _i451.ReportCubit(gh<_i311.GenerateHoldingsReport>()));
  gh.factory<_i452.ResendOtpCubit>(() => _i452.ResendOtpCubit(
        gh<_i432.LoginWithEmail>(),
        gh<_i312.GenerateMobileOtp>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.factory<_i453.RetirementCorpusCubit>(
      () => _i453.RetirementCorpusCubit(gh<_i385.GetRetirementCorpus>()));
  gh.factory<_i454.RetirementInflationCalculatorCubit>(() =>
      _i454.RetirementInflationCalculatorCubit(
          gh<_i386.GetRetirementInflationCalculation>()));
  gh.factory<_i455.RetirementPassbookCubit>(
      () => _i455.RetirementPassbookCubit(gh<_i387.GetRetirementPassbook>()));
  gh.factory<_i456.SearchFundCubit>(
      () => _i456.SearchFundCubit(gh<_i380.GetMutualFunds>()));
  gh.factory<_i457.SetMPin>(() => _i457.SetMPin(gh<_i224.AccountRepository>()));
  gh.factory<_i458.SetMPinCubit>(() => _i458.SetMPinCubit(gh<_i457.SetMPin>()));
  gh.factory<_i459.SetUser>(() => _i459.SetUser(gh<_i224.AccountRepository>()));
  gh.factory<_i460.SipCartCubit>(() => _i460.SipCartCubit(
        gh<_i333.GetCartSipFunds>(),
        gh<_i155.RemoveFundFromCart>(),
      ));
  gh.factory<_i461.SipOrderCubit>(() => _i461.SipOrderCubit(
        gh<_i281.CreateSipOrder>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.factory<_i462.SocialLogin>(
      () => _i462.SocialLogin(gh<_i224.AccountRepository>()));
  gh.factory<_i463.SocialLoginCubit>(() => _i463.SocialLoginCubit(
        gh<_i462.SocialLogin>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.factory<_i464.StpFundsListCubit>(
      () => _i464.StpFundsListCubit(gh<_i391.GetStpFunds>()));
  gh.factory<_i465.SwitchFundsListCubit>(() => _i465.SwitchFundsListCubit(
        gh<_i393.GetSwitchFunds>(),
        gh<_i60.GetAssistedSwitchFunds>(),
      ));
  gh.factory<_i466.SystematicPlanInstallmentsCubit>(
      () => _i466.SystematicPlanInstallmentsCubit(
            gh<_i389.GetSipInstallments>(),
            gh<_i392.GetStpInstallments>(),
            gh<_i394.GetSwpInstallments>(),
          ));
  gh.factory<_i467.SystematicPlansCubit>(
      () => _i467.SystematicPlansCubit(gh<_i395.GetSystematicPlans>()));
  gh.factory<_i468.TransactionCubit>(() => _i468.TransactionCubit(
        gh<_i12.LoadingCubit>(),
        gh<_i118.InitialiseTransaction>(),
        gh<_i203.ValidateTransaction>(),
      ));
  gh.factory<_i469.UpdatePrimaryBankAccount>(
      () => _i469.UpdatePrimaryBankAccount(gh<_i224.AccountRepository>()));
  gh.factory<_i470.UpdatePrimaryBankCubit>(() => _i470.UpdatePrimaryBankCubit(
        gh<_i469.UpdatePrimaryBankAccount>(),
        gh<_i189.UpdateInvestorAccount>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.factory<_i471.UpdateProfileBankIfsc>(
      () => _i471.UpdateProfileBankIfsc(gh<_i224.AccountRepository>()));
  gh.factory<_i472.UpdateProfilePhoto>(
      () => _i472.UpdateProfilePhoto(gh<_i224.AccountRepository>()));
  gh.factory<_i473.UpdateProfilePhotoCubit>(
      () => _i473.UpdateProfilePhotoCubit(gh<_i472.UpdateProfilePhoto>()));
  gh.factory<_i474.UploadAadhaarNumberCubit>(
      () => _i474.UploadAadhaarNumberCubit(
            gh<_i192.UploadAdhaarNumber>(),
            gh<_i360.GetKycData>(),
          ));
  gh.factory<_i475.UploadAddressDetailsCubit>(
      () => _i475.UploadAddressDetailsCubit(
            gh<_i191.UploadAddressDetails>(),
            gh<_i358.GetKycAddressDetails>(),
          ));
  gh.factory<_i476.UploadBankDetailsCubit>(() => _i476.UploadBankDetailsCubit(
        gh<_i193.UploadBankDetails>(),
        gh<_i359.GetKycBankDetails>(),
      ));
  gh.factory<_i477.UploadCancelledChequeCubit>(
      () => _i477.UploadCancelledChequeCubit(
            gh<_i194.UploadCancelledCheque>(),
            gh<_i360.GetKycData>(),
          ));
  gh.factory<_i478.UploadDigitalSignatureCubit>(
      () => _i478.UploadDigitalSignatureCubit(
            gh<_i195.UploadDigitalSignature>(),
            gh<_i360.GetKycData>(),
          ));
  gh.factory<_i479.UploadFatcaDetailsCubit>(() => _i479.UploadFatcaDetailsCubit(
        gh<_i196.UploadFatcaDetails>(),
        gh<_i361.GetKycFatcaDetails>(),
      ));
  gh.factory<_i480.UploadKycVideoCubit>(() => _i480.UploadKycVideoCubit(
        gh<_i197.UploadKycVideo>(),
        gh<_i360.GetKycData>(),
      ));
  gh.factory<_i481.UploadNomineeDetailsCubit>(
      () => _i481.UploadNomineeDetailsCubit(
            gh<_i198.UploadNomineeDetails>(),
            gh<_i364.GetKycNomineeDetails>(),
            gh<_i293.DeleteNomineeDetails>(),
            gh<_i189.UpdateInvestorAccount>(),
          ));
  gh.factory<_i482.UploadPersonalDetailsCubit>(
      () => _i482.UploadPersonalDetailsCubit(
            gh<_i199.UploadPersonalDetails>(),
            gh<_i365.GetKycPersonalDetails>(),
          ));
  gh.factory<_i483.UploadProofOfAddressCubit>(
      () => _i483.UploadProofOfAddressCubit(
            gh<_i200.UploadProofOfAddress>(),
            gh<_i360.GetKycData>(),
          ));
  gh.factory<_i484.UploadProofOfIdentityCubit>(
      () => _i484.UploadProofOfIdentityCubit(
            gh<_i201.UploadProofOfIdentity>(),
            gh<_i360.GetKycData>(),
          ));
  gh.factory<_i485.UploadSelfieCubit>(() => _i485.UploadSelfieCubit(
        gh<_i202.UploadSelfie>(),
        gh<_i360.GetKycData>(),
      ));
  gh.factory<_i486.UserBankDetailsCubit>(
      () => _i486.UserBankDetailsCubit(gh<_i400.GetUserBankList>()));
  gh.factory<_i487.UserMandateCubit>(() => _i487.UserMandateCubit(
        gh<_i404.GetUserMandatesByBank>(),
        gh<_i297.DeleteUserMandateById>(),
      ));
  gh.factory<_i488.UserNotificationCubit>(
      () => _i488.UserNotificationCubit(gh<_i405.GetUserNotifications>()));
  gh.factory<_i489.VarifyDeleteMandate>(
      () => _i489.VarifyDeleteMandate(gh<_i224.AccountRepository>()));
  gh.factory<_i490.VerifyDeleteMandateCubit>(
      () => _i490.VerifyDeleteMandateCubit(gh<_i489.VarifyDeleteMandate>()));
  gh.factory<_i491.VerifyEmailOtp>(
      () => _i491.VerifyEmailOtp(gh<_i224.AccountRepository>()));
  gh.factory<_i492.VerifyEmailOtpCubit>(() => _i492.VerifyEmailOtpCubit(
        gh<_i491.VerifyEmailOtp>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.factory<_i493.VerifyMobileOtp>(
      () => _i493.VerifyMobileOtp(gh<_i224.AccountRepository>()));
  gh.factory<_i494.VerifyMobileOtpCubit>(
      () => _i494.VerifyMobileOtpCubit(gh<_i493.VerifyMobileOtp>()));
  gh.factory<_i495.AllFundsCubit>(
      () => _i495.AllFundsCubit(gh<_i380.GetMutualFunds>()));
  gh.factory<_i496.AuthCubit>(() => _i496.AuthCubit(
        gh<_i398.GetUser>(),
        gh<_i459.SetUser>(),
        gh<_i15.LogoutUser>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.factory<_i497.BasketBuyOrderCubit>(
      () => _i497.BasketBuyOrderCubit(gh<_i320.GetBasketBuyOrder>()));
  gh.factory<_i498.BasketBuyTransactionsCubit>(() =>
      _i498.BasketBuyTransactionsCubit(gh<_i321.GetBasketBuyTransactions>()));
  gh.factory<_i499.BasketChartCubit>(
      () => _i499.BasketChartCubit(gh<_i322.GetBasketChartData>()));
  gh.factory<_i500.BasketDetailsCubit>(
      () => _i500.BasketDetailsCubit(gh<_i323.GetBasketDetails>()));
  gh.factory<_i501.BasketIndividualRedeemOrderCubit>(() =>
      _i501.BasketIndividualRedeemOrderCubit(
          gh<_i260.CreateBasketIndividualOrder>()));
  gh.factory<_i502.BasketLumpsumOrderCubit>(() =>
      _i502.BasketLumpsumOrderCubit(gh<_i261.CreateBasketLumpsumOrder>()));
  gh.factory<_i503.BasketOrderConsentCubit>(() =>
      _i503.BasketOrderConsentCubit(gh<_i262.CreateBasketOrderConsent>()));
  gh.factory<_i504.BasketOrderDetailsCubit>(() => _i504.BasketOrderDetailsCubit(
      gh<_i324.GetBasketOrderTransactionDetails>()));
  gh.factory<_i505.BasketPortfolioCubit>(
      () => _i505.BasketPortfolioCubit(gh<_i325.GetBasketPortfolio>()));
  gh.factory<_i506.BasketPortfolioDetailCubit>(() =>
      _i506.BasketPortfolioDetailCubit(gh<_i326.GetBasketPortfolioDetail>()));
  gh.factory<_i507.BasketRedeemOrderCubit>(
      () => _i507.BasketRedeemOrderCubit(gh<_i263.CreateBasketRedeemOrder>()));
  gh.factory<_i508.BasketSellOrderCubit>(
      () => _i508.BasketSellOrderCubit(gh<_i327.GetBasketSellOrder>()));
  gh.factory<_i509.BasketSellTransactionsCubit>(() =>
      _i509.BasketSellTransactionsCubit(gh<_i328.GetBasketSellTransactions>()));
  gh.factory<_i510.BasketSipOrderCubit>(
      () => _i510.BasketSipOrderCubit(gh<_i264.CreateBasketSipOrder>()));
  gh.factory<_i511.CartLumpsumPurchaseCubit>(() =>
      _i511.CartLumpsumPurchaseCubit(gh<_i409.InitiateCartLumpsumPurchase>()));
  gh.factory<_i512.CartSipPurchaseCubit>(
      () => _i512.CartSipPurchaseCubit(gh<_i410.InitiateCartSipPurchase>()));
  gh.factory<_i513.ClearCartCubit>(
      () => _i513.ClearCartCubit(gh<_i256.ClearCartFunds>()));
  gh.factory<_i514.ConfirmPanCubit>(() => _i514.ConfirmPanCubit(
        gh<_i257.ConfirmPan>(),
        gh<_i360.GetKycData>(),
        gh<_i12.LoadingCubit>(),
      ));
  gh.factory<_i515.CreateGoalInvestementsCubit>(() =>
      _i515.CreateGoalInvestementsCubit(gh<_i269.CreateGoalInvestment>()));
  gh.factory<_i516.CreateRedeemOrderCubit>(
      () => _i516.CreateRedeemOrderCubit(gh<_i280.CreateRedemptionOrder>()));
  gh.factory<_i517.DeleteMandateCubit>(
      () => _i517.DeleteMandateCubit(gh<_i296.DeleteUserMandate>()));
  gh.factory<_i518.DeliveryAddressCubit>(
      () => _i518.DeliveryAddressCubit(gh<_i338.GetDeliveryAddressList>()));
  gh.factory<_i519.ESignCubit>(() => _i519.ESignCubit(gh<_i301.ESignSubmit>()));
  gh.factory<_i520.ExploreDIYDataCubit>(
      () => _i520.ExploreDIYDataCubit(gh<_i340.GetExploreDIYData>()));
  gh.factory<_i521.ForgotMPinCubit>(() => _i521.ForgotMPinCubit(
        gh<_i309.ForgotMPinGenerateOtp>(),
        gh<_i310.ForgotMPinVerifyOtp>(),
      ));
  gh.factory<_i522.FpFundDetailsCubit>(
      () => _i522.FpFundDetailsCubit(gh<_i341.GetFpFundDetails>()));
  gh.factory<_i523.FundDetailsCubit>(
      () => _i523.FundDetailsCubit(gh<_i379.GetMutualFundDetail>()));
  gh.factory<_i524.FundHoldingsCubit>(
      () => _i524.FundHoldingsCubit(gh<_i342.GetFundHoldings>()));
  gh.factory<_i525.GenerateCapitalGainsFileCubit>(() =>
      _i525.GenerateCapitalGainsFileCubit(
          gh<_i313.GenereteCapitalGainsFile>()));
  gh.factory<_i526.GenerateRetirementOtpCubit>(
      () => _i526.GenerateRetirementOtpCubit(gh<_i384.GetReterementOTP>()));
  gh.factory<_i527.GetBankByIfscCubit>(
      () => _i527.GetBankByIfscCubit(gh<_i319.GetBankDetailsByIfscCode>()));
  gh.factory<_i528.GetFundByIsinCubit>(
      () => _i528.GetFundByIsinCubit(gh<_i378.GetMutualFundByIsin>()));
  gh.factory<_i529.GetFundBySubcategoryCubit>(
      () => _i529.GetFundBySubcategoryCubit(gh<_i345.GetFundsBySubCategory>()));
  gh.factory<_i530.GetFundCubit>(
      () => _i530.GetFundCubit(gh<_i380.GetMutualFunds>()));
  gh.factory<_i531.GetGoalDetailsCubit>(
      () => _i531.GetGoalDetailsCubit(gh<_i350.GetGoalsDetails>()));
  gh.factory<_i532.GetInitiateImportLoansCubit>(() =>
      _i532.GetInitiateImportLoansCubit(gh<_i354.GetInititateImportLoans>()));
  gh.factory<_i533.GetPinCodeDataCubit>(
      () => _i533.GetPinCodeDataCubit(gh<_i382.GetPincodeData>()));
  gh.factory<_i534.GetPrimaryBankCubit>(
      () => _i534.GetPrimaryBankCubit(gh<_i406.GetUserPrimaryBank>()));
  gh.factory<_i535.UpdateBankIfscCubit>(() => _i535.UpdateBankIfscCubit(
        gh<_i12.LoadingCubit>(),
        gh<_i189.UpdateInvestorAccount>(),
        gh<_i471.UpdateProfileBankIfsc>(),
      ));
  return getIt;
}

class _$InjectionModule extends _i536.InjectionModule {}
