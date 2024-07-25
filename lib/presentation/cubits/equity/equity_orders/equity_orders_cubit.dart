import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_order/equity_orders_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_orders/equity_orders_params.dart';
import '../../../../domain/usecases/equity/get_orders.dart';

part 'equity_orders_state.dart';

@injectable
class EquityOrdersCubit extends Cubit<EquityOrdersState> {
  final GetOrders getOrders;

  EquityOrdersCubit(this.getOrders) : super(EquityOrdersInitial());

  Future fetchOrders(EquityOrdersParams params) async {
    emit(EquityOrdersLoading());
    final response = await getOrders(params);
    response.fold(
        (l) => emit(
            EquityOrdersFailure(errorType: l.errorType, errorMessage: l.error)),
        (r) {
      emit(EquityOrdersSuccess(r));
    });
  }

  Future fetchETFOrders(EquityOrdersParams params) async {
    emit(EquityOrdersLoading());
    final response = await getOrders(params);
    response.fold(
        (l) => emit(
            EquityOrdersFailure(errorType: l.errorType, errorMessage: l.error)),
        (r) {
      emit(EquityOrdersSuccess(r));
    });
  }
}
