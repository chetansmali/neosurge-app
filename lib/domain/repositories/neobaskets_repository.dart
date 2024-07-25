import 'package:dartz/dartz.dart';
import '../../data/models/mutual_funds/create_consent.dart';
import '../../data/models/neobaskets/basket_buy_order.dart';
import '../../data/models/neobaskets/basket_buy_transaction.dart';
import '../../data/models/neobaskets/basket_chart_response.dart';
import '../../data/models/neobaskets/basket_details.dart';

import '../../data/models/neobaskets/basket_lumpsum_order_verify_response.dart';
import '../../data/models/neobaskets/basket_order_response.dart';
import '../../data/models/neobaskets/basket_order_transaction.dart';
import '../../data/models/neobaskets/basket_portfolio_detail_response.dart';
import '../../data/models/neobaskets/basket_portfolio_response.dart';
import '../../data/models/neobaskets/basket_redeem_order_response.dart';
import '../../data/models/neobaskets/basket_sell_order.dart';
import '../../data/models/neobaskets/basket_sell_transaction.dart';
import '../../data/models/neobaskets/basket_sip_order_verify_response.dart';
import '../../data/models/neobaskets/neobaskets_discovery_details.dart';
import '../entities/app_error.dart';

abstract class NeobasketsRepository {
  Future<Either<AppError, List<NeobasketsDiscoveryDetails>>> getNeoBaskets(
      Map<String, dynamic> params);

  Future<Either<AppError, BasketDetailsModel>> getBasketDetails(
      Map<String, dynamic> params);

  Future<Either<AppError, BasketOrderResponse>> basketLumpsumOrder(
      Map<String, dynamic> params);

  Future<Either<AppError, BasketOrderResponse>> basketSipOrder(
      Map<String, dynamic> params);

  Future<Either<AppError, BasketPortfolioResponse>> getBasketPortfolio();

  Future<Either<AppError, BasketPortfolioDetailResponse>>
      getBasketPortfolioDetail(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, CreateConsentModel>> createBasketOrderConsent();

  Future<Either<AppError, BasketLumpsumOrderVerifyResponse>>
      verifyBasketLumpsumConsent(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, BasketSipOrderVerifyResponse>> verifyBasketSipConsent(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, List<BasketBuyTransaction>>> getBasketBuyTransactions(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, List<BasketSellTransaction>>>
      getBasketSellTransactions(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, List<BasketBuyOrder>>> getBasketBuyOrder(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, List<BasketSellOrder>>> getBasketSellOrder(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, BasketOrderTransactionDetail>>
      getBasketOrderTransactionDetail(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, void>> deleteSip(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, BasketRedeemOrderResponse>> createBasketRedeemOrder(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, BasketRedeemOrderResponse>>
      createBasketIndividualRedeemOrder(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, void>> verifyBasketRedeemConsent(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, BasketChartResponse>> getBasketChartData(
    Map<String, dynamic> params,
  );
}
