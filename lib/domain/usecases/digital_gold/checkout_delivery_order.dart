import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/digital_gold/checkout_delivery_response_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/digital_gold/checkout_delivery_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class CheckoutDeliveryOrder extends UseCase<CheckoutDeliveryResponseModel,
    CheckoutDeliveryOrderParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  CheckoutDeliveryOrder(this._digitalGoldRepository);

  @override
  Future<Either<AppError, CheckoutDeliveryResponseModel>> call(
          CheckoutDeliveryOrderParams params) =>
      _digitalGoldRepository.checkOutDeliveryOrder(params.toJson());
}
