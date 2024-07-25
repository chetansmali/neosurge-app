import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/assisted_service/verify_assisted_service_pin_response.dart';
import '../../entities/app_error.dart';

import '../../entities/params/assisted_service/verify_assisted_service_pin_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class VerifyAssistedServicePin extends UseCase<VerifyAssistedServicePinResponse,
    VerifyAssistedServicePinParams> {
  final AssistedServiceRepository _repository;

  VerifyAssistedServicePin(this._repository);

  @override
  Future<Either<AppError, VerifyAssistedServicePinResponse>> call(
      VerifyAssistedServicePinParams params) =>
      _repository.verifyAssistedServicePin(params.toJson());
}
