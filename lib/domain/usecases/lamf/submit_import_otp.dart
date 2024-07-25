import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/lamf/get_import_landing_page_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/lamf/submit_import_otp_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/lamf_repository.dart';

@injectable
class SubmitImportOtp
    extends UseCase<GetImportLandingPageResponse, SubmitImportOtpParams> {
  final LAMFRepository _lAMFRepository;

  SubmitImportOtp(this._lAMFRepository);

  @override
  Future<Either<AppError, GetImportLandingPageResponse>> call(
          SubmitImportOtpParams params) async =>
      _lAMFRepository.submitImportOtp(params.toJson());
}
