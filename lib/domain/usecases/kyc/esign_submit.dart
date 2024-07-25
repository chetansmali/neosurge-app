import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/esign_submit_response_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class ESignSubmit extends UseCase<ESignSubmitResponseModel, NoParams> {
  final KycRepository _kycRepository;

  ESignSubmit(this._kycRepository);

  @override
  Future<Either<AppError, ESignSubmitResponseModel>> call(
          NoParams params) async =>
      await _kycRepository.eSignSubmit();
}
