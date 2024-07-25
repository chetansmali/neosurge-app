import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user_mandate_details_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/account/authorise_mandate_params.dart';
import '../../../../domain/usecases/account/authorise_mandate.dart';

part 'authorise_mandate_state.dart';

/// The [AuthoriseMandateCubit] is a [Cubit] that is used to fetch the token url
/// for authorising the mandate. This is called every time the user tries to
/// authorize mandate as per Fintech Api Provider the tokenUrl gets invalidated
/// if its tried to open again.
@injectable
class AuthoriseMandateCubit extends Cubit<AuthoriseMandateState> {
  final AuthoriseMandate _authoriseMandate;

  AuthoriseMandateCubit(this._authoriseMandate) : super(AuthoriseMandateInitial());

  void refreshMandate({required int mandateId}) async {
    emit(AuthoriseMandateLoading());
    final res = await _authoriseMandate(AuthoriseMandateParams(mandateId: mandateId));
    emit(res.fold((l) => AuthoriseMandateLoadError(errorType: l.errorType, errorMessage: l.error), (r) => AuthoriseMandateLoaded(r)));
  }
}
