import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_explore/stock_details.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_explore/stock_details_params.dart';
import '../../../../domain/usecases/equity/get_stock_details.dart';

part 'stock_details_state.dart';

@injectable
class StockDetailsCubit extends Cubit<StockDetailsState> {
  final GetStockDetail _getstockDetail;

  StockDetailsCubit(this._getstockDetail) : super(StockDetailsInitial());

  Future fetchStockDetails(StockDetailsParams params) async {
    emit(StockDetailsLoading());
    final response = await _getstockDetail(params);
    response.fold(
        (l) => emit(
            StockDetailsFailure(errorType: l.errorType, errorMessage: l.error)),
        (r) {
      emit(StockDetailsSuccess(stockDetailsModel: r));
    });
  }
}
