import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/retirement_calculator_repository.dart';
import '../data_sources/remote/retirement_calculator_remote_data_source.dart';
import '../models/retirement_calculator/generate_retirement_OTP_model.dart';
import '../models/retirement_calculator/retirement_inflation_calculator_model.dart';
import '../models/retirement_calculator/retirement_passbook_model.dart';
import '../models/retirement_calculator/returement_corpus_model.dart';
import '../models/retirement_calculator/submit_retirement_OTP_model.dart';

@LazySingleton(as: RetirementCalculatorRepository)
class RetirementCalculatorRepositoryImpl
    implements RetirementCalculatorRepository {
  final RetirementCalculatorRemoteDataSource
      _retirementCalculatorRemoteDataSource;

  RetirementCalculatorRepositoryImpl(
      this._retirementCalculatorRemoteDataSource);

  @override
  Future<Either<AppError, GenerateRetirementOTPModel>> generateretirementOTP(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(() =>
        _retirementCalculatorRemoteDataSource.generateretirementOTP(params));
  }

  @override
  Future<Either<AppError, SubmitRetirementOTPModel>> submitretirementOTP(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(() =>
        _retirementCalculatorRemoteDataSource.submitretirementOTP(params));
  }

  @override
  Future<Either<AppError, RetirementCorpusModel>> retirementCorpus(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _retirementCalculatorRemoteDataSource.retirementCorpus(params));
  }

  @override
  Future<Either<AppError, RetirementInflationCalculatorModel>>
      retirementInflationCalculation(Map<String, dynamic> params) async {
    return await ApiCallWithError.call(() =>
        _retirementCalculatorRemoteDataSource.retirementInflation(params));
  }

  @override
  Future<Either<AppError, RetirementPassbookModel>> retirementPassbookDetails(
      Map<String, dynamic> params) async {
    return await ApiCallWithError.call(
        () => _retirementCalculatorRemoteDataSource.retirementPassbook(params));
  }
}
