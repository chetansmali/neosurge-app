import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/clear_cart_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class ClearCartFunds extends UseCase<void, ClearCartParams> {
  final MutualFundRepository _mutualFundRepository;

  ClearCartFunds(this._mutualFundRepository);

  @override
  Future<Either<AppError, void>> call(ClearCartParams params) =>
      _mutualFundRepository.clearCartFunds(
        params.toJson(),
      );
}
