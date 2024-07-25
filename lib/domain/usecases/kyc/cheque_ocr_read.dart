import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/cheque_ocr_read_response_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class ChequeOcrRead extends UseCase<ChequeOcrReadResponseModel, NoParams> {
  final KycRepository _kycRepository;

  ChequeOcrRead(this._kycRepository);

  @override
  Future<Either<AppError, ChequeOcrReadResponseModel>> call(NoParams params) =>
      _kycRepository.chequeOcrRead();
}
