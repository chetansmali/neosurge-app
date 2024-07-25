import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/etf_stocks.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/etf_stocks.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetETFList extends UseCase<List<ETFStocksModel>, ETFStocksParams> {
  final EquityRespository _equityRespository;

  GetETFList(this._equityRespository);

  @override
  Future<Either<AppError, List<ETFStocksModel>>> call(ETFStocksParams params) =>
      _equityRespository.getETFs(params.toJson());
}
