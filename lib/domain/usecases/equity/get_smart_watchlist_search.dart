import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_smart_watchlist/smart_watchlist_search_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_smart_watchlist/smart_watchlist_search_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetSmartWatchlistSearch extends UseCase<List<SmartWatchlistSearchModel>,
    SmartWatchlistSearchParams> {
  final EquityRespository _equityRespository;
  GetSmartWatchlistSearch(this._equityRespository);

  @override
  Future<Either<AppError, List<SmartWatchlistSearchModel>>> call(
          SmartWatchlistSearchParams params) =>
      _equityRespository.getSmartWatchlistSearch(params.toJson());
}
