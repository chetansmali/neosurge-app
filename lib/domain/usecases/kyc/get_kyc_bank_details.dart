import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/get_kyc_bank_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class GetKycBankDetails extends UseCase<GetKycBankDetailsModel, NoParams> {
  final KycRepository _kycRepository;

  GetKycBankDetails(this._kycRepository);

  @override
  Future<Either<AppError, GetKycBankDetailsModel>> call(
          NoParams params) async =>
      await _kycRepository.getKycBankDetails();
}
