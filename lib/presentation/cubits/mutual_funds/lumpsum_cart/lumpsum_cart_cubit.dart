import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/cart/mutual_fund_cart.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/remove_fund_from_cart_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/mutual_funds/get_cart_lumpsum_funds.dart';
import '../../../../domain/usecases/mutual_funds/remove_fund_from_cart.dart';

part 'lumpsum_cart_state.dart';

@injectable
class LumpsumCartCubit extends Cubit<LumpsumCartState> {
  final RemoveFundFromCart _removeFundFromCart;
  final GetCartLumpsumFunds _getCartLumpsumFunds;

  LumpsumCartCubit(
    this._getCartLumpsumFunds,
    this._removeFundFromCart,
  ) : super(
          LumpsumCartInitial(),
        );

  void getCartLumpsumFunds() async {
    if (state is LumpsumCartFundsLoading) return;

    emit(LumpsumCartFundsLoading());

    final result = await _getCartLumpsumFunds(NoParams());

    result.fold(
      (l) => emit(
        LumpsumCartFundsLoadError(
          appErrorType: l.errorType,
          error: l.error,
        ),
      ),
      (r) => emit(
        LumpsumCartFundsLoaded(
          mutualFundCart: r,
        ),
      ),
    );
  }

  void removeFundFromCart(RemoveFundFromCartParams params) async {
    if (state is RemoveFundFromLumpsumCartLoading) return;

    emit(RemoveFundFromLumpsumCartLoading(
      cartItemId: params.fundCartId,
      funds: state.mutualFundCart!,
    ));

    final result = await _removeFundFromCart(params);

    result.fold(
      (l) => emit(
        RemoveFundFromLumpsumCartError(
          errorType: l.errorType,
          error: l.error,
        ),
      ),
      (r) => emit(
        LumpsumCartFundsLoaded(
          mutualFundCart: state.mutualFundCart!.copyWith(
            cartMutualFunds: state.mutualFundCart!.cartMutualFunds
                .where((element) => element.cartId != params.fundCartId)
                .toList(),
          ),
        ),
      ),
    );
  }
}
