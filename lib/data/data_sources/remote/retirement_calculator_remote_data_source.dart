import 'package:injectable/injectable.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../models/retirement_calculator/generate_retirement_OTP_model.dart';
import '../../models/retirement_calculator/retirement_inflation_calculator_model.dart';
import '../../models/retirement_calculator/retirement_passbook_model.dart';
import '../../models/retirement_calculator/returement_corpus_model.dart';
import '../../models/retirement_calculator/submit_retirement_OTP_model.dart';

abstract class RetirementCalculatorRemoteDataSource {
  Future<GenerateRetirementOTPModel> generateretirementOTP(
      Map<String, dynamic> params);

  Future<SubmitRetirementOTPModel> submitretirementOTP(
      Map<String, dynamic> params);

  Future<RetirementCorpusModel> retirementCorpus(Map<String, dynamic> params);

  Future<RetirementInflationCalculatorModel> retirementInflation(
      Map<String, dynamic> params);

  Future<RetirementPassbookModel> retirementPassbook(
      Map<String, dynamic> params);
}

@LazySingleton(as: RetirementCalculatorRemoteDataSource)
class RetirementCalculatorRemoteDataSourceImpl
    implements RetirementCalculatorRemoteDataSource {
  final ApiClient _client;

  RetirementCalculatorRemoteDataSourceImpl(this._client);

  @override
  Future<GenerateRetirementOTPModel> generateretirementOTP(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.GenerateRetirementOTP,
        params: params, extractData: false);
    return GenerateRetirementOTPModel.fromJson(response);
  }

  @override
  Future<SubmitRetirementOTPModel> submitretirementOTP(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.SubmitRetirementOTP,
        params: params, extractData: false);
    return SubmitRetirementOTPModel.fromJson(response);
  }

  @override
  Future<RetirementCorpusModel> retirementCorpus(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.retirementCorpus,
        params: params, extractData: false);
    return RetirementCorpusModel.fromJson(response);
  }

  @override
  Future<RetirementInflationCalculatorModel> retirementInflation(
      Map<String, dynamic> params) async {
    final response = await _client.post(
        ApiConstants.retirementInflationCalculator,
        params: params,
        extractData: false);
    return RetirementInflationCalculatorModel.fromJson(response);
  }

  @override
  Future<RetirementPassbookModel> retirementPassbook(
      Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.retirementPassbook,
        params: params, extractData: false);
    return RetirementPassbookModel.fromJson(response);
  }
}
