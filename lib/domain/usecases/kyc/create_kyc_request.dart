import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/create_kyc_request_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class CreateKycRequest extends UseCase<bool, CreateKycRequestParams> {
  final KycRepository _kycRepository;

  CreateKycRequest(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(CreateKycRequestParams params) async =>
      await _kycRepository.createKycRequest(params.toJson());
}
