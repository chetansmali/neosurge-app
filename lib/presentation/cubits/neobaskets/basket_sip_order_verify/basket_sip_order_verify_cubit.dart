import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_sip_order_verify_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_sip_order_verify_params.dart';
import '../../../../domain/usecases/neobaskets/verify_basket_sip_consent.dart';

part 'basket_sip_order_verify_state.dart';

@injectable
class BasketSipOrderVerifyCubit extends Cubit<BasketSipOrderVerifyState> {
  VerifyBasketSipConsent verifyBasketSipConsent;

  BasketSipOrderVerifyCubit(
    this.verifyBasketSipConsent,
  ) : super(const BasketSipOrderVerifyInitial());

  void verifyBasketSipOrder(
    BasketSipOrderVerifyParams params,
  ) async {
    if (state is BasketSipOrderVerifying) {
      return;
    }

    emit(const BasketSipOrderVerifying());
    final eitherResponse = await verifyBasketSipConsent(params);
    eitherResponse.fold(
      (l) {
        emit(
          BasketSipOrderVerifyError(
            errorType: l.errorType,
            error: l.error,
          ),
        );
      },
      (r) {
        emit(
          BasketSipOrderVerified(
            basketSipOrderVerifyResponse: r,
          ),
        );
      },
    );
  }
}
