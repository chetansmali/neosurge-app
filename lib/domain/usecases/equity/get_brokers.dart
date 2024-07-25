import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/login/equity_brokers.dart';
import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetBrokers extends UseCase<List<BrokersModel>, NoParams> {
  final EquityRespository _equityRespository;

  GetBrokers(this._equityRespository);

  @override
  Future<Either<AppError, List<BrokersModel>>> call(params) =>
      _equityRespository.getBrokers();
}
