import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_sell_transaction.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_sell_transaction_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class GetBasketSellTransactions
    extends UseCase<List<BasketSellTransaction>, BasketSellTransactionParams> {
  final NeobasketsRepository _neobasketsRepository;

  GetBasketSellTransactions(this._neobasketsRepository);

  @override
  Future<Either<AppError, List<BasketSellTransaction>>> call(
          BasketSellTransactionParams params) =>
      _neobasketsRepository.getBasketSellTransactions(params.toJson());
}
