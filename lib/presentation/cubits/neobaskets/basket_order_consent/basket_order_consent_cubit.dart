import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/create_consent.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/neobaskets/create_basket_order_consent.dart';

part 'basket_order_consent_state.dart';

@injectable
class BasketOrderConsentCubit extends Cubit<BasketOrderConsentState> {
  final CreateBasketOrderConsent _createBasketOrderConsent;

  BasketOrderConsentCubit(
    this._createBasketOrderConsent,
  ) : super(const BasketOrderConsentInitial());

  void createBasketOrderConsent() async {
    emit(const BasketOrderConsentCreating());
    final response = await _createBasketOrderConsent(NoParams());

    response.fold(
      (l) => emit(
        BasketOrderConsentError(
          errorType: l.errorType,
          error: l.error,
        ),
      ),
      (r) => emit(
        BasketOrderConsentCreated(
          consentModel: r,
        ),
      ),
    );
  }
}
