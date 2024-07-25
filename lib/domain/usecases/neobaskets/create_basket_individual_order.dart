import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_redeem_order_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_individual_redeem_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class CreateBasketIndividualOrder
    extends UseCase<BasketRedeemOrderResponse, BasketIndividualRedeemParams> {
  final NeobasketsRepository _neobasketsRepository;
  CreateBasketIndividualOrder(
    this._neobasketsRepository,
  );
  @override
  Future<Either<AppError, BasketRedeemOrderResponse>> call(
      BasketIndividualRedeemParams params) {
    return _neobasketsRepository.createBasketIndividualRedeemOrder(
      params.toJson(),
    );
  }
}
