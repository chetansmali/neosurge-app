import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_cancelled_cheque_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadCancelledCheque extends UseCase<bool, UploadCancelledChequeParams> {
  final KycRepository _kycRepository;

  UploadCancelledCheque(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(
          UploadCancelledChequeParams params) async =>
      await _kycRepository.uploadCancelledCheque(params.toFormData());
}
