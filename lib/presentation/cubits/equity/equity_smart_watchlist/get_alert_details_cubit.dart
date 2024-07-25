import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_smart_watchlist/alert_details_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_smart_watchlist/alert_details_params.dart';
import '../../../../domain/usecases/equity/get_alert_details.dart';

part 'get_alert_details_state.dart';

@injectable
class GetAlertDetailsCubit extends Cubit<GetAlertDetailsState> {
  final GetAlertDetails getAlertDetails;
  GetAlertDetailsCubit(this.getAlertDetails) : super(GetAlertDetailsInitial());

  Future<void> fetchAlertDetails(AlertDetailsParams params) async {
    emit(GetAlertDetailsLoading());
    final response = await getAlertDetails(params);
    response.fold(
        (l) => emit(
              GetAlertDetailsFailure(
                  errorType: l.errorType, errorMessage: l.error),
            ), (r) {
      List<DateTime> dates = List.generate(
        r.data.chartData.length,
        (index) => r.data.chartData[index].datetime,
      );

      List<FlSpot> price;
      price = List.generate(r.data.chartData.length, (index) {
        return FlSpot(
          index.toDouble(),
          r.data.chartData[index].close,
        );
      });

      List<int> spotIndexies = [];
      for (var item in r.data.transactions.transactionsByDate ?? []) {
        var index = dates.indexOf(item.date);
        spotIndexies.add(index);
      }

      emit(GetAlertDetailsLoaded(r, price, dates, spotIndexies));
    });
  }
}
