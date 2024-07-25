import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/assisted_service_repository.dart';
import '../data_sources/remote/assisted_service_remote_data_source.dart';
import '../models/assisted_service/assisted_service_details_response.dart';
import '../models/assisted_service/invest_suggested_funds_response.dart';
import '../models/assisted_service/question.dart';
import '../models/assisted_service/suggested_fund.dart';
import '../models/assisted_service/unlock_assisted_service_response.dart';
import '../models/assisted_service/verify_assisted_service_pin_response.dart';
import '../models/initiate_payment_response.dart';
import '../models/mutual_funds/fund.dart';
import '../models/mutual_funds/mf_order.dart';
import '../models/mutual_funds/user_mf_holding.dart';
import '../models/user/user.dart';

@LazySingleton(as: AssistedServiceRepository)
class AssistedServiceRepositoryImpl implements AssistedServiceRepository {
  final AssistedServiceRemoteDataSource _assistedServiceRemoteDataSource;

  AssistedServiceRepositoryImpl(this._assistedServiceRemoteDataSource);

  @override
  Future<Either<AppError, List<Question>>> getQuestions() {
    return ApiCallWithError.call(
        () => _assistedServiceRemoteDataSource.getQuestions());
  }

  @override
  Future<Either<AppError, void>> submitChoices(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _assistedServiceRemoteDataSource.submitChoices(params));
  }

  @override
  Future<Either<AppError, List<SuggestedFund>>> getSuggestedFunds(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _assistedServiceRemoteDataSource.getSuggestedFunds(params));
  }

  @override
  Future<Either<AppError, InvestSuggestedFundsResponse>> investSuggestedFunds(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _assistedServiceRemoteDataSource.investSuggestedFunds(params));
  }

  @override
  Future<Either<AppError, User>> postPayment(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _assistedServiceRemoteDataSource.postPayment(params));
  }

  @override
  Future<Either<AppError, UnlockAssistedServiceResponse>> unlockAssistedService(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _assistedServiceRemoteDataSource.unlockAssistedService(params));
  }

  @override
  Future<Either<AppError, AssistedServiceDetailsResponse>>
      getAssistedServiceDetails() {
    return ApiCallWithError.call(
        () => _assistedServiceRemoteDataSource.getAssistedServiceDetails());
  }

  @override
  Future<Either<AppError, UserMfHoldings?>> getAssistedHoldings(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _assistedServiceRemoteDataSource.getAssistedHoldings(params));
  }

  @override
  Future<Either<AppError, List<Fund>>> getSwitchFunds(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _assistedServiceRemoteDataSource.getSwitchFunds(params));
  }

  @override
  Future<Either<AppError, InitiatePaymentResponse>>
      initiateSuggestedFundsPayment(Map<String, dynamic> params) {
    return ApiCallWithError.call(() =>
        _assistedServiceRemoteDataSource.initiateSuggestedFundsPayment(params));
  }

  @override
  Future<Either<AppError, List<MfOrder>>> getAssistedOrders(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
        () => _assistedServiceRemoteDataSource.getAssistedOrders(params));
  }

  @override
  Future<Either<AppError, VerifyAssistedServicePinResponse>> verifyAssistedServicePin(Map<String, dynamic> params) {
    return ApiCallWithError.call(
            () => _assistedServiceRemoteDataSource.verifyAssistedServicePin(params));
  }
}
