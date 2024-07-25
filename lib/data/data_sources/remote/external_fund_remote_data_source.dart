import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../../domain/entities/enums.dart';
import '../../models/import_external_funds/account_details_response.dart';
import '../../models/import_external_funds/broker_holdings_fund_response.dart';
import '../../models/import_external_funds/imported_holding_response.dart';
import '../../models/import_external_funds/initialise_transaction_response.dart';
import '../../models/import_external_funds/portfolio_analysis_response.dart';
import '../../models/import_external_funds/validate_transaction_response.dart';

abstract class ExternalFundRemoteDataSource {
  Future<AccountDetailsResponse> getUserAccountDetails(
    Map<String, dynamic> params,
  );

  Future<InitialiseTransactionReposnse> initialiseTransaction(
    Map<String, dynamic> params,
  );

  Future<ValidateTransactionResponse> validateTransaction(
    Map<String, dynamic> params,
  );

  Future<ImportedHoldingResponse> getImportedUserHolding(
    Map<String, dynamic> params,
  );

  Future<List<BrokerHoldingsFund>> getBrokerHoldingsFund(
    Map<String, dynamic> json,
  );

  Future<PortfolioAnalysisResponse> getPortfolioAnalysis(
    int params,
  );
}

@LazySingleton(as: ExternalFundRemoteDataSource)
class ExternalFundRemoteDataSourceImpl implements ExternalFundRemoteDataSource {
  final ApiClient _client;

  ExternalFundRemoteDataSourceImpl(this._client);

  @override
  Future<AccountDetailsResponse> getUserAccountDetails(
    Map<String, dynamic> params,
  ) async {
    final response = await _client.post(
      ApiConstants.getUserAccountDetails,
      params: params,
      requiresToken: false,
      extractData: false,
      headerApiKeyType: HeaderApiKeyType.mutualFundImport,
    );

    return AccountDetailsResponse.fromJson(response);
  }

  @override
  Future<InitialiseTransactionReposnse> initialiseTransaction(
    Map<String, dynamic> params,
  ) async {
    final response = await _client.post(
      ApiConstants.initialiseImportTransaction,
      params: params,
      requiresToken: false,
      extractData: false,
      headerApiKeyType: HeaderApiKeyType.mutualFundImport,
    );

    return InitialiseTransactionReposnse.fromJson(response);
  }

  @override
  Future<ValidateTransactionResponse> validateTransaction(
      Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.validateImportTransaction,
      params: params,
      requiresToken: false,
      extractData: false,
      headerApiKeyType: HeaderApiKeyType.mutualFundImport,
    );

    return ValidateTransactionResponse.fromJson(response);
  }

  @override
  Future<ImportedHoldingResponse> getImportedUserHolding(
    Map<String, dynamic> params,
  ) async {
    final response = await _client.post(
      ApiConstants.getImportedUserHolding,
      params: params,
      requiresToken: false,
      extractData: false,
      headerApiKeyType: HeaderApiKeyType.mutualFundImport,
    );

    return ImportedHoldingResponse.fromJson(response);
  }

  @override
  Future<List<BrokerHoldingsFund>> getBrokerHoldingsFund(
      Map<String, dynamic> json) async {
    final response = await _client.post(
      ApiConstants.getBrokerHoldingsFund,
      params: json,
      requiresToken: false,
      extractData: false,
      headerApiKeyType: HeaderApiKeyType.mutualFundImport,
    );

    return response['holdings']
        .map<BrokerHoldingsFund>(
          (e) => BrokerHoldingsFund.fromJson(e),
        )
        .toList();
  }

  @override
  Future<PortfolioAnalysisResponse> getPortfolioAnalysis(int params) async {
    final response = await _client.post(
      ApiConstants.getPortfolioAnalysis,
      params: {
        'userID': params,
      },
      requiresToken: false,
      extractData: false,
      headerApiKeyType: HeaderApiKeyType.mutualFundImport,
    );

    return PortfolioAnalysisResponse.fromJson(response);
  }
}
