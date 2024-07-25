import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_explore/all_stocks.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_explore/all_stocks_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class   GetStocksList extends UseCase<List<AllStocksModel>,AllStocksParams>{
  final EquityRespository _equityRespository;

  GetStocksList(this._equityRespository);

  @override
  Future<Either<AppError,List<AllStocksModel>>> call(AllStocksParams params) =>
      _equityRespository.getStockList(params.toJson());
}