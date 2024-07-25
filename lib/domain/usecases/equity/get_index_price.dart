import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/equity/equity_explore/index_price.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_explore/index_price_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetIndexPrice extends UseCase<List<IndexPriceModel>,IndexPriceParams>{
  final EquityRespository equityRespository;

  GetIndexPrice(this.equityRespository);

  @override
  Future<Either<AppError,List<IndexPriceModel>>> call(IndexPriceParams params) =>
      equityRespository.getIndexPrice(params.toJson());
}