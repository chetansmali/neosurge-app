import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/assisted_service/unlock_assisted_service_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/assisted_service/unlock_assisted_service_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class UnlockAssistedService extends UseCase<UnlockAssistedServiceResponse,
    UnlockAssistedServiceParams> {
  final AssistedServiceRepository _repository;

  UnlockAssistedService(this._repository);

  @override
  Future<Either<AppError, UnlockAssistedServiceResponse>> call(
          UnlockAssistedServiceParams params) =>
      _repository.unlockAssistedService(params.toJson());
}
