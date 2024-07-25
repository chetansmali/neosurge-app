part of 'assisted_orders_cubit.dart';

abstract class AssistedOrdersState extends Equatable {
  const AssistedOrdersState();
}

class AssistedOrdersInitial extends AssistedOrdersState {
  @override
  List<Object> get props => [];
}

class AssistedOrdersLoading extends AssistedOrdersState {
  final bool isFirstFetch;
  final List<MfOrder> oldOrders;

  const AssistedOrdersLoading({this.isFirstFetch = false, this.oldOrders = const []});

  @override
  List<Object> get props => [isFirstFetch, oldOrders];
}

class AssistedOrdersLoaded extends AssistedOrdersState {
  final List<MfOrder> orders;
  final bool isLastPage;

  const AssistedOrdersLoaded(this.orders, {this.isLastPage = false});

  @override
  List<Object> get props => [orders, isLastPage];
}

class AssistedOrdersLoadError extends AssistedOrdersState {
  final AppErrorType errorType;
  final String? errorMessage;
  final bool isFirstFetch;
  final List<MfOrder> oldOrders;

  const AssistedOrdersLoadError(this.errorType, this.errorMessage, {this.isFirstFetch = false, this.oldOrders = const []});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
