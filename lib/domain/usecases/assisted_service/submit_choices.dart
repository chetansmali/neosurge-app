import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/assisted_service/submit_choice_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class SubmitChoices extends UseCase<void, SubmitChoiceParams> {
  final AssistedServiceRepository _assistedServiceRepository;

  SubmitChoices(this._assistedServiceRepository);

  @override
  Future<Either<AppError, void>> call(SubmitChoiceParams params) =>
      _assistedServiceRepository.submitChoices(params.toJson());
}
