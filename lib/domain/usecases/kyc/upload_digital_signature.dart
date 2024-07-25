import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_digital_signature_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadDigitalSignature
    extends UseCase<bool, UploadDigitalSignatureParams> {
  final KycRepository _kycRepository;

  UploadDigitalSignature(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(
          UploadDigitalSignatureParams params) async =>
      await _kycRepository.uploadDigitalSignature(params.toFormData());
}
