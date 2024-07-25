import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user_bank_mandate_model.dart';
import '../../../../data/models/user/user_mandate_details_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/account/get_user_bank_mandate_params.dart';
import '../../../../domain/entities/params/account/get_user_mandate_params.dart';
import '../../../../domain/usecases/account/delete_user_mandate_by_id.dart';
import '../../../../domain/usecases/account/get_user_mandates_by_bank.dart';

part 'user_mandate_state.dart';

@injectable
class UserMandateCubit extends Cubit<UserMandateState> {
  final GetUserMandatesByBank _getUserMandatesByBank;
  final DeleteUserMandateById _deleteUserMandateById;

  UserMandateCubit(this._getUserMandatesByBank, this._deleteUserMandateById)
      : super(UserMandateInitial());

  void fetchUserMandates({required int bankId}) async {
    emit(UserMandateLoading());
    final result = await _getUserMandatesByBank(
      GetUserBankMandateParams(
        bankId: bankId,
      ),
    );
    emit(
      result.fold(
        (l) => UserMandateLoadError(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
        (r) => UserMandateLoaded(r),
      ),
    );
  }

  Future<void> deleteUserMandateById({required int mandateId}) async {
    emit(UserMandateLoading());
    final result = await _deleteUserMandateById
        .call(GetUserMandateParams(mandateId: mandateId));
    emit(result.fold(
        (l) =>
            UserMandateLoadError(errorType: l.errorType, errorMessage: l.error),
        //emit loading since ui has to show empty while fetching mandates
        (r) => UserMandateLoading()));
  }

  void setMandate(UserMandate mandate) async {
    emit(
      UserMandateLoaded(
        [
          UserBankMandateModel(
            createdOn: DateTime.now().toString(),
            mandateId: mandate.id,
            status: 'PENDING',
          ),
        ],
      ),
    );
  }
}
