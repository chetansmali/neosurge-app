import 'package:injectable/injectable.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../../domain/entities/enums.dart';
import '../../models/equity/buy_sell_transaction.dart';
import '../../models/equity/equity_explore/all_stocks.dart';
import '../../models/equity/equity_explore/index_price.dart';
import '../../models/equity/equity_explore/stock_chart.dart';
import '../../models/equity/equity_explore/stock_details.dart';
import '../../models/equity/equity_order/equity_orders_model.dart';
import '../../models/equity/equity_portfolio/get_smallcase_fund.dart';
import '../../models/equity/equity_portfolio/portfolio_holdings.dart';
import '../../models/equity/equity_portfolio/portfolio_positions.dart';
import '../../models/equity/equity_search/global_search_model.dart';
import '../../models/equity/equity_smart_watchlist/alert_details_model.dart';
import '../../models/equity/equity_smart_watchlist/create_alert_model.dart';
import '../../models/equity/equity_smart_watchlist/get_users_alert.dart';
import '../../models/equity/equity_smart_watchlist/remove_alert_model.dart';
import '../../models/equity/equity_smart_watchlist/smart_watchlist_holdings.dart';
import '../../models/equity/equity_smart_watchlist/smart_watchlist_search_model.dart';
import '../../models/equity/equity_watchllist/add_stock_watchlist_model.dart';
import '../../models/equity/equity_watchllist/create_watchlist_model.dart';
import '../../models/equity/equity_watchllist/delete_symbol.dart';
import '../../models/equity/equity_watchllist/delete_watchlist.dart';
import '../../models/equity/equity_watchllist/get_all_watchlist_model.dart';
import '../../models/equity/equity_watchllist/get_watchlist_stock.dart';
import '../../models/equity/etf_stocks.dart';
import '../../models/equity/login/equity_brokers.dart';
import '../../models/equity/login/get_transaction_model.dart';
import '../../models/equity/login/smallcase_login.dart';
import '../../models/equity/smart_filtering/business_houses_model.dart';
import '../../models/equity/smart_filtering/filter_by_sector_industry_details.dart';
import '../../models/equity/smart_filtering/get_sector_industries_details.dart';
import '../../models/equity/smart_filtering/smart_filter_indices_details.dart';
import '../../models/equity/smart_filtering/stocks_by_index_model.dart';
import '../../models/equity/smart_filtering/subsidiaries_model.dart';

abstract class EquityRemoteDataSource {
  Future<StockDetailsModel> getStockDetails(Map<String, dynamic> params);

  Future<List<StockChartModel>> getStockChart(Map<String, dynamic> params);

  Future<List<AllStocksModel>> getStocks(Map<String, dynamic> params);

  Future<List<IndexPriceModel>> getIndexPrice(Map<String, dynamic> params);

  Future<TransactionModel> getTransaction(Map<String, dynamic> params);

  Future<List<BrokersModel>> getBrokers();

  Future<SmallCaseLoginModel> getSmallcaseLogin(Map<String, dynamic> params);

  Future<BuySellTransationModel> getBuySell(Map<String, dynamic> params);

  Future<List<GlobalSearchModel>> getGlobalSearch(Map<String, dynamic> params);

  Future<CreateWatchlistModel> getCreateWatchlist(Map<String, dynamic> params);

  Future<List<GetAllWatchlistModel>> getAllWatchlist();

  Future<AddStockWatchModel> putStockToWatchlist(Map<String, dynamic> params);

  Future<List<WatchlistStocksModel>> getWatchlistStock(
      Map<String, dynamic> params);

  Future<DeleteSymbolModel> deleteWatchlistSymbol(Map<String, dynamic> params);

  Future<DeleteWatchlistModel> deleteWatchlist(Map<String, dynamic> params);

  Future<List<EquityOrderModel>> getOrders(Map<String, dynamic> params);

  Future<PortfolioHoldingsModel> getHoldings(Map<String, dynamic> params);

  Future<PortfolioPositionModel> getPotions(Map<String, dynamic> params);

  Future<GetFundsModel> getSmallcaseFunds(Map<String, dynamic> params);

  Future<GetFundsModel> getEquityHoldingsToken(Map<String, dynamic> params);

  // Smart Filter
  Future<FilterBySectorIndustryDetails> filterBySectorIndustries(
      Map<String, dynamic> params);
  Future<List<GetSectorIndustriesDetails>> getSectorIndustries();

