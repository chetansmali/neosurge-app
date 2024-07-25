import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_selfie_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadSelfie extends UseCase<bool, UploadSelfieParams> {
  final KycRepository _kycRepository;

  UploadSelfie(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(UploadSelfieParams params) async =>
      await _kycRepository.uploadSelfie(await params.toFormData());
}
