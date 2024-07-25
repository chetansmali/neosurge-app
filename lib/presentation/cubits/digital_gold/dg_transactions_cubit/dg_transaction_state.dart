part of 'dg_transaction_cubit.dart';

abstract class DgTransactionState extends Equatable {
  const DgTransactionState();
}

class DgTransactionInitial extends DgTransactionState {
  @override
  List<Object> get props => [];
}

class DgTransactionLoading extends DgTransactionState {
  final bool isFirstFetch;
  final List<DgTransactionResponseModel> oldTransactionList;

  const DgTransactionLoading(this.oldTransactionList, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldTransactionList, isFirstFetch];
}

class DgTransactionLoaded extends DgTransactionState {
  final List<DgTransactionResponseModel> transactionList;
  final bool isLastPage;

  const DgTransactionLoaded({required this.transactionList, this.isLastPage = false});

  @override
  List<Object> get props => [transactionList, isLastPage];
}

class DgTransactionLoadError extends DgTransactionState {
  final bool isFirstFetch;
  final List<DgTransactionResponseModel> oldTransactionList;
  final AppErrorType appErrorType;
  final String? errorMessage;

  const DgTransactionLoadError({this.isFirstFetch = false, this.oldTransactionList = const [], required this.appErrorType, this.errorMessage});

  @override
  List<Object> get props => [oldTransactionList, isFirstFetch];
}
