part of 'mf_orders_cubit.dart';

abstract class MfOrdersState extends Equatable {
  const MfOrdersState();
}

class PendingOrdersInitial extends MfOrdersState {
  @override
  List<Object> get props => [];
}

class MfOrdersLoading extends MfOrdersState {
  final bool isFirstFetch;
  final List<MfOrder> oldOrders;

  const MfOrdersLoading({this.isFirstFetch = false, this.oldOrders = const []});

  @override
  List<Object> get props => [isFirstFetch, oldOrders];
}

class MfOrdersLoaded extends MfOrdersState {
  final List<MfOrder> orders;
  final bool isLastPage;

  const MfOrdersLoaded(this.orders, {this.isLastPage = false});

  @override
  List<Object> get props => [orders, isLastPage];
}

class MfOrdersLoadError extends MfOrdersState {
  final AppErrorType errorType;
  final String? errorMessage;
  final bool isFirstFetch;
  final List<MfOrder> oldOrders;

  const MfOrdersLoadError(this.errorType, this.errorMessage, {this.isFirstFetch = false, this.oldOrders = const []});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
