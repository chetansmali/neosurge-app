import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/assisted_service/unlock_assisted_service_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/assisted_service/unlock_assisted_service_params.dart';
import '../../../../domain/usecases/assisted_service/unlock_assisted_service.dart';
import '../../util_cubits/loading_cubit.dart';

part 'unlock_assisted_service_state.dart';

@injectable
class UnlockAssistedServiceCubit extends Cubit<UnlockAssistedServiceState> {
  final UnlockAssistedService _unlockAssistedService;
  final LoadingCubit _loadingCubit;

  UnlockAssistedServiceCubit(this._unlockAssistedService, this._loadingCubit) : super(UnlockAssistedServiceInitial());

  void createOrder({required double amount}) async {
    _loadingCubit.show();
    emit(UnlockAssistedServiceLoading());
    final res = await _unlockAssistedService(UnlockAssistedServiceParams(amount: amount));
    emit(res.fold((l) => UnlockAssistedServiceFailure(appErrorType: l.errorType, errorMessage: l.error), (r) => UnlockAssistedServiceSuccess(response: r)));
    _loadingCubit.hide();
  }
}
