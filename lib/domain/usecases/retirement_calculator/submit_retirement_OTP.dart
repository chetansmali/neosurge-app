import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/retirement_calculator/submit_retirement_OTP_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/retirement_calculator/submit_retirement_OTP_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/retirement_calculator_repository.dart';

@injectable
class SubmitRetirementOTP
    extends UseCase<SubmitRetirementOTPModel, SubmitRetirementOTPParams> {
  final RetirementCalculatorRepository _retirementCalculatorRepository;

  SubmitRetirementOTP(this._retirementCalculatorRepository);

  @override
  Future<Either<AppError, SubmitRetirementOTPModel>> call(
          SubmitRetirementOTPParams params) =>
      _retirementCalculatorRepository.submitretirementOTP(params.toJson());
}
