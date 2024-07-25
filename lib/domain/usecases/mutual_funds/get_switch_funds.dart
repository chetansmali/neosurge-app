import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/fund.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_switch_funds_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetSwitchFunds extends UseCase<List<Fund>, GetSwitchFundsParams> {
  final MutualFundRepository _mfRepository;

  GetSwitchFunds(this._mfRepository);

  @override
  Future<Either<AppError, List<Fund>>> call(GetSwitchFundsParams params) async {
    return await _mfRepository.getSwitchFunds(params.toJson());
  }
}
