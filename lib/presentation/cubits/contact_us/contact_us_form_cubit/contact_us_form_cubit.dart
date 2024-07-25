import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/contact_us/post_support_email_params.dart';
import '../../../../domain/usecases/contact_us/post_support_email.dart';
part 'contact_us_form_state.dart';

@injectable
class ContactUsFormCubit extends Cubit<ContactUsFormState> {
  final PostSupportEmail _postSupportEmail;
  ContactUsFormCubit(this._postSupportEmail) : super(ContactUsFormInitial());

  void submitForm({
    required String category,
    required String descriptionofquery,
    required List<File> queryReferenceimages,
  }) async {
    emit(ContactUsFormLoading());
    await Future.delayed(const Duration(seconds: 6));
    final response = await _postSupportEmail(
      PostSupportEmailParams(
        category: category,
        querydescription: descriptionofquery,
        imageslist: queryReferenceimages,
      ),
    );
    emit(
      response.fold(
        (l) =>
            ContactUsFormFailure(errorType: l.errorType, errorMessage: l.error),
        (r) => ContactUsFormSucess(),
      ),
    );
  }
}
