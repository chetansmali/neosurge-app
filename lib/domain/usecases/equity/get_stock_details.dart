import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../entities/app_error.dart';
import '../../repositories/equity_respository.dart';
import '../../../data/models/equity/equity_explore/stock_details.dart';
import '../../entities/params/equity/equity_explore/stock_details_params.dart';
import '../../entities/usecase.dart';

@Injectable()
class GetStockDetail extends UseCase<StockDetailsModel,StockDetailsParams>{
  final EquityRespository _equityRespository;

  GetStockDetail(this._equityRespository);

  @override
  Future<Either<AppError,StockDetailsModel>> call(StockDetailsParams params) =>
      _equityRespository.getStockDetail(params.toJson());

}