import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_nominee_details_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadNomineeDetails extends UseCase<bool, UploadNomineeDetailsParams> {
  final KycRepository _kycRepository;

  UploadNomineeDetails(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(
          UploadNomineeDetailsParams params) async =>
      await _kycRepository.uploadNomineeDetails(params.toJson());
}
