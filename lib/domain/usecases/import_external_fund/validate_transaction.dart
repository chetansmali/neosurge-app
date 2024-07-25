import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/import_external_funds/validate_transaction_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/import_external_fund/validate_transaction_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/external_fund_repository.dart';

@injectable
class ValidateTransaction
    extends UseCase<ValidateTransactionResponse, ValidateTransactionParams> {
  final ExternalFundRepository _externalFundRepository;

  ValidateTransaction(this._externalFundRepository);

  @override
  Future<Either<AppError, ValidateTransactionResponse>> call(
      ValidateTransactionParams params) async {
    return await _externalFundRepository.validateTransaction(
      params.toJson(),
    );
  }
}
