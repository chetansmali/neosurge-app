part of 'clear_cart_cubit.dart';

abstract class ClearCartState extends Equatable {
  const ClearCartState();
}

class ClearCartInitial extends ClearCartState {
  const ClearCartInitial();

  @override
  List<Object> get props => [];
}

class ClearCartLoading extends ClearCartState {
  final InvestmentType investmentType;

  const ClearCartLoading(this.investmentType);

  @override
  List<Object> get props => [];
}

class ClearCartSuccess extends ClearCartState {
  const ClearCartSuccess();

  @override
  List<Object> get props => [];
}

class ClearCartError extends ClearCartState {
  final AppError error;

  const ClearCartError(this.error);

  @override
  List<Object> get props => [];
}
