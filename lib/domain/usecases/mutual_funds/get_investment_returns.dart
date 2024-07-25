import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/investment_returns.dart';
import '../../entities/app_error.dart';
import '../../entities/params/user_id_param.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetInvestmentReturns extends UseCase<InvestmentReturns, UserIdParam> {
  final MutualFundRepository _repository;

  GetInvestmentReturns(this._repository);

  @override
  Future<Either<AppError, InvestmentReturns>> call(UserIdParam params) async {
    return await _repository.getMfInvestmentReturns(params.toJson());
  }
}
