import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/user_mandate_details_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/account/add_user_mandate_params.dart';
import '../../../../domain/usecases/account/add_user_mandate.dart';

part 'create_mandate_state.dart';

@injectable
class CreateMandateCubit extends Cubit<CreateMandateState> {
  final AddUserMandate _addUserMandate;

  CreateMandateCubit(this._addUserMandate) : super(CreateMandateInitial());

  void createMandate({required double limit, required int bankId}) async {
    emit(CreateMandateLoading());
    final response = await _addUserMandate(AddUserMandateParams(limit: limit, bankId: bankId));
    emit(response.fold((l) => CreateMandateError(error: l.error, errorType: l.errorType), (r) => CreateMandateSuccess(mandate: r)));
  }
}
