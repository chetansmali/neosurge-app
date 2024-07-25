import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_smart_watchlist/smart_watchlist_holdings.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetSmartWatchlistHoldings
    extends UseCase<List<SmartWatchlistHoldingsModel>, NoParams> {
  final EquityRespository _equityRespository;
  GetSmartWatchlistHoldings(this._equityRespository);

  @override
  Future<Either<AppError, List<SmartWatchlistHoldingsModel>>> call(
          NoParams params) =>
      _equityRespository.getSmartWatchlistHoldings();
}
