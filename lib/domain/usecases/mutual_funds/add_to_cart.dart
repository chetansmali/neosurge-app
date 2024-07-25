import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/add_to_cart_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class AddToCart extends UseCase<void, AddToCartParams> {
  final MutualFundRepository _mutualFundRepository;

  AddToCart(this._mutualFundRepository);

  @override
  Future<Either<AppError, void>> call(
    AddToCartParams params,
  ) =>
      _mutualFundRepository.addToCart(params.toJson());
}
