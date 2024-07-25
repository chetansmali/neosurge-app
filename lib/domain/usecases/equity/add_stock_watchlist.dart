import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_watchllist/add_stock_watchlist_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_watchlist/add_stock_watchlist.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class PutStockToWatchlist extends UseCase<AddStockWatchModel,AddStockWatchlistParams>{
  final EquityRespository _equityRespository;

  PutStockToWatchlist(this._equityRespository);
  @override
  Future<Either<AppError,AddStockWatchModel>> call(AddStockWatchlistParams params) =>
      _equityRespository.putStockToWatchlist(params.toJson());
}