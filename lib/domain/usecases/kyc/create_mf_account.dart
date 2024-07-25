import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/create_kyc_account_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class CreateMfAccount extends UseCase<void, CreateKycAccountParams> {
  final KycRepository _kycRepository;

  CreateMfAccount(this._kycRepository);

  @override
  Future<Either<AppError, void>> call(CreateKycAccountParams params) async =>
      await _kycRepository.createMfAccount(params.toJson());
}
