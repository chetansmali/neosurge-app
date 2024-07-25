import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/verify_pan_response_model.dart';
import '../../entities/app_error.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class VerifyPan extends UseCase<VerifyPanResponseModel, VerifyPanParams> {
  final KycRepository _kycRepository;

  VerifyPan(this._kycRepository);

  @override
  Future<Either<AppError, VerifyPanResponseModel>> call(
          VerifyPanParams params) async =>
      await _kycRepository.verifyPan(params.toJson());
}

class VerifyPanParams {
  final String panNumber;

  VerifyPanParams({required this.panNumber});

  Map<String, dynamic> toJson() {
    return {
      'pan_card_number': panNumber,
    };
  }
}
