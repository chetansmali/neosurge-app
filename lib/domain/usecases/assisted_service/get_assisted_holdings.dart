import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/user_mf_holding.dart';
import '../../entities/app_error.dart';
import '../../entities/params/user_id_param.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class GetAssistedHoldings extends UseCase<UserMfHoldings?, UserIdParam> {
  final AssistedServiceRepository _repository;

  GetAssistedHoldings(this._repository);

  @override
  Future<Either<AppError, UserMfHoldings?>> call(UserIdParam params) =>
      _repository.getAssistedHoldings(params.toJson());
}