  Future<SmartFilterIndicesDetails> fetchSmartIndices(
      Map<String, dynamic> params);

  Future<StocksByIndexModel> fetchFilterByIndex(Map<String, dynamic> params);

  Future<List<BusinessHouseModel>> getBusinessHouses();

  Future<List<SubsidiaryModel>> getSubsidiaries(Map<String, dynamic> params);

  // ETF
  Future<List<String>> getEtfFundHouses();

  Future<List<ETFStocksModel>> getETFs(Map<String, dynamic> params);

  Future<List<SmartWatchlistSearchModel>> getSmartWatchlistSearch(
      Map<String, dynamic> params);

  Future<List<SmartWatchlistHoldingsModel>> getSmartWatchlistHoldings();

  Future<CreateAlertModel> createAlert(Map<String, dynamic> params);

  Future<GetUserAlertModel> getUsersAlerts(Map<String, dynamic> params);

  Future<RemoveAlertModel> removeAlert(Map<String, dynamic> params);

  Future<AlertDetailsModel> getAlertDetails(Map<String, dynamic> params);
}

@LazySingleton(as: EquityRemoteDataSource)
class EquityRemoteDataSourceImpl implements EquityRemoteDataSource {
  final ApiClient _client;

  EquityRemoteDataSourceImpl(this._client);

