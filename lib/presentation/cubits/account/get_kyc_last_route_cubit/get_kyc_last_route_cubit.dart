import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/kyc_last_route.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/account/get_kyc_last_route.dart';

part 'get_kyc_last_route_state.dart';

@injectable
class GetKycLastRouteCubit extends Cubit<GetKycLastRouteState> {
  final GetKycLastRoute _getKycLastRoute;

  GetKycLastRouteCubit(this._getKycLastRoute) : super(GetKycLastRouteInitial());

  void getLastRoute() async {
    emit(GetKycLastRouteLoading());
    final response = await _getKycLastRoute(NoParams());
    emit(response.fold((l) => GetKycLastRouteError(errorType: l.errorType, errorMessage: l.error), (r) => GetKycLastRouteLoaded(r)));
  }
}
