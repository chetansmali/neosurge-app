import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/entities/digital_gold/digital_gold_graph_response_entity.dart';
import '../../domain/repositories/digital_gold_repository.dart';
import '../data_sources/remote/digital_gold_remote_data_source.dart';
import '../models/digital_gold/checkout_delivery_response_model.dart';
import '../models/digital_gold/checkout_rates_model.dart';
import '../models/digital_gold/create_order_response_model.dart';
import '../models/digital_gold/delivery_product_model.dart';
import '../models/digital_gold/dg_delivery_transaction_response_model.dart';
import '../models/digital_gold/dg_transaction_response_model.dart';
import '../models/digital_gold/gold_silver_rates_model.dart';
import '../models/digital_gold/gold_user.dart';

@LazySingleton(as: DigitalGoldRepository)
class DigitalGoldRepositoryImpl implements DigitalGoldRepository {
  final DigitalGoldRemoteDataSource _digitalGoldRemoteDataSource;

  DigitalGoldRepositoryImpl(this._digitalGoldRemoteDataSource);

  @override
  Future<Either<AppError, List<DigitalGoldGraphResponse>>>
      getDigitalGoldGraphData() async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.getDigitalGoldGraphValues());
  }

  @override
  Future<Either<AppError, GoldSilverRatesModel>> getGoldSilverRates() async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.getGoldSilverRates());
  }

  @override
  Future<Either<AppError, CheckoutRatesModel>> getCheckoutRates(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.getCheckoutRates(params));
  }

  @override
  Future<Either<AppError, CreateOrderResponseModel>> createOrder(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.createOrder(params));
  }

  @override
  Future<Either<AppError, void>> postPayment(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.postPayment(params));
  }

  @override
  Future<Either<AppError, GoldUser>> getGoldUser() async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.getGoldUser());
  }

  @override
  Future<Either<AppError, List<DeliveryProductModel>>>
      getDeliveryProductsByMetalType(Map<String, dynamic> params) async {
    return ApiCallWithError.call(() =>
        _digitalGoldRemoteDataSource.getDeliveryProductsByMetalType(params));
  }

  @override
  Future<Either<AppError, void>> sellGoldSilver(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.sellGoldSilver(params));
  }

  @override
  Future<Either<AppError, void>> acceptTerms() async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.acceptTerms());
  }

  @override
  Future<Either<AppError, void>> createGoldUser() async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.createGoldUser());
  }

  @override
  Future<Either<AppError, CheckoutDeliveryResponseModel>> checkOutDeliveryOrder(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.checkOutDeliveryOrder(params));
  }

  @override
  Future<Either<AppError, void>> createGoldKYC() async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.createGoldKYC());
  }

  @override
  Future<Either<AppError, List<DgDeliveryTransactionResponseModel>>>
      getDgDeliveryTransactions(Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.getDgDeliveryTransactions(params));
  }

  @override
  Future<Either<AppError, List<DgTransactionResponseModel>>> getDgTransactions(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.getDGTransactions(params));
  }

  @override
  Future<Either<AppError, void>> addBankAccount() async {
    return ApiCallWithError.call(
        () => _digitalGoldRemoteDataSource.addBankAccount());
  }
}
