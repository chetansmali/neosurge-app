import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/ocr_read_response_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/kyc/ocr_read_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class OcrRead extends UseCase<OcrReadResponseModel, OcrReadParams> {
  final KycRepository _kycRepository;

  OcrRead(this._kycRepository);

  @override
  Future<Either<AppError, OcrReadResponseModel>> call(
          OcrReadParams params) async =>
      _kycRepository.ocrRead(await params.toFormData());
}
