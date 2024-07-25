import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/digital_gold/create_order_response_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/digital_gold/create_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/digital_gold_repository.dart';

@injectable
class CreateOrder extends UseCase<CreateOrderResponseModel, CreateOrderParams> {
  final DigitalGoldRepository _digitalGoldRepository;

  CreateOrder(this._digitalGoldRepository);

  @override
  Future<Either<AppError, CreateOrderResponseModel>> call(
          CreateOrderParams params) async =>
      await _digitalGoldRepository.createOrder(params.toJson());
}
