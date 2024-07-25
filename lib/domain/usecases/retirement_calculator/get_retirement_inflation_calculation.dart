import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/retirement_calculator/retirement_inflation_calculator_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/retirement_calculator/retirement_inflation_calculator_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/retirement_calculator_repository.dart';

@injectable
class GetRetirementInflationCalculation extends UseCase<
    RetirementInflationCalculatorModel, RetirementInflationCalculatorParams> {
  final RetirementCalculatorRepository _retirementCalculatorRepository;

  GetRetirementInflationCalculation(this._retirementCalculatorRepository);

  @override
  Future<Either<AppError, RetirementInflationCalculatorModel>> call(
          RetirementInflationCalculatorParams params) =>
      _retirementCalculatorRepository
          .retirementInflationCalculation(params.toJson());
}
