import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/neobaskets/basket_lumpsum_order_verify_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/neobaskets/basket_lumpsum_order_verify_params.dart';
import '../../../../domain/usecases/neobaskets/verify_basket_lumpsum_consent.dart';

part 'basket_lumpsum_order_verify_state.dart';

@injectable
class BasketLumpsumOrderVerifyCubit
    extends Cubit<BasketLumpsumOrderVerifyState> {
  VerifyBasketLumpsumConsent verifyBasketLumpsumConsent;

  BasketLumpsumOrderVerifyCubit(
    this.verifyBasketLumpsumConsent,
  ) : super(const BasketLumpsumOrderVerifyInitial());

  void verifyBasketLumpsumOrder(
    BasketLumpsumOrderVerifyParams params,
  ) async {
    if (state is BasketLumpsumOrderVerifying) {
      return;
    }

    emit(const BasketLumpsumOrderVerifying());
    final eitherResponse = await verifyBasketLumpsumConsent(params);
    eitherResponse.fold(
      (l) {
        emit(BasketLumpsumOrderVerifyError(
          errorType: l.errorType,
          error: l.error,
        ));
      },
      (r) {
        emit(
          BasketLumpsumOrderVerified(
            basketLumpsumOrderVerifyResponse: r,
          ),
        );
      },
    );
  }
}
