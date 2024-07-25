import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/add_to_cart_params.dart';
import '../../../../domain/usecases/mutual_funds/add_to_cart.dart';

part 'add_to_cart_state.dart';

@injectable
class AddToCartCubit extends Cubit<AddToCartState> {
  final AddToCart _addToCart;
  AddToCartCubit(
    this._addToCart,
  ) : super(AddToCartInitial());

  Future<void> addToCart({required AddToCartParams params}) async {
    if (state is AddToCartLoading) return;

    emit(AddToCartLoading());

    final result = await _addToCart(params);

    result.fold(
      (error) => emit(
        AddToCartFail(
          errorType: error.errorType,
          error: error.error,
        ),
      ),
      (success) => emit(AddToCartSuccess()),
    );
  }
}
