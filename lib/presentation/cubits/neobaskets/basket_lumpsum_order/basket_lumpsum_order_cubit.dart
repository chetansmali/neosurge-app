import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_order_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_order_params.dart';
import '../../../../domain/usecases/neobaskets/create_basket_lumpsum_order.dart';

part 'basket_lumpsum_order_state.dart';

@injectable
class BasketLumpsumOrderCubit extends Cubit<BasketLumpsumOrderState> {
  final CreateBasketLumpsumOrder _basketLumpsumOrder;

  BasketLumpsumOrderCubit(
    this._basketLumpsumOrder,
  ) : super(BasketLumpsumOrderInitial());

  void initiateBasketLumpsumOrder(BasketOrderParams params) async {
    if (state is BasketLumpsumOrderLoading) return;
    emit(BasketLumpsumOrderLoading());
    final failureOrBasketLumpsumOrder = await _basketLumpsumOrder(
      params,
    );

    failureOrBasketLumpsumOrder.fold(
      (l) => emit(
        BasketLumpsumOrderFailure(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(
        BasketLumpsumOrderSuccess(r),
      ),
    );
  }
}
