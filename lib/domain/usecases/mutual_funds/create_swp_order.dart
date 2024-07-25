import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/swp/swp_order_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/create_swp_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class CreateSwpOrder extends UseCase<SwpOrderResponse, CreateSwpOrderParams> {
  final MutualFundRepository _mutualFundRepository;

  CreateSwpOrder(this._mutualFundRepository);

  @override
  Future<Either<AppError, SwpOrderResponse>> call(
          CreateSwpOrderParams params) =>
      _mutualFundRepository.createSwpOrder(params.toJson());
}
