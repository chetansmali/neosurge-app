import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../data_sources/remote/equity_remote_data_source.dart';
import '../../domain/repositories/equity_respository.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';

import '../models/equity/buy_sell_transaction.dart';
import '../models/equity/equity_explore/all_stocks.dart';
import '../models/equity/equity_explore/index_price.dart';
import '../models/equity/equity_explore/stock_chart.dart';
import '../models/equity/equity_explore/stock_details.dart';
import '../models/equity/equity_order/equity_orders_model.dart';
import '../models/equity/equity_portfolio/get_smallcase_fund.dart';
import '../models/equity/equity_portfolio/portfolio_holdings.dart';
import '../models/equity/equity_portfolio/portfolio_positions.dart';
import '../models/equity/equity_search/global_search_model.dart';
import '../models/equity/equity_smart_watchlist/alert_details_model.dart';
import '../models/equity/equity_smart_watchlist/create_alert_model.dart';
import '../models/equity/equity_smart_watchlist/get_users_alert.dart';
import '../models/equity/equity_smart_watchlist/remove_alert_model.dart';
import '../models/equity/equity_smart_watchlist/smart_watchlist_holdings.dart';
import '../models/equity/equity_smart_watchlist/smart_watchlist_search_model.dart';
import '../models/equity/equity_watchllist/add_stock_watchlist_model.dart';
import '../models/equity/equity_watchllist/create_watchlist_model.dart';
import '../models/equity/equity_watchllist/delete_symbol.dart';
import '../models/equity/equity_watchllist/delete_watchlist.dart';
import '../models/equity/equity_watchllist/get_all_watchlist_model.dart';
import '../models/equity/equity_watchllist/get_watchlist_stock.dart';
import '../models/equity/etf_stocks.dart';
import '../models/equity/login/equity_brokers.dart';
import '../models/equity/login/get_transaction_model.dart';
import '../models/equity/login/smallcase_login.dart';
import '../models/equity/smart_filtering/business_houses_model.dart';
import '../models/equity/smart_filtering/filter_by_sector_industry_details.dart';
import '../models/equity/smart_filtering/get_sector_industries_details.dart';
import '../models/equity/smart_filtering/smart_filter_indices_details.dart';
import '../models/equity/smart_filtering/stocks_by_index_model.dart';
import '../models/equity/smart_filtering/subsidiaries_model.dart';

@LazySingleton(as: EquityRespository)
class EquityRespositoryImpl implements EquityRespository {
  final EquityRemoteDataSource _equityRemoteDataSource;

  const EquityRespositoryImpl(this._equityRemoteDataSource);

  @override
  Future<Either<AppError, StockDetailsModel>> getStockDetail(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getStockDetails(params));
  }

  @override
  Future<Either<AppError, List<StockChartModel>>> getStockChart(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getStockChart(params));
  }

  @override
  Future<Either<AppError, List<AllStocksModel>>> getStockList(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getStocks(params));
  }

  @override
  Future<Either<AppError, List<IndexPriceModel>>> getIndexPrice(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getIndexPrice(params));
  }

  @override
  Future<Either<AppError, TransactionModel>> getTransactionID(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getTransaction(params));
  }

  @override
  Future<Either<AppError, List<BrokersModel>>> getBrokers() async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getBrokers());
  }

  @override
  Future<Either<AppError, SmallCaseLoginModel>> getSmallCaseLogin(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getSmallcaseLogin(params));
  }

  @override
  Future<Either<AppError, BuySellTransationModel>> getBuySellTransaction(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getBuySell(params));
  }

  @override
  Future<Either<AppError, List<GlobalSearchModel>>> getGlobalSearch(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getGlobalSearch(params));
  }

  @override
  Future<Either<AppError, CreateWatchlistModel>> getCreateWatchlist(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getCreateWatchlist(params));
  }

  @override
  Future<Either<AppError, List<GetAllWatchlistModel>>> getAllWatchlist() async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getAllWatchlist());
  }

  @override
  Future<Either<AppError, AddStockWatchModel>> putStockToWatchlist(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.putStockToWatchlist(params));
  }

  @override
  Future<Either<AppError, List<WatchlistStocksModel>>> getWatchlitsSymbol(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getWatchlistStock(params));
  }

  @override
  Future<Either<AppError, DeleteSymbolModel>> removeSymbol(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.deleteWatchlistSymbol(params));
  }

  @override
  Future<Either<AppError, List<EquityOrderModel>>> getOrders(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getOrders(params));
  }

  @override
  Future<Either<AppError, PortfolioHoldingsModel>> getPortfolioHoldings(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getHoldings(params));
  }

  @override
  Future<Either<AppError, DeleteWatchlistModel>> removeWatchlist(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.deleteWatchlist(params));
  }

  @override
  Future<Either<AppError, PortfolioPositionModel>> getPortfolioPositions(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getPotions(params));
  }

  @override
  Future<Either<AppError, GetFundsModel>> getSmallcaseFunds(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getSmallcaseFunds(params));
  }

  // Smart Filter

  @override
  Future<Either<AppError, List<GetSectorIndustriesDetails>>>
      getSectorIndustries() async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getSectorIndustries());
  }

  @override
  Future<Either<AppError, FilterBySectorIndustryDetails>>
      filterBySectorIndustries(Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.filterBySectorIndustries(params));
  }

  @override
  Future<Either<AppError, SmartFilterIndicesDetails>> fetchSmartIndices(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.fetchSmartIndices(params));
  }

  @override
  Future<Either<AppError, List<BusinessHouseModel>>> getBusinessHouses() async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getBusinessHouses());
  }

  @override
  Future<Either<AppError, List<SubsidiaryModel>>> getSubsidiaries(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getSubsidiaries(params));
  }

  @override
  Future<Either<AppError, List<String>>> getEtfFundHouses() async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getEtfFundHouses());
  }

  @override
  Future<Either<AppError, List<ETFStocksModel>>> getETFs(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getETFs(params));
  }

  @override
  Future<Either<AppError, List<SmartWatchlistSearchModel>>>
      getSmartWatchlistSearch(Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _equityRemoteDataSource.getSmartWatchlistSearch(params));
  }

  @override
  Future<Either<AppError, List<SmartWatchlistHoldingsModel>>>
      getSmartWatchlistHoldings() {
    return ApiCallWithError.call(
        () => _equityRemoteDataSource.getSmartWatchlistHoldings());
  }

  @override
  Future<Either<AppError, CreateAlertModel>> createAlert(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _equityRemoteDataSource.createAlert(params));
  }

  @override
  Future<Either<AppError, GetUserAlertModel>> getUserAlert(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _equityRemoteDataSource.getUsersAlerts(params));
  }

  @override
  Future<Either<AppError, RemoveAlertModel>> removeAlert(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _equityRemoteDataSource.removeAlert(params));
  }

  @override
  Future<Either<AppError, AlertDetailsModel>> getAlertDetail(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _equityRemoteDataSource.getAlertDetails(params));
  }

  @override
  Future<Either<AppError, StocksByIndexModel>> fetchFilterByIndexes(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _equityRemoteDataSource.fetchFilterByIndex(params));
  }

  @override
  Future<Either<AppError, GetFundsModel>> getEquityHoldingsToken(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _equityRemoteDataSource.getEquityHoldingsToken(params));
  }
}
