import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/models/contact_us/contact_us_categories_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/contact_us/get_contact_us_categories_list.dart';
part 'contact_us_state.dart';

@injectable
class ContactUsCubit extends Cubit<ContactUsState> {
  final GetContactUsCategoriesList _getContactUsCategoriesList;
  ContactUsCubit(this._getContactUsCategoriesList) : super(ContactUsInitial());

  void fetchContactUsCategories() async {
    emit(ContactUsLoading());
    final response = await _getContactUsCategoriesList(NoParams());
    emit(response.fold(
        (l) =>ContactUsLoadError(errorType: l.errorType, errorMessage: l.error),
        (r) => ContactUsLoaded(r)));
  }
}
