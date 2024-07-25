import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/digital_gold/create_order_response_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/digital_gold/create_delivery_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class CreateDeliveryOrder
    extends UseCase<CreateOrderResponseModel, CreateDeliveryOrderParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  CreateDeliveryOrder(this._digitalGoldRepository);

  @override
  Future<Either<AppError, CreateOrderResponseModel>> call(
          CreateDeliveryOrderParams params) =>
      _digitalGoldRepository.createOrder(params.toJson());
}
