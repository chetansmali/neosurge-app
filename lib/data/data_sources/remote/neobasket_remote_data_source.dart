import 'package:fl_chart/fl_chart.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../models/mutual_funds/create_consent.dart';
import '../../models/neobaskets/basket_buy_order.dart';
import '../../models/neobaskets/basket_buy_transaction.dart';
import '../../models/neobaskets/basket_chart_response.dart';
import '../../models/neobaskets/basket_details.dart';

import '../../models/neobaskets/basket_lumpsum_order_verify_response.dart';
import '../../models/neobaskets/basket_order_response.dart';
import '../../models/neobaskets/basket_order_transaction.dart';
import '../../models/neobaskets/basket_portfolio_detail_response.dart';
import '../../models/neobaskets/basket_portfolio_response.dart';
import '../../models/neobaskets/basket_redeem_order_response.dart';
import '../../models/neobaskets/basket_sell_order.dart';
import '../../models/neobaskets/basket_sell_transaction.dart';
import '../../models/neobaskets/basket_sip_order_verify_response.dart';
import '../../models/neobaskets/neobaskets_discovery_details.dart';

abstract class NeoBasketRemoteDataSource {
  Future<BasketDetailsModel> getBasketDetails(Map<String, dynamic> params);
  Future<List<NeobasketsDiscoveryDetails>> getNeoBaskets(
      Map<String, dynamic> queryParams);

  Future<BasketOrderResponse> basketLumpsumOrder(Map<String, dynamic> params);

  Future<BasketOrderResponse> basketSipOrder(Map<String, dynamic> params);

  Future<BasketPortfolioResponse> getBasketPortfolio();

  Future<BasketPortfolioDetailResponse> getBasketPortfolioDetail(
    Map<String, dynamic> params,
  );

  Future<CreateConsentModel> createBasketOrderConsent();

  Future<BasketLumpsumOrderVerifyResponse> verifyBasketLumpsumConsent(
    Map<String, dynamic> params,
  );
  Future<BasketSipOrderVerifyResponse> verifyBasketSipConsent(
    Map<String, dynamic> params,
  );

  Future<List<BasketBuyTransaction>> getBasketBuyTransactions(
    Map<String, dynamic> params,
  );

  Future<List<BasketSellTransaction>> getBasketSellTransactions(
    Map<String, dynamic> params,
  );

  Future<List<BasketBuyOrder>> getBasketBuyOrder(
    Map<String, dynamic> params,
  );

  Future<List<BasketSellOrder>> getBasketSellOrder(
    Map<String, dynamic> params,
  );

  Future<BasketOrderTransactionDetail> getBasketOrderTransactionDetail(
    Map<String, dynamic> params,
  );

  Future deleteSip(
    Map<String, dynamic> params,
  );

  Future<BasketRedeemOrderResponse> createBasketRedeemOrder(
    Map<String, dynamic> params,
  );

  Future<BasketRedeemOrderResponse> createBasketIndividualRedeemOrder(
    Map<String, dynamic> params,
  );

  Future<void> verifyBasketRedeemConsent(
    Map<String, dynamic> params,
  );

  Future<BasketChartResponse> getBasketChartData(
    Map<String, dynamic> params,
  );
}

@LazySingleton(as: NeoBasketRemoteDataSource)
class NeoBasketRemoteDataSourceImpl implements NeoBasketRemoteDataSource {
  final ApiClient _client;

  NeoBasketRemoteDataSourceImpl(this._client);

  @override
  Future<List<NeobasketsDiscoveryDetails>> getNeoBaskets(
    Map<String, dynamic> queryParams,
  ) async {
    final response = await _client.post(
      ApiConstants.getNeoBaskets,
      params: queryParams,
    );

    return NeobasketsDiscoveryDetails.fromJsonList(response);
  }

  @override
  Future<BasketDetailsModel> getBasketDetails(
    Map<String, dynamic> params,
  ) async {
    final response = await _client.post(
      ApiConstants.basketDetails,
      params: params,
    );

    return BasketDetailsModel.fromJson(response);
  }

  @override
  Future<BasketOrderResponse> basketLumpsumOrder(
    Map<String, dynamic> params,
  ) async {
    final response = await _client.post(
      ApiConstants.basketLumpsumOrder,
      params: params,
      requiresToken: true,
      extractData: false,
    );

    return BasketOrderResponse.fromJson(response);
  }

