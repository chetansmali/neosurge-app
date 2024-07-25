import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/neobaskets/basket_buy_transaction.dart';
import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_buy_transaction_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class GetBasketBuyTransactions
    extends UseCase<List<BasketBuyTransaction>, BasketBuyTransactionParams> {
  final NeobasketsRepository _neobasketsRepository;

  GetBasketBuyTransactions(this._neobasketsRepository);

  @override
  Future<Either<AppError, List<BasketBuyTransaction>>> call(
          BasketBuyTransactionParams params) =>
      _neobasketsRepository.getBasketBuyTransactions(params.toJson());
}
