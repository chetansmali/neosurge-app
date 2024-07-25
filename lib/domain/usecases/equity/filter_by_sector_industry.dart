import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/smart_filtering/filter_by_sector_industry_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_smart_watchlist/filter_by_sector_industry_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class FilterBySectorIndustry extends UseCase<FilterBySectorIndustryDetails,
    FilterBySectorIndustryParams> {
  final EquityRespository equityRespository;

  FilterBySectorIndustry(this.equityRespository);
  @override
  Future<Either<AppError, FilterBySectorIndustryDetails>> call(
          FilterBySectorIndustryParams params) =>
      equityRespository.filterBySectorIndustries(params.toJson());
}
