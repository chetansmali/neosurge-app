import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_watchllist/create_watchlist_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_watchlist/create_watchlist_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetCreateWatchlist
    extends UseCase<CreateWatchlistModel, CreateWatchlistParams> {
  final EquityRespository equityRespository;

  GetCreateWatchlist(this.equityRespository);

  @override
  Future<Either<AppError, CreateWatchlistModel>> call(
          CreateWatchlistParams params) =>
      equityRespository.getCreateWatchlist(params.toJson());
}
