import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/mutual_funds/sip/sip_order_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/mutual_funds/create_sip_order_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/mutual_fund_repository.dart';

@injectable
class CreateSipOrder extends UseCase<SipOrderResponse, CreateSipOrderParams> {
  final MutualFundRepository _mutualFundRepository;

  CreateSipOrder(this._mutualFundRepository);

  @override
  Future<Either<AppError, SipOrderResponse>> call(
          CreateSipOrderParams params) =>
      _mutualFundRepository.createSipOrder(params.toJson());
}
