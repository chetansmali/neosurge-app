import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_watchllist/get_all_watchlist_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetUserAllWatchlist
    extends UseCase<List<GetAllWatchlistModel>, NoParams> {
  final EquityRespository _equityRespository;

  GetUserAllWatchlist(this._equityRespository);
  @override
  Future<Either<AppError, List<GetAllWatchlistModel>>> call(params) =>
      _equityRespository.getAllWatchlist();
}
