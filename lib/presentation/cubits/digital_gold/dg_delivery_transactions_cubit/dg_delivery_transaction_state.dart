part of 'dg_delivery_transaction_cubit.dart';

abstract class DgDeliveryTransactionState extends Equatable {
  const DgDeliveryTransactionState();
}

class DgDeliveryTransactionInitial extends DgDeliveryTransactionState {
  @override
  List<Object> get props => [];
}

class DgDeliveryTransactionLoading extends DgDeliveryTransactionState {
  final List<DgDeliveryTransactionResponseModel> oldTransactionList;
  final bool isFirstFetch;

  const DgDeliveryTransactionLoading(this.oldTransactionList, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldTransactionList, isFirstFetch];
}

class DgDeliveryTransactionLoaded extends DgDeliveryTransactionState {
  final List<DgDeliveryTransactionResponseModel> transactionList;
  final bool isLastPage;

  const DgDeliveryTransactionLoaded({required this.transactionList, this.isLastPage = false});

  @override
  List<Object> get props => [transactionList, isLastPage];
}

class DgDeliveryTransactionLoadError extends DgDeliveryTransactionState {
  final bool isFirstFetch;
  final List<DgDeliveryTransactionResponseModel> oldTransactionList;
  final AppErrorType appErrorType;
  final String? errorMessage;

  const DgDeliveryTransactionLoadError({this.isFirstFetch = false, this.oldTransactionList = const [], required this.appErrorType, this.errorMessage});

  @override
  List<Object> get props => [oldTransactionList, isFirstFetch];
}
