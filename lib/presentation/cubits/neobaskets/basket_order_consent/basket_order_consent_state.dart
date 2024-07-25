part of 'basket_order_consent_cubit.dart';

abstract class BasketOrderConsentState extends Equatable {
  const BasketOrderConsentState();
}

class BasketOrderConsentInitial extends BasketOrderConsentState {
  const BasketOrderConsentInitial();

  @override
  List<Object?> get props => [];
}

class BasketOrderConsentCreating extends BasketOrderConsentState {
  const BasketOrderConsentCreating();

  @override
  List<Object?> get props => [];
}

class BasketOrderConsentCreated extends BasketOrderConsentState {
  const BasketOrderConsentCreated({
    required this.consentModel,
  });

  final CreateConsentModel consentModel;

  @override
  List<Object?> get props => [consentModel];
}

class BasketOrderConsentError extends BasketOrderConsentState {
  const BasketOrderConsentError({
    required this.errorType,
    this.error,
  });

  final AppErrorType errorType;
  final String? error;

  @override
  List<Object?> get props => [errorType, error];
}
