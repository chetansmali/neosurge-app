import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_fatca_details_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadFatcaDetails extends UseCase<bool, UploadFatcaDetailsParams> {
  final KycRepository _kycRepository;

  UploadFatcaDetails(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(UploadFatcaDetailsParams params) async =>
      await _kycRepository.uploadFatcaDetails(params.toJson());
}
