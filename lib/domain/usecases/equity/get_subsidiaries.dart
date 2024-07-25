import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/smart_filtering/subsidiaries_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/smart_filter_subsidiaries/get_subsidiaries_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetSubsidiaries
    extends UseCase<List<SubsidiaryModel>, GetSubsidiariesParams> {
  final EquityRespository _equityRespository;

  GetSubsidiaries(this._equityRespository);

  @override
  Future<Either<AppError, List<SubsidiaryModel>>> call(
          GetSubsidiariesParams params) =>
      _equityRespository.getSubsidiaries(params.toJson());
}
