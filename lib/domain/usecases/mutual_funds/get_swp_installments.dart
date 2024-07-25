import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/installment_dto.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_swp_installment_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetSwpInstallments
    extends UseCase<List<InstallmentDTO>, GetSwpInstallmentParams> {
  final MutualFundRepository _mfRepository;

  GetSwpInstallments(this._mfRepository);

  @override
  Future<Either<AppError, List<InstallmentDTO>>> call(
      GetSwpInstallmentParams params) async {
    return await _mfRepository.getSwpInstallments(params.toJson());
  }
}
