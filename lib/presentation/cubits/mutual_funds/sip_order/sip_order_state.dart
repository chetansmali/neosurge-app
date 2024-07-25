part of 'sip_order_cubit.dart';

abstract class SipOrderState extends Equatable {
  const SipOrderState();
}

class SipOrderInitial extends SipOrderState {
  @override
  List<Object> get props => [];
}

class SipOrderLoading extends SipOrderState {
  @override
  List<Object> get props => [];
}

class SipOrderLoaded extends SipOrderState {
  final SipOrderResponse order;

  const SipOrderLoaded(this.order);

  @override
  List<Object> get props => [order];
}

class SipOrderLoadError extends SipOrderState {
  final AppErrorType errorType;
  final String? error;

  const SipOrderLoadError(this.errorType, this.error);

  @override
  List<Object?> get props => [errorType, error];
}

class SipNoMandateError extends SipOrderState {
  @override
  List<Object> get props => [];
}
