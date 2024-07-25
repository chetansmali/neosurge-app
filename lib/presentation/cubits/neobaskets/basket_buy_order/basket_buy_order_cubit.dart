import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_buy_order.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_buy_order_param.dart';
import '../../../../domain/usecases/neobaskets/get_basket_buy_order.dart';

part 'basket_buy_order_state.dart';

@injectable
class BasketBuyOrderCubit extends Cubit<BasketBuyOrderState> {
  final GetBasketBuyOrder _getBasketBuyOrder;

  BasketBuyOrderCubit(
    this._getBasketBuyOrder,
  ) : super(BasketBuyOrderInitial());

  void getBasketBuyOrder(BasketBuyOrderParam param) async {
    if (state is BasketBuyOrderLoading) return;

    emit(BasketBuyOrderLoading());
    final response = await _getBasketBuyOrder(param);
    emit(
      response.fold(
        (l) => BasketBuyOrderError(
          appErrorType: l.errorType,
          message: l.error,
        ),
        (r) => BasketBuyOrderLoaded(basketOrders: r),
      ),
    );
  }
}
