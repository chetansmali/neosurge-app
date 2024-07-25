import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_search/global_search_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_search/global_search_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetGobalSearch extends UseCase<List<GlobalSearchModel>,GlobalSearchParams>{
  final EquityRespository _equityRespository;

  GetGobalSearch(this._equityRespository);

  @override
  Future<Either<AppError,List<GlobalSearchModel>>> call(GlobalSearchParams params) =>
      _equityRespository.getGlobalSearch(params.toJson());
}