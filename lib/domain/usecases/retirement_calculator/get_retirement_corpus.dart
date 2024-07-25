import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/retirement_calculator/returement_corpus_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/retirement_calculator/retirement_corpus_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/retirement_calculator_repository.dart';

@injectable
class GetRetirementCorpus
    extends UseCase<RetirementCorpusModel, RetirementCorpusParams> {
  final RetirementCalculatorRepository _retirementCalculatorRepository;

  GetRetirementCorpus(this._retirementCalculatorRepository);

  @override
  Future<Either<AppError, RetirementCorpusModel>> call(
          RetirementCorpusParams params) =>
      _retirementCalculatorRepository.retirementCorpus(params.toJson());
}
