import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/fund.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_mutual_funds_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetMutualFunds extends UseCase<List<Fund>, GetMutualFundsParams> {
  final MutualFundRepository _mutualFundRepository;

  GetMutualFunds(this._mutualFundRepository);

  @override
  Future<Either<AppError, List<Fund>>> call(GetMutualFundsParams params) =>
      _mutualFundRepository.getMutualFunds(params.toJson());
}