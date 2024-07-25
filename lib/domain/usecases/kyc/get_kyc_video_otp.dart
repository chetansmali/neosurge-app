import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/kyc_video_otp_response_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class GetKycVideoOtp extends UseCase<KycVideoOtpResponseModel, NoParams> {
  final KycRepository _kycRepository;

  GetKycVideoOtp(this._kycRepository);

  @override
  Future<Either<AppError, KycVideoOtpResponseModel>> call(
          NoParams params) async =>
      await _kycRepository.getKycVideoOtp();
}
