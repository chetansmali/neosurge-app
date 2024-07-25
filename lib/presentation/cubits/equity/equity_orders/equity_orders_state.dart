part of 'equity_orders_cubit.dart';

abstract class EquityOrdersState extends Equatable {
  const EquityOrdersState();
}

class EquityOrdersInitial extends EquityOrdersState {
  @override
  List<Object> get props => [];
}

class EquityOrdersLoading extends EquityOrdersState {
  @override
  List<Object> get props => [];
}

class EquityOrdersSuccess extends EquityOrdersState {
  final List<EquityOrderModel> equityOrderModel;

  const EquityOrdersSuccess(this.equityOrderModel);
  @override
  List<Object> get props => [equityOrderModel];
}

class EquityOrdersFailure extends EquityOrdersState {
  final String? errorMessage;
  final AppErrorType errorType;

  const EquityOrdersFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
