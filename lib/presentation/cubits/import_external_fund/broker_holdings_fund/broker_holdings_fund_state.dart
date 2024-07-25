part of 'broker_holdings_fund_cubit.dart';

abstract class BrokerHoldingsFundState extends Equatable {
  const BrokerHoldingsFundState();
}

class BrokerHoldingsFundInitial extends BrokerHoldingsFundState {
  @override
  List<Object> get props => [];
}

class BrokerHoldingsFundLoading extends BrokerHoldingsFundState {
  @override
  List<Object> get props => [];
}

class BrokerHoldingsFundLoaded extends BrokerHoldingsFundState {
  final List<BrokerHoldingsFund> brokerHoldingsFunds;

  const BrokerHoldingsFundLoaded({
    required this.brokerHoldingsFunds,
  });

  @override
  List<Object?> get props => [];
}

class BrokerHoldingsFundLoadError extends BrokerHoldingsFundState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const BrokerHoldingsFundLoadError(
      {required this.appErrorType, this.errorMessage});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
