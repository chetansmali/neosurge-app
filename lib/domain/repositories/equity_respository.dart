import 'package:dartz/dartz.dart';

import '../../data/models/equity/buy_sell_transaction.dart';
import '../../data/models/equity/equity_explore/all_stocks.dart';
import '../../data/models/equity/equity_explore/index_price.dart';
import '../../data/models/equity/equity_explore/stock_chart.dart';
import '../../data/models/equity/equity_explore/stock_details.dart';
import '../../data/models/equity/equity_order/equity_orders_model.dart';
import '../../data/models/equity/equity_portfolio/get_smallcase_fund.dart';
import '../../data/models/equity/equity_portfolio/portfolio_holdings.dart';
import '../../data/models/equity/equity_portfolio/portfolio_positions.dart';
import '../../data/models/equity/equity_search/global_search_model.dart';
import '../../data/models/equity/equity_smart_watchlist/alert_details_model.dart';
import '../../data/models/equity/equity_smart_watchlist/create_alert_model.dart';
import '../../data/models/equity/equity_smart_watchlist/get_users_alert.dart';
import '../../data/models/equity/equity_smart_watchlist/remove_alert_model.dart';
import '../../data/models/equity/equity_smart_watchlist/smart_watchlist_holdings.dart';
import '../../data/models/equity/equity_smart_watchlist/smart_watchlist_search_model.dart';
import '../../data/models/equity/equity_watchllist/add_stock_watchlist_model.dart';
import '../../data/models/equity/equity_watchllist/create_watchlist_model.dart';
import '../../data/models/equity/equity_watchllist/delete_symbol.dart';
import '../../data/models/equity/equity_watchllist/delete_watchlist.dart';
import '../../data/models/equity/equity_watchllist/get_all_watchlist_model.dart';
import '../../data/models/equity/equity_watchllist/get_watchlist_stock.dart';
import '../../data/models/equity/etf_stocks.dart';
import '../../data/models/equity/login/equity_brokers.dart';
import '../../data/models/equity/login/get_transaction_model.dart';
import '../../data/models/equity/login/smallcase_login.dart';
import '../../data/models/equity/smart_filtering/business_houses_model.dart';
import '../../data/models/equity/smart_filtering/filter_by_sector_industry_details.dart';
import '../../data/models/equity/smart_filtering/get_sector_industries_details.dart';
import '../../data/models/equity/smart_filtering/smart_filter_indices_details.dart';
import '../../data/models/equity/smart_filtering/stocks_by_index_model.dart';
import '../../data/models/equity/smart_filtering/subsidiaries_model.dart';
import '../entities/app_error.dart';

abstract class EquityRespository {
  Future<Either<AppError, StockDetailsModel>> getStockDetail(
      Map<String, dynamic> params);

  Future<Either<AppError, List<StockChartModel>>> getStockChart(
      Map<String, dynamic> params);

  Future<Either<AppError, List<AllStocksModel>>> getStockList(
      Map<String, dynamic> params);

  Future<Either<AppError, List<IndexPriceModel>>> getIndexPrice(
      Map<String, dynamic> params);

  Future<Either<AppError, TransactionModel>> getTransactionID(
      Map<String, dynamic> params);

  Future<Either<AppError, List<BrokersModel>>> getBrokers();

  Future<Either<AppError, SmallCaseLoginModel>> getSmallCaseLogin(
      Map<String, dynamic> params);

  Future<Either<AppError, BuySellTransationModel>> getBuySellTransaction(
      Map<String, dynamic> params);

  Future<Either<AppError, List<GlobalSearchModel>>> getGlobalSearch(
      Map<String, dynamic> params);

  Future<Either<AppError, CreateWatchlistModel>> getCreateWatchlist(
      Map<String, dynamic> params);

  Future<Either<AppError, List<GetAllWatchlistModel>>> getAllWatchlist();

  Future<Either<AppError, AddStockWatchModel>> putStockToWatchlist(
      Map<String, dynamic> params);

  Future<Either<AppError, List<WatchlistStocksModel>>> getWatchlitsSymbol(
      Map<String, dynamic> params);

  Future<Either<AppError, DeleteSymbolModel>> removeSymbol(
      Map<String, dynamic> params);

  Future<Either<AppError, List<EquityOrderModel>>> getOrders(
      Map<String, dynamic> params);

  Future<Either<AppError, PortfolioHoldingsModel>> getPortfolioHoldings(
      Map<String, dynamic> params);

  Future<Either<AppError, PortfolioPositionModel>> getPortfolioPositions(
      Map<String, dynamic> params);

  Future<Either<AppError, DeleteWatchlistModel>> removeWatchlist(
      Map<String, dynamic> params);

  Future<Either<AppError, GetFundsModel>> getSmallcaseFunds(
      Map<String, dynamic> params);

  Future<Either<AppError, GetFundsModel>> getEquityHoldingsToken(
      Map<String, dynamic> params);

  // Smart Filter

  Future<Either<AppError, List<GetSectorIndustriesDetails>>>
      getSectorIndustries();

  Future<Either<AppError, FilterBySectorIndustryDetails>>
      filterBySectorIndustries(Map<String, dynamic> params);

  Future<Either<AppError, SmartFilterIndicesDetails>> fetchSmartIndices(
      Map<String, dynamic> params);

  Future<Either<AppError, StocksByIndexModel>> fetchFilterByIndexes(
      Map<String, dynamic> params);

  Future<Either<AppError, List<BusinessHouseModel>>> getBusinessHouses();

  Future<Either<AppError, List<SubsidiaryModel>>> getSubsidiaries(
      Map<String, dynamic> params);

  Future<Either<AppError, List<String>>> getEtfFundHouses();

  Future<Either<AppError, List<ETFStocksModel>>> getETFs(
      Map<String, dynamic> params);

  Future<Either<AppError, List<SmartWatchlistSearchModel>>>
      getSmartWatchlistSearch(Map<String, dynamic> params);

  Future<Either<AppError, List<SmartWatchlistHoldingsModel>>>
      getSmartWatchlistHoldings();

  Future<Either<AppError, CreateAlertModel>> createAlert(
      Map<String, dynamic> params);

  Future<Either<AppError, GetUserAlertModel>> getUserAlert(
      Map<String, dynamic> params);

  Future<Either<AppError, RemoveAlertModel>> removeAlert(
      Map<String, dynamic> params);

  Future<Either<AppError, AlertDetailsModel>> getAlertDetail(
      Map<String, dynamic> params);
}
