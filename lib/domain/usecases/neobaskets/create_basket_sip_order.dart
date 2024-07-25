import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_order_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class CreateBasketSipOrder
    extends UseCase<BasketOrderResponse, BasketOrderParams> {
  final NeobasketsRepository _neobasketsRepository;

  CreateBasketSipOrder(
    this._neobasketsRepository,
  );

  @override
  Future<Either<AppError, BasketOrderResponse>> call(
    BasketOrderParams params,
  ) {
    return _neobasketsRepository.basketSipOrder(
      params.toJson(),
    );
  }
}
