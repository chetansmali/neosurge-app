import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_personal_details_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadPersonalDetails extends UseCase<bool, UploadPersonalDetailsParams> {
  final KycRepository _kycRepository;

  UploadPersonalDetails(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(
          UploadPersonalDetailsParams params) async =>
      await _kycRepository.uploadPersonalDetails(params.toJson());
}
