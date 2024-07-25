import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_bank_details_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadBankDetails extends UseCase<bool, UploadBankDetailsParams> {
  final KycRepository _kycRepository;

  UploadBankDetails(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(UploadBankDetailsParams params) async =>
      await _kycRepository.uploadBankDetails(params.toJson());
}
