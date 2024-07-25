import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_smart_watchlist/get_users_alert.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_smart_watchlist/get_users_alert_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetUsersAlerts extends UseCase<GetUserAlertModel, GetUsersAlertParams> {
  final EquityRespository _equityRespository;
  GetUsersAlerts(this._equityRespository);

  @override
  Future<Either<AppError, GetUserAlertModel>> call(
          GetUsersAlertParams params) =>
      _equityRespository.getUserAlert(params.toJson());
}
