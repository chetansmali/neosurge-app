import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/stp/stp_order_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/create_stp_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class CreateStpOrder extends UseCase<StpOrderResponse, CreateStpOrderParams> {
  final MutualFundRepository _mutualFundRepository;

  CreateStpOrder(this._mutualFundRepository);

  @override
  Future<Either<AppError, StpOrderResponse>> call(
          CreateStpOrderParams params) =>
      _mutualFundRepository.createStpOrder(params.toJson());
}
