import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/upload_address_details_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class UploadAddressDetails extends UseCase<bool, UploadAddressDetailsParams> {
  final KycRepository _kycRepository;

  UploadAddressDetails(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(
          UploadAddressDetailsParams params) async =>
      await _kycRepository.uploadAddressDetails(params.toJson());
}
