import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../models/assisted_service/assisted_service_details_response.dart';
import '../../models/assisted_service/invest_suggested_funds_response.dart';
import '../../models/assisted_service/question.dart';
import '../../models/assisted_service/suggested_fund.dart';
import '../../models/assisted_service/unlock_assisted_service_response.dart';
import '../../models/assisted_service/verify_assisted_service_pin_response.dart';
import '../../models/initiate_payment_response.dart';
import '../../models/mutual_funds/fund.dart';
import '../../models/mutual_funds/mf_order.dart';
import '../../models/mutual_funds/user_mf_holding.dart';
import '../../models/user/user.dart';

abstract class AssistedServiceRemoteDataSource {
  Future<List<Question>> getQuestions();

  Future<void> submitChoices(Map<String, dynamic> params);

  Future<List<SuggestedFund>> getSuggestedFunds(Map<String, dynamic> params);

  Future<InvestSuggestedFundsResponse> investSuggestedFunds(
      Map<String, dynamic> params);

  Future<InitiatePaymentResponse> initiateSuggestedFundsPayment(
      Map<String, dynamic> params);

  Future<User> postPayment(Map<String, dynamic> params);

  Future<UnlockAssistedServiceResponse> unlockAssistedService(
      Map<String, dynamic> params);

  Future<VerifyAssistedServicePinResponse> verifyAssistedServicePin(
      Map<String, dynamic> params);

  Future<AssistedServiceDetailsResponse> getAssistedServiceDetails();

  Future<UserMfHoldings?> getAssistedHoldings(Map<String, dynamic> params);

  Future<List<Fund>> getSwitchFunds(Map<String, dynamic> params);

  Future<List<MfOrder>> getAssistedOrders(Map<String, dynamic> params);
}

@LazySingleton(as: AssistedServiceRemoteDataSource)
class AssistedServiceRemoteDataSourceImpl
    implements AssistedServiceRemoteDataSource {
  final ApiClient _client;

  AssistedServiceRemoteDataSourceImpl(this._client);

  @override
  Future<List<Question>> getQuestions() async {
    final response = await _client.get(ApiConstants.getQuestionsEndPoint);
    return (response as List).map((e) => Question.fromJson(e)).toList();
  }

  @override
  Future<void> submitChoices(Map<String, dynamic> params) async {
    return await _client.post(ApiConstants.submitChoicesEndPoint,
        params: params);
  }

  @override
  Future<List<SuggestedFund>> getSuggestedFunds(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.getSuggestedFundsEndPoint,
        queryParams: params);
    return (response as List).map((e) => SuggestedFund.fromJson(e)).toList();
  }

  @override
  Future<InvestSuggestedFundsResponse> investSuggestedFunds(
      Map<String, dynamic> params) async {
    final res = await _client.post(ApiConstants.investSuggestedFundsEndPoint,
        params: params);
    final fundIds = List<int>.from(res);
    return InvestSuggestedFundsResponse(ids: fundIds);
  }

  @override
  Future<User> postPayment(Map<String, dynamic> params) async {
    final res = await _client.post(
        ApiConstants.verifyAssistedServicePaymentEndPoint,
        params: params);
    return User.fromJson(res['userDTO']);
  }

  @override
  Future<UnlockAssistedServiceResponse> unlockAssistedService(
      Map<String, dynamic> params) async {
    final res = await _client.post(ApiConstants.unlockAssistedServiceEndPoint,
        params: params);
    return UnlockAssistedServiceResponse.fromJson(res);
  }

  @override
  Future<AssistedServiceDetailsResponse> getAssistedServiceDetails() async {
    final res =
        await _client.get(ApiConstants.getAssistedServiceDetailsEndPoint);
    return AssistedServiceDetailsResponse.fromJson(res);
  }

  @override
  Future<UserMfHoldings?> getAssistedHoldings(
      Map<String, dynamic> params) async {
    final res = await _client.get(ApiConstants.getAssistedHoldingsEndPoint,
        queryParameters: params);

    return res == null ? res : UserMfHoldings.fromJson(res);
  }

  @override
  Future<List<Fund>> getSwitchFunds(Map<String, dynamic> params) async {
    final res = await _client.post(ApiConstants.getAssistedSwitchFundsEndPoint,
        queryParams: params);
    return (res as List).map((e) => Fund.fromJson(e)).toList();
  }

  @override
  Future<InitiatePaymentResponse> initiateSuggestedFundsPayment(
      Map<String, dynamic> params) async {
    final res = await _client.post(
        ApiConstants.initiatePaymentSuggestedFundsEndPoint,
        params: params);
    return InitiatePaymentResponse.fromJson(res);
  }

  @override
  Future<List<MfOrder>> getAssistedOrders(Map<String, dynamic> params) async {
    final res = await _client.get(ApiConstants.getAssistedOrdersEndPoint,
        queryParameters: params);
    return (res as List).map((e) => MfOrder.fromJson(e)).toList();
  }

  @override
  Future<VerifyAssistedServicePinResponse> verifyAssistedServicePin(
      Map<String, dynamic> params) async {
    final res = await _client.post(
      ApiConstants.verifyAssistedServicePin,
      params: params,
    );
    return VerifyAssistedServicePinResponse.fromJson(res);
  }
}
