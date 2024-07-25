import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/neobaskets_repository.dart';
import '../data_sources/remote/neobasket_remote_data_source.dart';
import '../models/mutual_funds/create_consent.dart';
import '../models/neobaskets/basket_buy_order.dart';
import '../models/neobaskets/basket_buy_transaction.dart';
import '../models/neobaskets/basket_chart_response.dart';
import '../models/neobaskets/basket_details.dart';
import '../models/neobaskets/basket_lumpsum_order_verify_response.dart';
import '../models/neobaskets/basket_order_response.dart';
import '../models/neobaskets/basket_order_transaction.dart';
import '../models/neobaskets/basket_portfolio_detail_response.dart';
import '../models/neobaskets/basket_portfolio_response.dart';
import '../models/neobaskets/basket_redeem_order_response.dart';
import '../models/neobaskets/basket_sell_order.dart';
import '../models/neobaskets/basket_sell_transaction.dart';
import '../models/neobaskets/basket_sip_order_verify_response.dart';
import '../models/neobaskets/neobaskets_discovery_details.dart';

@LazySingleton(as: NeobasketsRepository)
class NeoBasketRepositoryImpl implements NeobasketsRepository {
  final NeoBasketRemoteDataSource _neoBasketRemoteDataSource;

  NeoBasketRepositoryImpl(this._neoBasketRemoteDataSource);

  @override
  Future<Either<AppError, BasketDetailsModel>> getBasketDetails(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _neoBasketRemoteDataSource.getBasketDetails(params));
  }

  @override
  Future<Either<AppError, List<NeobasketsDiscoveryDetails>>> getNeoBaskets(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
        () => _neoBasketRemoteDataSource.getNeoBaskets(params));
  }

  @override
  Future<Either<AppError, BasketOrderResponse>> basketLumpsumOrder(
    Map<String, dynamic> params,
  ) async {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.basketLumpsumOrder(params),
    );
  }

  @override
  Future<Either<AppError, BasketOrderResponse>> basketSipOrder(
    Map<String, dynamic> params,
  ) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.basketSipOrder(params),
    );
  }

  @override
  Future<Either<AppError, BasketPortfolioResponse>> getBasketPortfolio() async {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.getBasketPortfolio(),
    );
  }

  @override
  Future<Either<AppError, BasketPortfolioDetailResponse>>
      getBasketPortfolioDetail(
    Map<String, dynamic> params,
  ) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.getBasketPortfolioDetail(params),
    );
  }

  @override
  Future<Either<AppError, CreateConsentModel>>
      createBasketOrderConsent() async {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.createBasketOrderConsent(),
    );
  }

  @override
  Future<Either<AppError, BasketLumpsumOrderVerifyResponse>>
      verifyBasketLumpsumConsent(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.verifyBasketLumpsumConsent(params),
    );
  }

  @override
  Future<Either<AppError, BasketSipOrderVerifyResponse>> verifyBasketSipConsent(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.verifyBasketSipConsent(params),
    );
  }

  @override
  Future<Either<AppError, List<BasketBuyTransaction>>> getBasketBuyTransactions(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.getBasketBuyTransactions(params),
    );
  }

  @override
  Future<Either<AppError, List<BasketSellTransaction>>>
      getBasketSellTransactions(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.getBasketSellTransactions(params),
    );
  }

  @override
  Future<Either<AppError, List<BasketBuyOrder>>> getBasketBuyOrder(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.getBasketBuyOrder(params),
    );
  }

  @override
  Future<Either<AppError, List<BasketSellOrder>>> getBasketSellOrder(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.getBasketSellOrder(params),
    );
  }

  @override
  Future<Either<AppError, BasketOrderTransactionDetail>>
      getBasketOrderTransactionDetail(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.getBasketOrderTransactionDetail(params),
    );
  }

  @override
  Future<Either<AppError, void>> deleteSip(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.deleteSip(params),
    );
  }

  @override
  Future<Either<AppError, BasketRedeemOrderResponse>> createBasketRedeemOrder(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.createBasketRedeemOrder(params),
    );
  }

  @override
  Future<Either<AppError, BasketRedeemOrderResponse>>
      createBasketIndividualRedeemOrder(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () =>
          _neoBasketRemoteDataSource.createBasketIndividualRedeemOrder(params),
    );
  }

  @override
  Future<Either<AppError, void>> verifyBasketRedeemConsent(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.verifyBasketRedeemConsent(params),
    );
  }

  @override
  Future<Either<AppError, BasketChartResponse>> getBasketChartData(
    Map<String, dynamic> params,
  ) {
    return ApiCallWithError.call(
      () => _neoBasketRemoteDataSource.getBasketChartData(params),
    );
  }
}
