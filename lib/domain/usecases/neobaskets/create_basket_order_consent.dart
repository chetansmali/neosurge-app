import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/create_consent.dart';
import '../../entities/app_error.dart';
import 'package:dartz/dartz.dart';

import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/neobaskets_repository.dart';

@injectable
class CreateBasketOrderConsent extends UseCase<CreateConsentModel, NoParams> {
  final NeobasketsRepository _neobasketsRepository;

  CreateBasketOrderConsent(this._neobasketsRepository);

  @override
  Future<Either<AppError, CreateConsentModel>> call(NoParams params) =>
      _neobasketsRepository.createBasketOrderConsent();
}
