import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/import_external_funds/initialise_transaction_response.dart';
import '../../entities/params/import_external_fund/initialise_transaction_params.dart';
import '../../entities/usecase.dart';

import '../../entities/app_error.dart';
import '../../repositories/external_fund_repository.dart';

@injectable
class InitialiseTransaction extends UseCase<InitialiseTransactionReposnse,
    InitialiseTransactionParams> {
  final ExternalFundRepository _externalFundRepository;

  InitialiseTransaction(this._externalFundRepository);

  @override
  Future<Either<AppError, InitialiseTransactionReposnse>> call(
          InitialiseTransactionParams params) async =>
      await _externalFundRepository.initialiseTransaction(
        params.toJson(),
      );
}