  @override
  Future<StockDetailsModel> getStockDetails(Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.equityStockDetails,
        queryParameters: params);
    return StockDetailsModel.fromJson(response);
  }

  @override
  Future<List<StockChartModel>> getStockChart(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.equityStockChart,
        queryParameters: params);
    return StockChartModel.listFromJson(response);
  }

  @override
  Future<List<AllStocksModel>> getStocks(Map<String, dynamic> params) async {
    final response =
        await _client.get(ApiConstants.equityStocks, queryParameters: params);
    return AllStocksModel.listFromJson(response['content']);
  }

  @override
  Future<List<IndexPriceModel>> getIndexPrice(
      Map<String, dynamic> params) async {
    final response =
        await _client.post(ApiConstants.equityIndexPrice, params: params);
    return IndexPriceModel.listFromJson(response);
  }

  @override
  Future<TransactionModel> getTransaction(Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.equityTransactionID,
        params: params, extractData: false);
    return TransactionModel.fromJson(response);
  }

  @override
  Future<List<BrokersModel>> getBrokers() async {
    final response = await _client.get(ApiConstants.equityBrokers);
    return BrokersModel.listFromJson(response);
  }

  @override
  Future<SmallCaseLoginModel> getSmallcaseLogin(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.equitySmallCaseLogin,
        params: params, extractData: false);
    return SmallCaseLoginModel.fromJson(response);
  }

  @override
  Future<BuySellTransationModel> getBuySell(Map<String, dynamic> params) async {
    final respone = await _client.post(ApiConstants.equityBuySell,
        params: params, extractData: false);
    return BuySellTransationModel.fromJson(respone);
  }

  @override
  Future<List<GlobalSearchModel>> getGlobalSearch(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.equityGlobalSearch,
      params: params,
      headerApiKeyType: HeaderApiKeyType.equity,
    );
    return GlobalSearchModel.listFromJson(response);
  }

  @override
  Future<CreateWatchlistModel> getCreateWatchlist(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.equityCreateWatchlist,
      params: params,
      extractData: false,
    );
    return CreateWatchlistModel.fromJson(response['data']);
  }

  @override
  Future<List<GetAllWatchlistModel>> getAllWatchlist() async {
    final response = await _client.get(ApiConstants.equityAllWatchlist);
    return GetAllWatchlistModel.listFromJson(response);
  }

  @override
  Future<AddStockWatchModel> putStockToWatchlist(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.equityAddStockToWatch,
        params: params, extractData: false);
    return AddStockWatchModel.fromJson(response['data']);
  }

  @override
  Future<List<WatchlistStocksModel>> getWatchlistStock(
      Map<String, dynamic> params) async {
    final response = await _client
        .get(ApiConstants.equityGetWatchlistToStock + params.values.join());
    return WatchlistStocksModel.listFromJson(response);
  }

  @override
  Future<DeleteSymbolModel> deleteWatchlistSymbol(
      Map<String, dynamic> params) async {
    final response = await _client.delete(
        '${ApiConstants.equityWatchlistDeleteSymbol}${params['watchlistId']}/deletesymbol/${params['symbolId']}',
        extractData: false);
    return DeleteSymbolModel.fromJson(response);
  }

  @override
  Future<List<EquityOrderModel>> getOrders(Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.equityFetchOrders,
        extractData: false, params: params);
    return EquityOrderModel.listFromJson(response['data']['stockTransactions']);
  }

  @override
  Future<PortfolioHoldingsModel> getHoldings(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.equityGetHoldings,
        queryParameters: params);
    return PortfolioHoldingsModel.fromJson(response);
  }

  @override
  Future<DeleteWatchlistModel> deleteWatchlist(
      Map<String, dynamic> params) async {
    final response = await _client.delete(
        ApiConstants.equityDeleteWatchlist + params['id'].toString(),
        extractData: false);
    return DeleteWatchlistModel.fromJson(response);
  }

  @override
  Future<PortfolioPositionModel> getPotions(Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.equityGetPositions,
        queryParameters: params);
    return PortfolioPositionModel.fromJson(response);
  }

  @override
  Future<GetFundsModel> getSmallcaseFunds(Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.equitySmallcaseFunds,
        params: params, extractData: false);
    return GetFundsModel.fromJson(response);
  }

  //Smart Filter

  @override
  Future<List<GetSectorIndustriesDetails>> getSectorIndustries() async {
    final response =
        await _client.get(ApiConstants.getSectorsIndustries, extractData: true);
    return GetSectorIndustriesDetails.listFromJson(response);
  }

  @override
  Future<FilterBySectorIndustryDetails> filterBySectorIndustries(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.filterBySectorIndustries,
        params: params, extractData: false);
    return FilterBySectorIndustryDetails.fromJson(response);
  }

  @override
  Future<SmartFilterIndicesDetails> fetchSmartIndices(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.fetchSmartFilterIndices,
        queryParameters: params, extractData: true);
    return SmartFilterIndicesDetails.fromJson(response);
  }

  @override
  Future<List<ETFStocksModel>> getETFs(Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.etfStocks,
        queryParameters: params, extractData: true);
    return ETFStocksModel.listFromJson(response['content']);
  }

  @override
  Future<List<SmartWatchlistSearchModel>> getSmartWatchlistSearch(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.equitySmartWatchlistSearch,
        queryParameters: params);
    return SmartWatchlistSearchModel.listFromJson(response);
  }

  @override
  Future<List<SmartWatchlistHoldingsModel>> getSmartWatchlistHoldings() async {
    final response = await _client.get(
      ApiConstants.equitySmartWatchlistHoldings,
    );
    return SmartWatchlistHoldingsModel.listFromJson(response['holdings']);
  }

  @override
  Future<CreateAlertModel> createAlert(Map<String, dynamic> params) async {
    final response =
        await _client.post(ApiConstants.equityCreateAlert, params: params);
    return CreateAlertModel.fromJson(response);
  }

  @override
  Future<GetUserAlertModel> getUsersAlerts(Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.equityUserAlert,
        queryParameters: params);
    return GetUserAlertModel.fromJson(response);
  }

  @override
  Future<RemoveAlertModel> removeAlert(Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.equityDeleteAlert,
        params: params, extractData: false);
    return RemoveAlertModel.fromJson(response);
  }

  @override
  Future<AlertDetailsModel> getAlertDetails(Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.equityAlertDetails,
        queryParameters: params, extractData: false);
    return AlertDetailsModel.fromJson(response);
  }

  @override
  Future<List<BusinessHouseModel>> getBusinessHouses() async {
    final response = await _client.get(ApiConstants.getBusinessHouses,
        queryParameters: null, extractData: true);
    return BusinessHouseModel.listFromJson(response);
  }

  @override
  Future<List<SubsidiaryModel>> getSubsidiaries(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.getSubsidiaries,
        queryParameters: params, extractData: true);
    return SubsidiaryModel.listFromJson(response);
  }

  @override
  Future<StocksByIndexModel> fetchFilterByIndex(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.fetchFilterByIndex,
        queryParameters: params, extractData: true);
    return StocksByIndexModel.fromJson(response);
  }

  @override
  Future<List<String>> getEtfFundHouses() async {
    final response = await _client.get(ApiConstants.getEtfFundHouses,
        queryParameters: null, extractData: true);
    return (response as List<dynamic>).map((e) => e.toString()).toList();
  }

  @override
  Future<GetFundsModel> getEquityHoldingsToken(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.equityHoldingsToken,
        params: params, extractData: true);
    return GetFundsModel(transactionId: response);
  }
}
