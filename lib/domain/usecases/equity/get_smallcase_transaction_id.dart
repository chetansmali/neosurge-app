import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/login/get_transaction_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/ligin/get_transaction.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetTransactionId extends UseCase<TransactionModel,TransactionParams>{
  final EquityRespository equityRespository;
  GetTransactionId(this.equityRespository);

  @override
  Future<Either<AppError,TransactionModel>> call(TransactionParams params) =>
      equityRespository.getTransactionID(params.toJson());
}