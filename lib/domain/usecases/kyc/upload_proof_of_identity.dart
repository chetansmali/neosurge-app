import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_proof_of_identity_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadProofOfIdentity extends UseCase<bool, UploadProofOfIdentityParams> {
  final KycRepository _kycRepository;

  UploadProofOfIdentity(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(
          UploadProofOfIdentityParams params) async =>
      await _kycRepository.uploadProofOfIdentity(params.toFormData());
}
