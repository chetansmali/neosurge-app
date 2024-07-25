import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_kyc_video_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadKycVideo extends UseCase<bool, UploadKycVideoParams> {
  final KycRepository _kycRepository;

  UploadKycVideo(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(UploadKycVideoParams params) async =>
      await _kycRepository.uploadKycVideo(params.toFormData());
}
