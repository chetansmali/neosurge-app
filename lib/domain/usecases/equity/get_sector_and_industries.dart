import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/smart_filtering/get_sector_industries_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetSectorAndIndustries
    extends UseCase<List<GetSectorIndustriesDetails>, NoParams> {
  final EquityRespository equityRespository;

  GetSectorAndIndustries(this.equityRespository);
  @override
  Future<Either<AppError, List<GetSectorIndustriesDetails>>> call(NoParams) =>
      equityRespository.getSectorIndustries();
}
