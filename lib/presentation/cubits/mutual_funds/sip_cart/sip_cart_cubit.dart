import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/cart/mutual_fund_cart.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/remove_fund_from_cart_params.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/mutual_funds/get_cart_sip_funds.dart';
import '../../../../domain/usecases/mutual_funds/remove_fund_from_cart.dart';

part 'sip_cart_state.dart';

@injectable
class SipCartCubit extends Cubit<SipCartState> {
  final RemoveFundFromCart _removeFundFromCart;
  final GetCartSipFunds _getCartSipFunds;

  SipCartCubit(
    this._getCartSipFunds,
    this._removeFundFromCart,
  ) : super(
          SipCartInitial(),
        );

  void getCartSipFunds() async {
    if (state is SipCartFundsLoading) return;

    emit(SipCartFundsLoading());

    final result = await _getCartSipFunds(NoParams());

    result.fold(
      (l) => emit(
        SipCartFundsLoadError(
          appErrorType: l.errorType,
          error: l.error,
        ),
      ),
      (r) => emit(
        SipCartFundsLoaded(
          mutualFundCart: r,
        ),
      ),
    );
  }

  void removeFundFromCart(RemoveFundFromCartParams params) async {
    if (state is RemoveFundFromSipCartLoading) return;

    emit(RemoveFundFromSipCartLoading(
      cartItemId: params.fundCartId,
      funds: state.mutualFundCart!,
    ));

    final result = await _removeFundFromCart(params);

    result.fold(
      (l) => emit(
        RemoveFundFromSipCartError(
          errorType: l.errorType,
          error: l.error,
        ),
      ),
      (r) => emit(
        SipCartFundsLoaded(
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
