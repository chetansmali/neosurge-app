import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/equity/equity_explore/stock_chart_params.dart';
import '../../../../domain/usecases/equity/get_stock_chart.dart';

part 'stock_chart_state.dart';

@injectable
class StockChartCubit extends Cubit<StockChartState> {
  final GetExploreStockChart getexploreStockChart;

  StockChartCubit(this.getexploreStockChart)
      : super(const StockChartInitial(EquityChartTimePeriod.oneDay));

  Future<void> fetchChartData(
      EquityChartTimePeriod equityTimePeriod, String symbolName) async {
    if (state is StockChartSuccess &&
        state.equityTimePeriod == equityTimePeriod) {
      return;
    }
    emit(StockChartLoading(equityTimePeriod));

    late final String frame;
    switch (equityTimePeriod) {
      case EquityChartTimePeriod.oneDay:
        frame = 'ONE_DAY';
        break;
      case EquityChartTimePeriod.oneWeek:
        frame = 'ONE_WEEK';
        break;
      case EquityChartTimePeriod.oneMonth:
        frame = 'ONE_MONTH';
        break;
      case EquityChartTimePeriod.oneYear:
        frame = 'ONE_YEAR';
        break;
      case EquityChartTimePeriod.fiveYear:
        frame = 'FIVE_YEAR';
        break;
    }
    final response = await getexploreStockChart(
        StockChartParams(filter: frame, symbolName: symbolName));

    response.fold(
        (l) => emit(StockChartFailure(l.errorType, l.error, equityTimePeriod)),
        (r) {
      List<DateTime> dates = List.generate(
        r.length,
        (index) => r[index].datetime,
      );

      List<FlSpot> price;

      if (equityTimePeriod != EquityChartTimePeriod.oneWeek) {
        price = List.generate(
          r.length,
          (index) => FlSpot(
            r[index].datetime.millisecondsSinceEpoch.toDouble(),
            r[index].close.toDouble(),
          ),
        );
      } else {
        price = List.generate(r.length, (index) {
          return FlSpot(
            index.toDouble(),
            r[index].close.toDouble(),
          );
        });
      }
      emit(
        StockChartSuccess(
          price,
          dates,
          equityTimePeriod,
        ),
      );
    });
  }
}
