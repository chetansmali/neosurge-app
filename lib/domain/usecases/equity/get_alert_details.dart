import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_smart_watchlist/alert_details_model.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_smart_watchlist/alert_details_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetAlertDetails extends UseCase<AlertDetailsModel, AlertDetailsParams> {
  final EquityRespository _equityRespository;

  GetAlertDetails(this._equityRespository);

  @override
  Future<Either<AppError, AlertDetailsModel>> call(AlertDetailsParams params) =>
      _equityRespository.getAlertDetail(params.toJson());
}
