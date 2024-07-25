import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/api/api_call_with_error.dart';
import '../../domain/repositories/external_fund_repository.dart';

import '../../domain/entities/app_error.dart';
import '../data_sources/remote/external_fund_remote_data_source.dart';
import '../models/import_external_funds/account_details_response.dart';
import '../models/import_external_funds/broker_holdings_fund_response.dart';
import '../models/import_external_funds/imported_holding_response.dart';
import '../models/import_external_funds/initialise_transaction_response.dart';
import '../models/import_external_funds/portfolio_analysis_response.dart';
import '../models/import_external_funds/validate_transaction_response.dart';

@LazySingleton(as: ExternalFundRepository)
class ExternalFundRepositoryImpl implements ExternalFundRepository {
  late final ExternalFundRemoteDataSource _importExternalFundRemoteDataSource;

  ExternalFundRepositoryImpl(this._importExternalFundRemoteDataSource);

  @override
  Future<Either<AppError, AccountDetailsResponse>> getUserAccountDetails(
    Map<String, dynamic> params,
  ) {
    return ApiCallWithError.call(
      () => _importExternalFundRemoteDataSource.getUserAccountDetails(params),
    );
  }

  @override
  Future<Either<AppError, InitialiseTransactionReposnse>> initialiseTransaction(
    Map<String, dynamic> params,
  ) {
    return ApiCallWithError.call(
      () => _importExternalFundRemoteDataSource.initialiseTransaction(params),
    );
  }

  @override
  Future<Either<AppError, ValidateTransactionResponse>> validateTransaction(
    Map<String, dynamic> params,
  ) {
    return ApiCallWithError.call(
      () => _importExternalFundRemoteDataSource.validateTransaction(params),
    );
  }

  @override
  Future<Either<AppError, ImportedHoldingResponse>> getImportedUserHolding(
    Map<String, dynamic> params,
  ) {
    return ApiCallWithError.call(
      () => _importExternalFundRemoteDataSource.getImportedUserHolding(params),
    );
  }

  @override
  Future<Either<AppError, List<BrokerHoldingsFund>>> getBrokerHoldingsFund(
      Map<String, dynamic> json) {
    return ApiCallWithError.call(
      () => _importExternalFundRemoteDataSource.getBrokerHoldingsFund(json),
    );
  }

  @override
  Future<Either<AppError, PortfolioAnalysisResponse>> getPortfolioAnalysis(
    int params,
  ) {
    return ApiCallWithError.call(
      () => _importExternalFundRemoteDataSource.getPortfolioAnalysis(params),
    );
  }
}
