import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/mf_order.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/get_mf_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class GetMfOrders extends UseCase<List<MfOrder>, GetMfOrderParams> {
  final MutualFundRepository _mutualFundRepository;

  GetMfOrders(this._mutualFundRepository);

  @override
  Future<Either<AppError, List<MfOrder>>> call(GetMfOrderParams params) =>
      _mutualFundRepository.fetchMfOrders(params.toJson());
}
