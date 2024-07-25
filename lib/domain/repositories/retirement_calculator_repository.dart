import 'package:dartz/dartz.dart';

import '../../data/models/retirement_calculator/generate_retirement_OTP_model.dart';
import '../../data/models/retirement_calculator/retirement_inflation_calculator_model.dart';
import '../../data/models/retirement_calculator/retirement_passbook_model.dart';
import '../../data/models/retirement_calculator/returement_corpus_model.dart';
import '../../data/models/retirement_calculator/submit_retirement_OTP_model.dart';
import '../entities/app_error.dart';

abstract class RetirementCalculatorRepository {
  Future<Either<AppError, GenerateRetirementOTPModel>> generateretirementOTP(
      Map<String, dynamic> params);

  Future<Either<AppError, SubmitRetirementOTPModel>> submitretirementOTP(
      Map<String, dynamic> params);

  Future<Either<AppError, RetirementCorpusModel>> retirementCorpus(
      Map<String, dynamic> params);

  Future<Either<AppError, RetirementInflationCalculatorModel>>
      retirementInflationCalculation(Map<String, dynamic> params);

  Future<Either<AppError, RetirementPassbookModel>> retirementPassbookDetails(
      Map<String, dynamic> params);
}
