import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/digital_gold/delivery_product_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/digital_gold/get_delivery_product_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class GetDeliveryProducts
    extends UseCase<List<DeliveryProductModel>, GetDeliveryProductParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  GetDeliveryProducts(this._digitalGoldRepository);

  @override
  Future<Either<AppError, List<DeliveryProductModel>>> call(
          GetDeliveryProductParams params) =>
      _digitalGoldRepository.getDeliveryProductsByMetalType(params.toJson());
}
