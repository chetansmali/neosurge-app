import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/retirement_calculator/retirement_passbook_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/retirement_calculator/retirement_passbook_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/retirement_calculator_repository.dart';

@injectable
class GetRetirementPassbook
    extends UseCase<RetirementPassbookModel, RetirementPassbookParams> {
  final RetirementCalculatorRepository _retirementCalculatorRepository;

  GetRetirementPassbook(this._retirementCalculatorRepository);

  @override
  Future<Either<AppError, RetirementPassbookModel>> call(
          RetirementPassbookParams params) =>
      _retirementCalculatorRepository
          .retirementPassbookDetails(params.toJson());
}
