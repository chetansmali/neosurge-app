import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/switch/switch_order_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/create_switch_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class CreateSwitchOrder
    extends UseCase<SwitchOrderResponse, CreateSwitchOrderParams> {
  final MutualFundRepository _mutualFundRepository;

  CreateSwitchOrder(this._mutualFundRepository);

  @override
  Future<Either<AppError, SwitchOrderResponse>> call(
          CreateSwitchOrderParams params) =>
      _mutualFundRepository.createSwitchOrder(params.toJson());
}
