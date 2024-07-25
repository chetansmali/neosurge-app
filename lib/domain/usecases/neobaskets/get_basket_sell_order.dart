import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_sell_order.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_sell_order_param.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class GetBasketSellOrder
    extends UseCase<List<BasketSellOrder>, BasketSellOrderParam> {
  final NeobasketsRepository _neobasketsRepository;

  GetBasketSellOrder(this._neobasketsRepository);

  @override
  Future<Either<AppError, List<BasketSellOrder>>> call(
    BasketSellOrderParam params,
  ) =>
      _neobasketsRepository.getBasketSellOrder(params.toJson());
}
