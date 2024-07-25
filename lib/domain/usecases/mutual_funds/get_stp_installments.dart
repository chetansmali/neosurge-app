import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/installment_dto.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_stp_installment_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetStpInstallments
    extends UseCase<List<InstallmentDTO>, GetStpInstallmentParams> {
  final MutualFundRepository _mfRepository;

  GetStpInstallments(this._mfRepository);

  @override
  Future<Either<AppError, List<InstallmentDTO>>> call(
      GetStpInstallmentParams params) async {
    return await _mfRepository.getStpInstallments(params.toJson());
  }
}
