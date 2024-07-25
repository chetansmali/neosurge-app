import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_watchllist/get_watchlist_stock.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_watchlist/get_watchlist_symbol.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetWatchlistSymbol extends UseCase<List<WatchlistStocksModel>,GetWatchlistSymbolParams>{
  final EquityRespository equityRespository;

  GetWatchlistSymbol(this.equityRespository);
  @override
  Future<Either<AppError,List<WatchlistStocksModel>>> call(GetWatchlistSymbolParams params) =>
      equityRespository.getWatchlitsSymbol(params.toJson());
}