part of 'sell_gold_silver_cubit.dart';

abstract class SellGoldSilverState extends Equatable {
  const SellGoldSilverState();
}

class SellGoldSilverInitial extends SellGoldSilverState {
  @override
  List<Object> get props => [];
}

class SellGoldSilverLoading extends SellGoldSilverState {
  @override
  List<Object> get props => [];
}

class SellGoldSilverSuccess extends SellGoldSilverState {
  @override
  List<Object> get props => [];
}

class SellGoldSilverError extends SellGoldSilverState {
  final AppErrorType appErrorType;
  final String? errorMessage;

  const SellGoldSilverError({required this.appErrorType, this.errorMessage});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
