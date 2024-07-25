import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/digital_gold/dg_delivery_transaction_response_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/digital_gold/get_dg_transaction_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class GetDgDeliveryTransactions extends UseCase<
    List<DgDeliveryTransactionResponseModel>, GetDGTransactionParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  GetDgDeliveryTransactions(this._digitalGoldRepository);

  @override
  Future<Either<AppError, List<DgDeliveryTransactionResponseModel>>> call(
          GetDGTransactionParams params) =>
      _digitalGoldRepository.getDgDeliveryTransactions(params.toJson());
}
