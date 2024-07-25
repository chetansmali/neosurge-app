part of 'verify_consent_cubit.dart';

abstract class VerifyConsentState extends Equatable {
  const VerifyConsentState();
}

class VerifyConsentInitial extends VerifyConsentState {
  @override
  List<Object> get props => [];
}

class VerifyConsentLoading extends VerifyConsentState {
  @override
  List<Object> get props => [];
}

class VerifyConsentSuccess extends VerifyConsentState {
  final VerifyConsentModel verifyConsentModel;

  const VerifyConsentSuccess({required this.verifyConsentModel});

  @override
  List<Object> get props => [verifyConsentModel];
}

class VerifyConsentFailed extends VerifyConsentState {
  final String message;

  const VerifyConsentFailed({required this.message});

  @override
  List<Object> get props => [message];
}
