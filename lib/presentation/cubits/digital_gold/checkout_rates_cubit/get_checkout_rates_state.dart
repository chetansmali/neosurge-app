part of 'get_checkout_rates_cubit.dart';

abstract class GetCheckoutRatesState extends Equatable {
  final CheckoutRatesModel? checkoutRatesModel;

  const GetCheckoutRatesState({this.checkoutRatesModel});
}

class GetCheckoutRatesInitial extends GetCheckoutRatesState {
  @override
  List<Object> get props => [];
}

class GetCheckoutRatesLoading extends GetCheckoutRatesState {
  const GetCheckoutRatesLoading() : super();

  @override
  List<Object> get props => [];
}

class GetCheckoutRatesLoaded extends GetCheckoutRatesState {
  final GoldSilverUnitType goldSilverUnitType;

  const GetCheckoutRatesLoaded(this.checkoutRates, {required this.goldSilverUnitType}) : super(checkoutRatesModel: checkoutRates);

  final CheckoutRatesModel checkoutRates;

  @override
  List<Object> get props => [checkoutRates];
}

class GetCheckOutRatesLoadError extends GetCheckoutRatesState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const GetCheckOutRatesLoadError({this.errorMessage, required this.appErrorType}) : super();

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
