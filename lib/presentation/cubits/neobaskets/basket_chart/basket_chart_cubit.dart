import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_chart_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/get_basket_chart_params.dart';
import '../../../../domain/usecases/neobaskets/get_basket_chart_data.dart';

part 'basket_chart_state.dart';

@injectable
class BasketChartCubit extends Cubit<BasketChartState> {
  final GetBasketChartData _getBasketChartData;

  BasketChartCubit(this._getBasketChartData)
      : super(
          BasketChartInitial(),
        );

  void getBasketChartData(GetBasketChartParams params) async {
    emit(BasketChartLoading());

    final response = await _getBasketChartData(
      params,
    );

    response.fold(
      (l) => emit(
        BasketChartFailure(
          l.errorType,
          l.error,
        ),
      ),
      (r) => emit(
        BasketChartSuccess(r),
      ),
    );
  }
}
