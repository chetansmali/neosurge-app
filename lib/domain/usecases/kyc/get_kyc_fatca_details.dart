import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/get_kyc_fatca_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class GetKycFatcaDetails extends UseCase<GetKycFatcaDetailsModel, NoParams> {
  final KycRepository _kycRepository;

  GetKycFatcaDetails(this._kycRepository);

  @override
  Future<Either<AppError, GetKycFatcaDetailsModel>> call(
          NoParams params) async =>
      await _kycRepository.getKycFatcaDetails();
}