  @override
  Future<BasketOrderResponse> basketSipOrder(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.basketSipOrder,
      params: params,
      extractData: false,
    );

    return BasketOrderResponse.fromJson(response);
  }

  @override
  Future<BasketPortfolioResponse> getBasketPortfolio() async {
    final response = await _client.get(
      ApiConstants.basketPortfolio,
      extractData: false,
    );

    return BasketPortfolioResponse.fromJson(response);
  }

  @override
  Future<BasketPortfolioDetailResponse> getBasketPortfolioDetail(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.basketPortfolioDetail,
      params: params,
      extractData: false,
    );

    return BasketPortfolioDetailResponse.fromJson(response);
  }

  @override
  Future<CreateConsentModel> createBasketOrderConsent() async {
    final response = await _client.get(
      ApiConstants.createBasketOrderConsent,
    );

    return CreateConsentModel.fromJson(response);
  }

  @override
  Future<BasketLumpsumOrderVerifyResponse> verifyBasketLumpsumConsent(
    Map<String, dynamic> params,
  ) async {
    final response = await _client.post(
      ApiConstants.verifyBasketLumpsumConsent,
      params: params,
      extractData: false,
    );

    return BasketLumpsumOrderVerifyResponse.fromJson(response);
  }

  @override
  Future<BasketSipOrderVerifyResponse> verifyBasketSipConsent(
    Map<String, dynamic> params,
  ) async {
    final response = await _client.post(
      ApiConstants.verifyBasketSipConsent,
      params: params,
      extractData: false,
    );

    return BasketSipOrderVerifyResponse.fromJson(response);
  }

  @override
  Future<List<BasketBuyTransaction>> getBasketBuyTransactions(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.getBasketBuyTransactions,
      params: params,
      extractData: false,
    );

    return BasketBuyTransaction.listFromJson(response['transactions']);
  }

  @override
  Future<List<BasketSellTransaction>> getBasketSellTransactions(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.getBasketSellTransactions,
      params: params,
      extractData: false,
    );

    return BasketSellTransaction.listFromJson(response['transactions']);
  }

  @override
  Future<List<BasketBuyOrder>> getBasketBuyOrder(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.getBasketBuyOrder,
      params: params,
      extractData: false,
    );

    return BasketBuyOrder.listFromJson(
      response['orders'],
    );
  }

  @override
  Future<List<BasketSellOrder>> getBasketSellOrder(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.getBasketSellOrder,
      params: params,
      extractData: false,
    );

    return BasketSellOrder.listFromJson(
      response['orders'],
    );
  }

  @override
  Future<BasketOrderTransactionDetail> getBasketOrderTransactionDetail(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.getTransactionDetail,
      params: params,
      extractData: false,
    );

    return BasketOrderTransactionDetail.fromJson(
      response,
    );
  }

  @override
  Future deleteSip(Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.deleteSip,
      params: params,
      extractData: false,
    );

    return response;
  }

  @override
  Future<BasketRedeemOrderResponse> createBasketRedeemOrder(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.basketRedeemOrder,
      params: params,
      extractData: false,
    );

    return BasketRedeemOrderResponse.fromJson(response);
  }

  @override
  Future<BasketRedeemOrderResponse> createBasketIndividualRedeemOrder(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.basketIndividualRedeemOrder,
      params: params,
      extractData: false,
    );

    return BasketRedeemOrderResponse.fromJson(response);
  }

  @override
  Future verifyBasketRedeemConsent(Map<String, dynamic> params) async {
    return await _client.post(
      ApiConstants.verifyBasketRedeemConsent,
      params: params,
      extractData: false,
    );
  }

  @override
  Future<BasketChartResponse> getBasketChartData(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.getBasketChartData,
      params: params,
      extractData: false,
    );

    return BasketChartResponse(
      basketChartDataList: List<FlSpot>.from(
        response['data'].map((x) {
          return FlSpot(
            DateFormat('yyyy-MM-dd')
                .parse(x['date'].toString())
                .millisecondsSinceEpoch
                .toDouble(),
            x['value'],
          );
        }),
      ),
      returns: response['possibleValue'],
    );
  }
}
