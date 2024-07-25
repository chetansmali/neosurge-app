import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/cart/mutual_fund_cart.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetCartLumpsumFunds extends UseCase<MutualFundCart, NoParams> {
  final MutualFundRepository _mutualFundRepository;

  GetCartLumpsumFunds(this._mutualFundRepository);

  @override
  Future<Either<AppError, MutualFundCart>> call(NoParams params) =>
      _mutualFundRepository.getCartLumpsumFunds();
}
