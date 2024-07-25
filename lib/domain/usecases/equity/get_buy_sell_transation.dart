import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/buy_sell_transaction.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/buy_sell_transaction.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetBuySellTrasaction extends UseCase<BuySellTransationModel,BuySellTransactionParams>{
  final EquityRespository equityRespository;
  GetBuySellTrasaction(this.equityRespository);

  @override
  Future<Either<AppError,BuySellTransationModel>> call(BuySellTransactionParams params) =>
      equityRespository.getBuySellTransaction(params.toJson());
}