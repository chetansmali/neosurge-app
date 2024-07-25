part of 'contact_us_form_cubit.dart';

abstract class ContactUsFormState extends Equatable {
  const ContactUsFormState();
}

class ContactUsFormInitial extends ContactUsFormState {
  @override
  List<Object> get props => [];
}

class ContactUsFormLoading extends ContactUsFormState {
  @override
  List<Object> get props => [];
}

class ContactUsFormLoaded extends ContactUsFormState {
  final List<String> categoriesList;

  const ContactUsFormLoaded(this.categoriesList);

  @override
  List<Object> get props => [categoriesList];
}

class ContactUsFormFailure extends ContactUsFormState {
  final AppErrorType errorType;
  final String? errorMessage;

  const ContactUsFormFailure({
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}

class ContactUsFormSucess extends ContactUsFormState {
  @override
  List<Object> get props => [];
}
