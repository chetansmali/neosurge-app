import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_watchllist/delete_symbol.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_watchlist/delete_symbol.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class RemoveWatchlistSymbol extends UseCase<DeleteSymbolModel,DeleteSymbolParams>{
  final EquityRespository equityRespository;

  RemoveWatchlistSymbol(this.equityRespository);
  @override
  Future<Either<AppError,DeleteSymbolModel>> call(DeleteSymbolParams params) =>
      equityRespository.removeSymbol(params.toJson());
}