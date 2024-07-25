import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_proof_of_address_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadProofOfAddress extends UseCase<bool, UploadProofOfAddressParams> {
  final KycRepository _kycRepository;

  UploadProofOfAddress(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(
          UploadProofOfAddressParams params) async =>
      await _kycRepository.uploadProofOfAddress(await params.toFormData());
}
