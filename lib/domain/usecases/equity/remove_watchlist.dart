import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_watchllist/delete_watchlist.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_watchlist/delete_watchlist_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class RemoveWatchlist extends UseCase<DeleteWatchlistModel,DeleteWatchlistParams>{
  final EquityRespository equityRespository;

  RemoveWatchlist(this.equityRespository);
  @override
  Future<Either<AppError,DeleteWatchlistModel>> call(DeleteWatchlistParams params) =>
      equityRespository.removeWatchlist(params.toJson());
}