import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/redeem/redeem_order_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/create_redemption_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class CreateRedemptionOrder
    extends UseCase<RedeemOrderResponse, CreateRedemptionOrderParams> {
  final MutualFundRepository _mfRepository;

  CreateRedemptionOrder(this._mfRepository);

  @override
  Future<Either<AppError, RedeemOrderResponse>> call(
          CreateRedemptionOrderParams params) =>
      _mfRepository.createRedemptionOrder(params.toJson());
}
