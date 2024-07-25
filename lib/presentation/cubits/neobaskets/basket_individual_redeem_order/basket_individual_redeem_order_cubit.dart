import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_redeem_order_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_individual_redeem_params.dart';
import '../../../../domain/usecases/neobaskets/create_basket_individual_order.dart';

part 'basket_individual_redeem_order_state.dart';

@injectable
class BasketIndividualRedeemOrderCubit
    extends Cubit<BasketIndividualRedeemOrderState> {
  final CreateBasketIndividualOrder _createBasketIndividualOrder;

  BasketIndividualRedeemOrderCubit(
    this._createBasketIndividualOrder,
  ) : super(BasketIndividualRedeemOrderInitial());

  void createBasketIndividualRedeem(BasketIndividualRedeemParams params) async {
    if (state is BasketIndividualRedeemOrderLoading) return;

    emit(BasketIndividualRedeemOrderLoading());
    final response = await _createBasketIndividualOrder(
      params,
    );

    response.fold(
      (l) => emit(
        BasketIndividualRedeemOrderError(
          errorType: l.errorType,
          message: l.error,
        ),
      ),
      (r) => emit(
        BasketIndividualRedeemOrderLoaded(
          basketRedeemOrderResponse: r,
        ),
      ),
    );
  }
}
