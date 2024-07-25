part of 'contact_us_cubit.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();
}

class ContactUsInitial extends ContactUsState {
  @override
  List<Object> get props => [];
}

class ContactUsLoading extends ContactUsState {
  @override
  List<Object> get props => [];
}

class ContactUsLoaded extends ContactUsState {
  final List<ContactUsCategoriesModel> categoriesList;

  const ContactUsLoaded(this.categoriesList);

  @override
  List<Object> get props => [categoriesList];
}

class ContactUsLoadError extends ContactUsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const ContactUsLoadError({
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
