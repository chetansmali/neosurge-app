import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/equity/equity_explore/stock_chart.dart';
import '../../entities/app_error.dart';
import '../../entities/params/equity/equity_explore/stock_chart_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/equity_respository.dart';

@injectable
class GetExploreStockChart
    extends UseCase<List<StockChartModel>, StockChartParams> {
  final EquityRespository _equityRespository;

  GetExploreStockChart(this._equityRespository);

  @override
  Future<Either<AppError, List<StockChartModel>>> call(
          StockChartParams params) =>
      _equityRespository.getStockChart(params.toJson());
}
