import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/smart_filtering/smart_filter_indices_details.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_smart_watchlist/fetch_indices_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetSmartIndices
    extends UseCase<SmartFilterIndicesDetails, FetchIndicesParams> {
  final EquityRespository equityRespository;

  GetSmartIndices(this.equityRespository);
  @override
  Future<Either<AppError, SmartFilterIndicesDetails>> call(
          FetchIndicesParams params) =>
      equityRespository.fetchSmartIndices(params.toJson());
}
