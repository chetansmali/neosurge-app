import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/delete_mandate_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/account/delete_mandate_params.dart';
import '../../../../domain/usecases/account/delete_user_mandate.dart';

part 'delete_mandate_state.dart';

@injectable
class DeleteMandateCubit extends Cubit<DeleteMandateState> {
  final DeleteUserMandate _deleteUserMandate;

  DeleteMandateCubit(this._deleteUserMandate) : super(DeleteMandateInitial());

  void deleteMandate({bool? closeAll, int? mandateId, int? alternateId}) async {
    if (state is DeleteMandateLoading) return;

    emit(DeleteMandateLoading());
    final response = await _deleteUserMandate(
      DeleteMandateParams(
        closeAll: closeAll,
        mandateId: mandateId,
        alternateId: alternateId,
      ),
    );
    emit(
      response.fold(
        (l) => DeleteMandateError(error: l.error, errorType: l.errorType),
        (r) => DeleteMandateSuccess(deleteMandateModel: r),
      ),
    );
  }
}
