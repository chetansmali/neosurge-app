import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/neobaskets/verify_basket_redeem_consent_param.dart';
import '../../../domain/usecases/neobaskets/verify_basket_redeem_consent.dart';

part 'basket_redeem_order_verify_state.dart';

@injectable
class BasketRedeemOrderVerifyCubit extends Cubit<BasketRedeemOrderVerifyState> {
  final VerifyBasketRedeemConsent _verifyBasketRedeemConsent;

  BasketRedeemOrderVerifyCubit(
    this._verifyBasketRedeemConsent,
  ) : super(BasketRedeemOrderVerifyInitial());

  void verifyRedeemOrder(VerifyBasketRedeemConsentParams param) async {
    if (state is BasketRedeemOrderVerifying) return;

    emit(BasketRedeemOrderVerifying());
    final response = await _verifyBasketRedeemConsent.call(param);

    response.fold(
      (l) => emit(BasketRedeemOrderVerifyError(
        appErrorType: l.errorType,
        error: l.error,
      )),
      (r) => emit(const BasketRedeemOrderVerified()),
    );
  }
}
