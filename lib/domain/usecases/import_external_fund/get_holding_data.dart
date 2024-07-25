import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/import_external_funds/imported_holding_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/import_external_fund/get_imported_user_holding_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/external_fund_repository.dart';

@injectable
class GetHoldingData
    extends UseCase<ImportedHoldingResponse, GetImportedUserHoldingParams> {
  final ExternalFundRepository _externalFundRepository;

  GetHoldingData(this._externalFundRepository);
  @override
  Future<Either<AppError, ImportedHoldingResponse>> call(params) async =>
      await _externalFundRepository.getImportedUserHolding(
        params.toJson(),
      );
}
