import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_redeem_order_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_redeem_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class CreateBasketRedeemOrder
    extends UseCase<BasketRedeemOrderResponse, BasketRedeemOrderParams> {
  final NeobasketsRepository _neobasketsRepository;

  CreateBasketRedeemOrder(this._neobasketsRepository);

  @override
  Future<Either<AppError, BasketRedeemOrderResponse>> call(
      BasketRedeemOrderParams params) {
    return _neobasketsRepository.createBasketRedeemOrder(params.toJson());
  }
}
