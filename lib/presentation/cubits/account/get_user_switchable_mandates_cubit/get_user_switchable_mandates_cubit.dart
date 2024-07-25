import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/switchable_mandate_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/account/get_all_switchable_mandates.dart';

part 'get_user_switchable_mandates_state.dart';

@injectable
class GetUserSwitchableMandatesCubit
    extends Cubit<GetUserSwitchableMandatesState> {
  final GetAllSwitchableMandates _getAllSwitchableMandates;
  GetUserSwitchableMandatesCubit(
    this._getAllSwitchableMandates,
  ) : super(
          const GetUserSwitchableMandatesInitial(),
        );

  void getUserSwitchableMandates() async {
    emit(const GetUserSwitchableMandatesLoading());
    final result = await _getAllSwitchableMandates(
      NoParams(),
    );

    result.fold(
      (l) => emit(
        GetUserSwitchableMandatesError(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetUserSwitchableMandatesLoaded(r)),
    );
  }
}
