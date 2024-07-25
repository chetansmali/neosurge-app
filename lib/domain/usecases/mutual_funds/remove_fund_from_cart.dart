import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/remove_fund_from_cart_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class RemoveFundFromCart extends UseCase<void, RemoveFundFromCartParams> {
  final MutualFundRepository _mutualFundRepository;

  RemoveFundFromCart(this._mutualFundRepository);

  @override
  Future<Either<AppError, void>> call(RemoveFundFromCartParams params) =>
      _mutualFundRepository.removeFundFromCart(
        params.toJson(),
      );
}
