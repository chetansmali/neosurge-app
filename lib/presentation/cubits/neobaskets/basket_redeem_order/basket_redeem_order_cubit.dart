import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_redeem_order_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_redeem_order_params.dart';
import '../../../../domain/usecases/neobaskets/create_basket_redeem_order.dart';

part 'basket_redeem_order_state.dart';

@injectable
class BasketRedeemOrderCubit extends Cubit<BasketRedeemOrderState> {
  final CreateBasketRedeemOrder _createBasketRedeemOrder;

  BasketRedeemOrderCubit(
    this._createBasketRedeemOrder,
  ) : super(BasketRedeemOrderInitial());

  void createBasketRedeem(BasketRedeemOrderParams params) async {
    if (state is BasketRedeemOrderCreating) return;

    emit(BasketRedeemOrderCreating());
    final response = await _createBasketRedeemOrder(
      params,
    );

    response.fold(
      (l) => emit(
        BasketRedeemOrderError(
          errorType: l.errorType,
          message: l.error,
        ),
      ),
      (r) => emit(
        BasketRedeemOrderCreated(r),
      ),
    );
  }
}
