import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/neobaskets/basket_order_transaction.dart';

import '../../entities/app_error.dart';
import '../../entities/params/neobaskets/basket_transaction_detail_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class GetBasketOrderTransactionDetails extends UseCase<
    BasketOrderTransactionDetail, BasketTransactionDetailParams> {
  NeobasketsRepository neobasketsRepository;

  GetBasketOrderTransactionDetails(this.neobasketsRepository);

  @override
  Future<Either<AppError, BasketOrderTransactionDetail>> call(
      BasketTransactionDetailParams params) {
    return neobasketsRepository
        .getBasketOrderTransactionDetail(params.toJson());
  }
}
