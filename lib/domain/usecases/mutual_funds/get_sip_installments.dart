import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/installment_dto.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_sip_installment_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetSipInstallments
    extends UseCase<List<InstallmentDTO>, GetSipInstallmentParams> {
  final MutualFundRepository _mfRepository;

  GetSipInstallments(this._mfRepository);

  @override
  Future<Either<AppError, List<InstallmentDTO>>> call(
      GetSipInstallmentParams params) async {
    return await _mfRepository.getSipInstallments(params.toJson());
  }
}
