import 'package:dartz/dartz.dart';

import '../../data/models/assisted_service/assisted_service_details_response.dart';
import '../../data/models/assisted_service/invest_suggested_funds_response.dart';
import '../../data/models/assisted_service/question.dart';
import '../../data/models/assisted_service/suggested_fund.dart';
import '../../data/models/assisted_service/unlock_assisted_service_response.dart';
import '../../data/models/assisted_service/verify_assisted_service_pin_response.dart';
import '../../data/models/initiate_payment_response.dart';
import '../../data/models/mutual_funds/fund.dart';
import '../../data/models/mutual_funds/mf_order.dart';
import '../../data/models/mutual_funds/user_mf_holding.dart';
import '../../data/models/user/user.dart';
import '../entities/app_error.dart';

abstract class AssistedServiceRepository {
  Future<Either<AppError, List<Question>>> getQuestions();

  Future<Either<AppError, void>> submitChoices(Map<String, dynamic> params);

  Future<Either<AppError, List<SuggestedFund>>> getSuggestedFunds(
      Map<String, dynamic> params);

  Future<Either<AppError, InvestSuggestedFundsResponse>> investSuggestedFunds(
      Map<String, dynamic> params);

  Future<Either<AppError, InitiatePaymentResponse>>
      initiateSuggestedFundsPayment(Map<String, dynamic> params);

  Future<Either<AppError, UnlockAssistedServiceResponse>> unlockAssistedService(
      Map<String, dynamic> params);

  Future<Either<AppError,VerifyAssistedServicePinResponse>> verifyAssistedServicePin(Map<String, dynamic> params);


  Future<Either<AppError, User>> postPayment(Map<String, dynamic> params);

  Future<Either<AppError, AssistedServiceDetailsResponse>>
      getAssistedServiceDetails();

  Future<Either<AppError, UserMfHoldings?>> getAssistedHoldings(
      Map<String, dynamic> params);

  Future<Either<AppError, List<Fund>>> getSwitchFunds(
      Map<String, dynamic> params);

  Future<Either<AppError, List<MfOrder>>> getAssistedOrders(
      Map<String, dynamic> params);
}
