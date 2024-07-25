import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/fund.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_stp_funds_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetStpFunds extends UseCase<List<Fund>, GetStpFundsParams> {
  final MutualFundRepository _mfRepository;

  GetStpFunds(this._mfRepository);

  @override
  Future<Either<AppError, List<Fund>>> call(GetStpFundsParams params) async {
    return await _mfRepository.getStpFunds(params.toJson());
  }
}
