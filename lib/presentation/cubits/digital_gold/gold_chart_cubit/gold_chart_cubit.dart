import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/digital_gold/digital_gold_graph_response_entity.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/digital_gold/get_digital_gold_graph.dart';

part 'gold_chart_state.dart';

@injectable
class GoldChartCubit extends Cubit<GoldChartState> {
  final GetDigitalGoldGraph _getDigitalGoldGraph;

  GoldChartCubit(this._getDigitalGoldGraph) : super(const GoldChartInitial(GoldSilverTimePeriod.sixMonth));

  Future<void> fetchGoldData(
    GoldSilverTimePeriod timePeriod,
  ) async {
    if (state.goldSilverTimePeriod == timePeriod && state is GoldChartLoaded) {
      return;
    }
    if (state is GoldChartLoaded) {
      final currentState = state as GoldChartLoaded;
      List<DigitalGoldGraphResponse> chartValues = [];

      switch (timePeriod) {
        case GoldSilverTimePeriod.sixMonth:
          chartValues.addAll(currentState.digitalGoldGraphResponse
              .where((element) =>
                  element.date.isBefore(
                    DateTime.now(),
                  ) &&
                  element.date.isAfter(DateTime.now().subtract(const Duration(days: 180))))
              .toList());
          break;
        case GoldSilverTimePeriod.oneYear:
          chartValues.addAll(currentState.digitalGoldGraphResponse
              .where((element) =>
                  element.date.isBefore(
                    DateTime.now(),
                  ) &&
                  element.date.isAfter(DateTime.now().subtract(const Duration(days: 365))))
              .toList());
          break;
        case GoldSilverTimePeriod.threeYear:
          chartValues.addAll(currentState.digitalGoldGraphResponse
              .where((element) =>
                  element.date.isBefore(
                    DateTime.now(),
                  ) &&
                  element.date.isAfter(DateTime.now().subtract(const Duration(days: 365 * 3))))
              .toList());
          break;
        case GoldSilverTimePeriod.fiveYear:
          chartValues.addAll(currentState.digitalGoldGraphResponse
              .where((element) =>
                  element.date.isBefore(
                    DateTime.now(),
                  ) &&
                  element.date.isAfter(DateTime.now().subtract(const Duration(days: 365 * 5))))
              .toList());
          break;
        case GoldSilverTimePeriod.all:
          chartValues.addAll(currentState.digitalGoldGraphResponse);
          break;
      }
      List<String> dates = List.generate(chartValues.length, (index) => DateFormat('dd MMM yyyy').format(chartValues[index].date));
      emit(GoldChartLoaded(timePeriod,
          goldChartData: List.generate(chartValues.length, (index) => FlSpot(index.toDouble(), chartValues[index].goldBuyRate)),
          dates: dates,
          digitalGoldGraphResponse: currentState.digitalGoldGraphResponse));
      return;
    }
    emit(GoldChartLoading(timePeriod));

    final response = await _getDigitalGoldGraph(NoParams());
    response.fold(
      (l) => emit(GoldChartLoadError(timePeriod, errorType: l.errorType, errorMessage: l.error)),
      (graphObj) {
        List<String> dates = [];
        List<DigitalGoldGraphResponse> chartValues =
            graphObj.where((element) => element.date.isBefore(DateTime.now()) && element.date.isAfter(DateTime.now().subtract(const Duration(days: 180)))).toList();
        final values = List.generate(
          chartValues.length,
          (index) {
            dates.add(DateFormat('dd MMM yyyy').format(chartValues[index].date));
            return FlSpot(index.toDouble(), chartValues[index].goldBuyRate);
          },
        );
        emit(GoldChartLoaded(timePeriod, goldChartData: values, dates: dates, digitalGoldGraphResponse: graphObj));
      },
    );
  }
}
