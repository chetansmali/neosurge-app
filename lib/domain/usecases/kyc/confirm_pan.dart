import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/app_error.dart';
import '../../entities/params/kyc/confirm_pan_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class ConfirmPan extends UseCase<bool, ConfirmPanParams> {
  final KycRepository _kycRepository;

  ConfirmPan(this._kycRepository);

  @override
  Future<Either<AppError, bool>> call(ConfirmPanParams params) async =>
      await _kycRepository.confirmPan(params.toJson());
}
