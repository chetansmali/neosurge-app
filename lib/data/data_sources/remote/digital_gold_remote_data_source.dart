import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../../domain/entities/digital_gold/digital_gold_graph_response_entity.dart';
import '../../models/digital_gold/checkout_delivery_response_model.dart';
import '../../models/digital_gold/checkout_rates_model.dart';
import '../../models/digital_gold/create_order_response_model.dart';
import '../../models/digital_gold/delivery_product_model.dart';
import '../../models/digital_gold/dg_delivery_transaction_response_model.dart';
import '../../models/digital_gold/dg_transaction_response_model.dart';
import '../../models/digital_gold/digital_gold_graph_response_model.dart';
import '../../models/digital_gold/gold_silver_rates_model.dart';
import '../../models/digital_gold/gold_user.dart';
import '../../models/user/address_details_model.dart';

abstract class DigitalGoldRemoteDataSource {
  Future<void> createGoldUser();

  Future<void> acceptTerms();

  Future<void> createGoldKYC();

  Future<void> addBankAccount();

  Future<List<DigitalGoldGraphResponse>> getDigitalGoldGraphValues();

  Future<GoldSilverRatesModel> getGoldSilverRates();

  Future<CheckoutRatesModel> getCheckoutRates(Map<String, dynamic> queryParams);

  Future<CheckoutDeliveryResponseModel> checkOutDeliveryOrder(
      Map<String, dynamic> queryParams);

  Future<CreateOrderResponseModel> createOrder(
      Map<String, dynamic> queryParams);

  Future<void> postPayment(Map<String, dynamic> queryParams);

  Future<GoldUser> getGoldUser();

  Future<List<DgTransactionResponseModel>> getDGTransactions(
      Map<String, dynamic> queryParams);

  Future<List<DgDeliveryTransactionResponseModel>> getDgDeliveryTransactions(
      Map<String, dynamic> queryParams);

  Future<List<DeliveryProductModel>> getDeliveryProductsByMetalType(
      Map<String, dynamic> queryParams);

  Future<void> sellGoldSilver(Map<String, dynamic> queryParams);

  Future<List<DGUserState>> getUserStates();

  Future<List<DGUserCity>> getUserCities(Map<String, dynamic> queryParams);
}

@LazySingleton(as: DigitalGoldRemoteDataSource)
class DigitalGoldRemoteDataSourceImpl implements DigitalGoldRemoteDataSource {
  final ApiClient _client;

  DigitalGoldRemoteDataSourceImpl(this._client);

  @override
  Future<List<DigitalGoldGraphResponse>> getDigitalGoldGraphValues() async {
    final response = await _client.get(
      ApiConstants.getGoldGraphDataEndPoint,
    );
    return response
        .map<DigitalGoldGraphResponse>(
            (json) => DigitalGoldGraphResponseModel.fromJson(json))
        .toList();
  }

  @override
  Future<GoldSilverRatesModel> getGoldSilverRates() async {
    final response =
        await _client.post(ApiConstants.getGoldSilverRatesEndPoint);
    return GoldSilverRatesModel.fromJson(response);
  }

  @override
  Future<CheckoutRatesModel> getCheckoutRates(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.getCheckOutRatesEndPoint,
        params: queryParams);
    return CheckoutRatesModel.fromJson(response);
  }

  @override
  Future<CreateOrderResponseModel> createOrder(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.goldCreateOrderEndPoint,
        params: queryParams);
    return CreateOrderResponseModel.fromJson(response);
  }

  @override
  Future<void> postPayment(Map<String, dynamic> queryParams) async {
    await _client.post(ApiConstants.goldPostPaymentEndPoint,
        params: queryParams);
    return;
  }

  @override
  Future<GoldUser> getGoldUser() async {
    final response = await _client.get(ApiConstants.getGoldUserDetailsEndPoint);
    return GoldUser.fromJson(response);
  }

  @override
  Future<List<DeliveryProductModel>> getDeliveryProductsByMetalType(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(
        ApiConstants.getDeliveryProductsByMetalTypeEndPoint,
        queryParameters: queryParams);
    return response
        .map<DeliveryProductModel>(
            (json) => DeliveryProductModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> sellGoldSilver(Map<String, dynamic> queryParams) async {
    await _client.post(ApiConstants.sellGoldSilverEndPoint,
        queryParams: queryParams);
    return;
  }

  @override
  Future<void> acceptTerms() {
    return _client.post(ApiConstants.acceptTermsAndConditionsEndPoint);
  }

  @override
  Future<void> createGoldUser() {
    return _client.post(ApiConstants.createGoldUserEndPoint);
  }

  @override
  Future<List<DGUserState>> getUserStates() async {
    final response = await _client.get(ApiConstants.getDGStatesListEndPoint);
    return response
        .map<DGUserState>((json) => DGUserState.fromJson(json))
        .toList();
  }

  @override
  Future<List<DGUserCity>> getUserCities(
      Map<String, dynamic> queryParams) async {
    final response = await _client.get(
        ApiConstants.getDGCitiesListByStateIDEndPoint,
        queryParameters: queryParams);
    return response
        .map<DGUserCity>((json) => DGUserCity.fromJson(json))
        .toList();
  }

  @override
  Future<CheckoutDeliveryResponseModel> checkOutDeliveryOrder(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(ApiConstants.deliveryCheckoutEndPoint,
        params: queryParams);
    return CheckoutDeliveryResponseModel.fromJson(response);
  }

  @override
  Future<void> createGoldKYC() async {
    return await _client.post(ApiConstants.createGoldKycEndPoint);
  }

  @override
  Future<List<DgTransactionResponseModel>> getDGTransactions(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(
        ApiConstants.getDGTransactionListEndPoint,
        queryParams: queryParams);
    return response
        .map<DgTransactionResponseModel>(
            (json) => DgTransactionResponseModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<DgDeliveryTransactionResponseModel>> getDgDeliveryTransactions(
      Map<String, dynamic> queryParams) async {
    final response = await _client.post(
        ApiConstants.getDGDeliveryTransactionListEndPoint,
        queryParams: queryParams);
    return response
        .map<DgDeliveryTransactionResponseModel>(
            (json) => DgDeliveryTransactionResponseModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> addBankAccount() async {
    return await _client.post(ApiConstants.addDGBankAccountEndPoint);
  }
}
