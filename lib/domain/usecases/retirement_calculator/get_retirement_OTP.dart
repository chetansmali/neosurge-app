import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/retirement_calculator/generate_retirement_OTP_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/retirement_calculator/generate_retirement_OTP_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/retirement_calculator_repository.dart';

@injectable
class GetReterementOTP
    extends UseCase<GenerateRetirementOTPModel, GenerateRetirementOTPParams> {
  final RetirementCalculatorRepository _retirementCalculatorRepository;

  GetReterementOTP(this._retirementCalculatorRepository);

  @override
  Future<Either<AppError, GenerateRetirementOTPModel>> call(
          GenerateRetirementOTPParams params) =>
      _retirementCalculatorRepository.generateretirementOTP(params.toJson());
}
