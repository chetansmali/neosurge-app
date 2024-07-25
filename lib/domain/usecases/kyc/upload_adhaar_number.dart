import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_adhaar_number_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadAdhaarNumber extends UseCase<bool, UploadAadhaarNumberParams> {
  final KycRepository _kycRepository;

  UploadAdhaarNumber(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(UploadAadhaarNumberParams params) async =>
      await _kycRepository.uploadAdhaarNumber(params.toJson());
}
