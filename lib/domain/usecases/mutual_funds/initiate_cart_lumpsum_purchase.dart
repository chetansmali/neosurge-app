import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/cart/initiate_lumpsum_cart_purchase_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class InitiateCartLumpsumPurchase
    extends UseCase<InitiateCartPurchaseResponse, NoParams> {
  final MutualFundRepository _mutualFundRepository;

  InitiateCartLumpsumPurchase(this._mutualFundRepository);

  @override
  Future<Either<AppError, InitiateCartPurchaseResponse>> call(
    NoParams params,
  ) =>
      _mutualFundRepository.initiateCartLumpsumPurchase();
}
