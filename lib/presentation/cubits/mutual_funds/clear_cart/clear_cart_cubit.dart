import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/clear_cart_params.dart';
import '../../../../domain/usecases/mutual_funds/clear_cart_funds.dart';

part 'clear_cart_state.dart';

@injectable
class ClearCartCubit extends Cubit<ClearCartState> {
  final ClearCartFunds _clearCartFunds;

  ClearCartCubit(
    this._clearCartFunds,
  ) : super(const ClearCartInitial());

  void clearCart(ClearCartParams params) async {
    if (state is ClearCartLoading) return;

    emit(ClearCartLoading(params.purchaseType));

    final result = await _clearCartFunds(params);

    result.fold(
      (l) => emit(
        ClearCartError(l),
      ),
      (r) => emit(
        const ClearCartSuccess(),
      ),
    );
  }
}
