import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_smart_watchlist/remove_alert_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_smart_watchlist/remove_alert_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class RemoveAlert extends UseCase<RemoveAlertModel, RemoveAlertParams> {
  final EquityRespository _equityRespository;
  RemoveAlert(this._equityRespository);

  @override
  Future<Either<AppError, RemoveAlertModel>> call(RemoveAlertParams params) =>
      _equityRespository.removeAlert(params.toJson());
}
