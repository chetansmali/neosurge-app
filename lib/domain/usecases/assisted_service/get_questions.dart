import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/assisted_service/question.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/assisted_service_repository.dart';

@injectable
class GetQuestions extends UseCase<List<Question>, NoParams> {
  final AssistedServiceRepository _assistedServiceRepository;

  GetQuestions(this._assistedServiceRepository);

  @override
  Future<Either<AppError, List<Question>>> call(NoParams params) =>
      _assistedServiceRepository.getQuestions();
}
