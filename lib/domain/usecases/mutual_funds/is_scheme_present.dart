import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/is_scheme_present_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class IsSchemePresent extends UseCase<void, IsSchemePresentParams> {
  final MutualFundRepository _mutualFundRepository;

  IsSchemePresent(this._mutualFundRepository);

  @override
  Future<Either<AppError, bool>> call(
    IsSchemePresentParams params,
  ) =>
      _mutualFundRepository.isSchemePresent(params.toJson());
}
