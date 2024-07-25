part of 'create_consent_cubit.dart';

abstract class CreateConsentState extends Equatable {
  const CreateConsentState();
}

class CreateConsentInitial extends CreateConsentState {
  @override
  List<Object> get props => [];
}

class CreateConsentLoading extends CreateConsentState {
  @override
  List<Object> get props => [];
}

class CreateConsentSuccess extends CreateConsentState {
  final CreateConsentModel createConsentModel;

  const CreateConsentSuccess({required this.createConsentModel});

  @override
  List<Object> get props => [createConsentModel];
}

class CreateConsentFailed extends CreateConsentState {
  final String message;

  const CreateConsentFailed({required this.message});

  @override
  List<Object> get props => [message];
}
