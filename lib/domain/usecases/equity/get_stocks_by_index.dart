import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/smart_filtering/stocks_by_index_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/filter_by_index_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@Injectable()
class GetStocksByIndex
    extends UseCase<StocksByIndexModel, FilterByIndexParams> {
  final EquityRespository _equityRespository;

  GetStocksByIndex(this._equityRespository);

  @override
  Future<Either<AppError, StocksByIndexModel>> call(
          FilterByIndexParams params) =>
      _equityRespository.fetchFilterByIndexes(params.toJson());
}
