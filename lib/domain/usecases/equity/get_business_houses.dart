import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/smart_filtering/business_houses_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetBusinessHouses extends UseCase<List<BusinessHouseModel>, NoParams> {
  final EquityRespository _equityRespository;

  GetBusinessHouses(this._equityRespository);

  @override
  Future<Either<AppError, List<BusinessHouseModel>>> call(NoParams params) =>
      _equityRespository.getBusinessHouses();
}
