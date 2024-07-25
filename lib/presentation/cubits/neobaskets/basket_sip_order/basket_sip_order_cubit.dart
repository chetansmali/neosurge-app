import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_order_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_order_params.dart';
import '../../../../domain/usecases/neobaskets/create_basket_sip_order.dart';

part 'basket_sip_order_state.dart';

@injectable
class BasketSipOrderCubit extends Cubit<BasketSipOrderState> {
  final CreateBasketSipOrder _basketSipOrder;

  BasketSipOrderCubit(
    this._basketSipOrder,
  ) : super(BasketSipOrderInitial());

  void initiateBasketSipOrder(
    BasketOrderParams params,
  ) async {
    if (state is BasketSipOrderLoading) return;

    emit(BasketSipOrderLoading());

    final orderResponse = await _basketSipOrder(
      params,
    );

    orderResponse.fold(
      (l) => emit(
        BasketSipOrderFailure(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(
        BasketSipOrderSuccess(r),
      ),
    );
  }
}
