import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetETFFundHouses extends UseCase<List<String>, NoParams> {
  final EquityRespository _equityRespository;

  GetETFFundHouses(this._equityRespository);

  @override
  Future<Either<AppError, List<String>>> call(NoParams params) =>
      _equityRespository.getEtfFundHouses();
}
