import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_portfolio/get_smallcase_fund.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_portfolio/get_smallcase_funds.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetSmallcaseFunds extends UseCase<GetFundsModel, GetFundasParams> {
  final EquityRespository equityRespository;

  GetSmallcaseFunds(this.equityRespository);

  @override
  Future<Either<AppError, GetFundsModel>> call(GetFundasParams params) =>
      equityRespository.getSmallcaseFunds(params.toJson());
}
