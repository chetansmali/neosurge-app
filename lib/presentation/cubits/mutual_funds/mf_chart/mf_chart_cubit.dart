import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/get_mf_nav_history_params.dart';
import '../../../../domain/usecases/mutual_funds/get_mf_nav_history.dart';

part 'mf_chart_state.dart';

@injectable
class MFChartCubit extends Cubit<MFChartState> {
  final GetMFNavHistory _getMFNavHistory;

  MFChartCubit(this._getMFNavHistory)
      : super(const MFChartInitial(MutualFundTimePeriod.sixMonth));

  Future<void> fetchMFChartData(
      MutualFundTimePeriod mutualFundTimePeriod, String schemeCode) async {
    if (state is MFChartLoaded &&
        state.mutualFundTimePeriod == mutualFundTimePeriod) {
      return;
    }
    emit(MFChartLoading(mutualFundTimePeriod));
    late final DateTime fromDate;
    final DateTime toDate = DateTime.now();
    late final String frequency;
    switch (mutualFundTimePeriod) {
      case MutualFundTimePeriod.oneMonth:
        fromDate = DateTime.now().subtract(const Duration(days: 30));
        frequency = 'day';
        break;
      case MutualFundTimePeriod.sixMonth:
        fromDate = DateTime.now().subtract(const Duration(days: 180));
        frequency = 'day';
        break;
      case MutualFundTimePeriod.oneYear:
        fromDate = DateTime.now().subtract(const Duration(days: 365));
        frequency = 'day';
        break;
      case MutualFundTimePeriod.threeYear:
        fromDate = DateTime.now().subtract(const Duration(days: 365 * 3));
        frequency = 'week';
        break;
      case MutualFundTimePeriod.fiveYear:
        fromDate = DateTime.now().subtract(const Duration(days: 365 * 5));
        frequency = 'week';
        break;
      case MutualFundTimePeriod.all:
        fromDate = DateTime.now().subtract(const Duration(days: 365 * 10));
        frequency = 'week';
        break;
    }
    final response = await _getMFNavHistory(GetMFNavHistoryParams(
        frequency: frequency,
        schemeCode: schemeCode,
        from: fromDate,
        to: toDate));
    if (isClosed) return;
    response.fold(
        (l) =>
            emit(MfChartLoadError(l.errorType, l.error, mutualFundTimePeriod)),
        (r) {
      r.sort((a, b) => a.date.compareTo(b.date));
      List<String> dates = List.generate(
          r.length, (index) => DateFormat('dd MMM yyyy').format(r[index].date));
      emit(
        MFChartLoaded(
          List.generate(
              r.length, (index) => FlSpot(index.toDouble(), r[index].nav)),
          dates,
          mutualFundTimePeriod,
        ),
      );
    });
  }
}
