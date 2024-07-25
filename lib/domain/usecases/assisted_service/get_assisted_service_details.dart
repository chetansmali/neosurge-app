import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/assisted_service/assisted_service_details_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class GetAssistedServiceDetails
    extends UseCase<AssistedServiceDetailsResponse, NoParams> {
  final AssistedServiceRepository _repository;

  GetAssistedServiceDetails(this._repository);

  @override
  Future<Either<AppError, AssistedServiceDetailsResponse>> call(
          NoParams params) =>
      _repository.getAssistedServiceDetails();
}
