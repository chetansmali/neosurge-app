import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/cart/initiate_lumpsum_cart_purchase_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/initiate_cart_sip_purchase_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class InitiateCartSipPurchase extends UseCase<InitiateCartPurchaseResponse,
    InitiateCartSipPurchaseParams> {
  final MutualFundRepository _mutualFundRepository;

  InitiateCartSipPurchase(this._mutualFundRepository);

  @override
  Future<Either<AppError, InitiateCartPurchaseResponse>> call(
    InitiateCartSipPurchaseParams params,
  ) =>
      _mutualFundRepository.initiateCartSipPurchase(
        params.toJson(),
      );
}
