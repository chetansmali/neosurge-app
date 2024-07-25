import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/digital_gold/checkout_rates_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/digital_gold/checkout_rates_params.dart';
import '../../../../domain/usecases/digital_gold/get_checkout_rates.dart';

part 'get_checkout_rates_state.dart';

@injectable
class GetCheckoutRatesCubit extends Cubit<GetCheckoutRatesState> {
  final GetCheckoutRates _getCheckoutRates;

  GetCheckoutRatesCubit(this._getCheckoutRates) : super(GetCheckoutRatesInitial());

  void resetState() {
    emit(GetCheckoutRatesInitial());
  }

  void getBuyCheckoutRate({
    required MetalType metalType,
    required double amountOrWeight,
    required GoldSilverUnitType unitType,
  }) async {
    emit(const GetCheckoutRatesLoading());
    final response = await _getCheckoutRates(CheckoutRatesParams(weight: amountOrWeight, transactionType: DGTransactionType.buy, metalType: metalType, unit: unitType));
    emit(response.fold((l) => GetCheckOutRatesLoadError(appErrorType: l.errorType, errorMessage: l.error), (r) => GetCheckoutRatesLoaded(r, goldSilverUnitType: unitType)));
  }

  void getSellCheckoutRates({
    required MetalType metalType,
    required double amountOrWeight,
    required GoldSilverUnitType unitType,
  }) async {
    emit(const GetCheckoutRatesLoading());
    final response = await _getCheckoutRates(CheckoutRatesParams(weight: amountOrWeight, transactionType: DGTransactionType.sell, metalType: metalType, unit: unitType));
    emit(response.fold((l) => GetCheckOutRatesLoadError(appErrorType: l.errorType, errorMessage: l.error), (r) => GetCheckoutRatesLoaded(r, goldSilverUnitType: unitType)));
  }
}
