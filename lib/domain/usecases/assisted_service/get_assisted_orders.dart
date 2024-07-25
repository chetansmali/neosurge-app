import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/mf_order.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_mf_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class GetAssistedOrders extends UseCase<List<MfOrder>, GetMfOrderParams> {
  final AssistedServiceRepository _assistedServiceRepository;

  GetAssistedOrders(this._assistedServiceRepository);

  @override
  Future<Either<AppError, List<MfOrder>>> call(params) =>
      _assistedServiceRepository.getAssistedOrders(params.toJson());
}
