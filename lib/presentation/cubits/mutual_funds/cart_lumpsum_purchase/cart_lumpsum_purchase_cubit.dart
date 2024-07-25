import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/cart/initiate_lumpsum_cart_purchase_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/mutual_funds/initiate_cart_lumpsum_purchase.dart';

part 'cart_lumpsum_purchase_state.dart';

@injectable
class CartLumpsumPurchaseCubit extends Cubit<CartLumpsumPurchaseState> {
  final InitiateCartLumpsumPurchase _initiateCartLumpsumPurchase;

  CartLumpsumPurchaseCubit(
    this._initiateCartLumpsumPurchase,
  ) : super(CartLumpsumPurchaseInitial());

  void initiateCartLumpsumPurchase() async {
    if (state is CartLumpsumPurchaseLoading) return;

    emit(CartLumpsumPurchaseLoading());

    final response = await _initiateCartLumpsumPurchase(NoParams());

    response.fold(
      (error) => emit(CartLumpsumPurchaseError(error)),
      (response) => emit(CartLumpsumPurchaseSuccess(response)),
    );
  }
}
