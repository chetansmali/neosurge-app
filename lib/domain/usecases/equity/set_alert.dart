import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_smart_watchlist/create_alert_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_smart_watchlist/create_alert_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@Injectable()
class SetAlert extends UseCase<CreateAlertModel, CreateAlertParams> {
  final EquityRespository _equityRespository;

  SetAlert(this._equityRespository);

  @override
  Future<Either<AppError, CreateAlertModel>> call(CreateAlertParams params) =>
      _equityRespository.createAlert(params.toJson());
}
