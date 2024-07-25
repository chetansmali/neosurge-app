import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/import_external_funds/account_details_response.dart';
import '../../entities/params/import_external_fund/get_account_details_params.dart';

import '../../entities/app_error.dart';

import '../../entities/usecase.dart';
import '../../repositories/external_fund_repository.dart';

@injectable
class GetAccountDetails
    extends UseCase<AccountDetailsResponse, GetAccountDetailsParams> {
  final ExternalFundRepository _externalFundRepository;

  GetAccountDetails(this._externalFundRepository);

  @override
  Future<Either<AppError, AccountDetailsResponse>> call(
    GetAccountDetailsParams params,
  ) async =>
      await _externalFundRepository.getUserAccountDetails(
        params.toJson(),
      );
}
