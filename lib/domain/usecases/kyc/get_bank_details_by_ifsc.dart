import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/kyc/bank_details_by_ifsc_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/kyc/get_bank_details_by_ifsc_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/kyc_repository.dart';

@injectable
class GetBankDetailsByIfscCode
    extends UseCase<BankDetailsByIfscModel, GetBankDetailsByIfscParams> {
  final KycRepository _kycRepository;

  GetBankDetailsByIfscCode(this._kycRepository);

  @override
  Future<Either<AppError, BankDetailsByIfscModel>> call(
          GetBankDetailsByIfscParams params) async =>
      await _kycRepository.getBankDetailsByIfscCode(params.toJson());
}
