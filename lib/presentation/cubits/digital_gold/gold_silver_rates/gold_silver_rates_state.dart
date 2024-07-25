part of 'gold_silver_rates_cubit.dart';

abstract class GoldSilverRatesState extends Equatable {
  const GoldSilverRatesState();
}

class GoldSilverRatesInitial extends GoldSilverRatesState {
  @override
  List<Object> get props => [];
}

class GoldSilverRatesLoading extends GoldSilverRatesState {
  @override
  List<Object> get props => [];
}

class GoldSilverRatesLoaded extends GoldSilverRatesState {
  final GoldSilverRatesModel goldSilverRates;
  final GoldSilverRatesQuantity quantity;

  const GoldSilverRatesLoaded({required this.goldSilverRates, required this.quantity});

  @override
  List<Object> get props => [goldSilverRates, quantity];
}

class GoldSilverRatesLoadError extends GoldSilverRatesState {
  @override
  List<Object> get props => [];
}
