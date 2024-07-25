import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/sector_allocation.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_sector_allocation_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetSectorAllocation
    extends UseCase<SectorAllocationList, GetSectorAllocationParams> {
  final MutualFundRepository _mutualFundRepository;

  GetSectorAllocation(this._mutualFundRepository);

  @override
  Future<Either<AppError, SectorAllocationList>> call(
      GetSectorAllocationParams params) {
    return _mutualFundRepository.getSectorAllocation(params.toJson());
  }
}
