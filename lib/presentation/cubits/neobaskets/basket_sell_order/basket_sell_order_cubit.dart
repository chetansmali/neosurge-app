import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_sell_order.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_sell_order_param.dart';
import '../../../../domain/usecases/neobaskets/get_basket_sell_order.dart';

part 'basket_sell_order_state.dart';

@injectable
class BasketSellOrderCubit extends Cubit<BasketSellOrderState> {
  final GetBasketSellOrder _getBasketSellOrder;

  BasketSellOrderCubit(
    this._getBasketSellOrder,
  ) : super(BasketSellOrderInitial());

  void getBasketSellOrder(BasketSellOrderParam param) async {
    if (state is BasketSellOrderLoading) return;

    emit(BasketSellOrderLoading());
    final response = await _getBasketSellOrder(param);
    emit(
      response.fold(
        (l) => BasketSellOrderError(
          appErrorType: l.errorType,
          message: l.error,
        ),
        (r) => BasketSellOrderLoaded(basketOrders: r),
      ),
    );
  }
}
