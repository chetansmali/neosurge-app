import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/cart/initiate_lumpsum_cart_purchase_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/initiate_cart_sip_purchase_params.dart';
import '../../../../domain/usecases/mutual_funds/initiate_cart_sip_purchase.dart';

part 'cart_sip_purchase_state.dart';

@injectable
class CartSipPurchaseCubit extends Cubit<CartSipPurchaseState> {
  final InitiateCartSipPurchase _initiateCartSipPurchase;

  CartSipPurchaseCubit(
    this._initiateCartSipPurchase,
  ) : super(CartSipPurchaseInitial());

  void initiateCartSipPurchase({
    required InitiateCartSipPurchaseParams params,
  }) async {
    if (state is CartSipPurchaseLoading) return;

    emit(CartSipPurchaseLoading());

    final response = await _initiateCartSipPurchase(
      params,
    );

    response.fold(
      (error) => emit(CartSipPurchaseError(error)),
      (response) => emit(CartSipPurchaseSuccess(response)),
    );
  }
}
