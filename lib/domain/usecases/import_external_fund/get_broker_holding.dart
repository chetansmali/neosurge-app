import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/import_external_funds/broker_holdings_fund_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/import_external_fund/get_broker_holding_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/external_fund_repository.dart';

@injectable
class GetBrokerHoldings
    extends UseCase<List<BrokerHoldingsFund>, GetBrokerHoldingParams> {
  final ExternalFundRepository _externalFundRepository;

  GetBrokerHoldings(this._externalFundRepository);

  @override
  Future<Either<AppError, List<BrokerHoldingsFund>>> call(
    GetBrokerHoldingParams params,
  ) async =>
      await _externalFundRepository.getBrokerHoldingsFund(
        params.toJson(),
      );
}
