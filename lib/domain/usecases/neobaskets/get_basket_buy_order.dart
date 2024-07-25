import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_buy_order.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_buy_order_param.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class GetBasketBuyOrder
    extends UseCase<List<BasketBuyOrder>, BasketBuyOrderParam> {
  final NeobasketsRepository _neobasketsRepository;

  GetBasketBuyOrder(this._neobasketsRepository);

  @override
  Future<Either<AppError, List<BasketBuyOrder>>> call(
    BasketBuyOrderParam params,
  ) =>
      _neobasketsRepository.getBasketBuyOrder(params.toJson());
}
