import 'package:dartz/dartz.dart';
import '../../data/models/import_external_funds/account_details_response.dart';
import '../../data/models/import_external_funds/broker_holdings_fund_response.dart';
import '../../data/models/import_external_funds/imported_holding_response.dart';
import '../../data/models/import_external_funds/initialise_transaction_response.dart';
import '../../data/models/import_external_funds/portfolio_analysis_response.dart';
import '../../data/models/import_external_funds/validate_transaction_response.dart';
import '../entities/app_error.dart';

abstract class ExternalFundRepository {
  Future<Either<AppError, AccountDetailsResponse>> getUserAccountDetails(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, InitialiseTransactionReposnse>> initialiseTransaction(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, ValidateTransactionResponse>> validateTransaction(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, ImportedHoldingResponse>> getImportedUserHolding(
    Map<String, dynamic> params,
  );

  Future<Either<AppError, List<BrokerHoldingsFund>>> getBrokerHoldingsFund(
    Map<String, dynamic> json,
  );

  Future<Either<AppError, PortfolioAnalysisResponse>> getPortfolioAnalysis(
    int params,
  );
}
