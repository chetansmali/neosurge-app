import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/lamf/get_import_landing_page_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/lamf/get_cibil_refresh.dart';
import '../../../../domain/usecases/lamf/get_lamf_landing_page.dart';

part 'get_lamf_landing_page_state.dart';

@injectable
class GetLamfLandingPageCubit extends Cubit<GetLamfLandingPageState> {
  GetLamfLandingPageCubit(this._getLAMFLandingPage, this._getCibilRefresh)
      : super(GetLamfLandingPageInitial());

  final GetLAMFLandingPage _getLAMFLandingPage;
  final GetCibilRefresh _getCibilRefresh;

  Future getLAMFLandingPage() async {
    emit(GetLamfLandingPageLoading());
    final response = await _getLAMFLandingPage(NoParams());
    emit(response.fold(
        (l) => GetLamfLandingPageFailure(
            appErrorType: l.errorType, errorMessage: l.error),
        (r) => GetLamfLandingPageSuccess(getImportLandingPageResponse: r)));
  }

  Future getCibilRefresh() async {
    emit(GetLamfLandingPageLoading());
    final response = await _getCibilRefresh(NoParams());
    emit(response.fold(
        (l) => GetLamfLandingPageFailure(
            appErrorType: l.errorType, errorMessage: l.error),
        (r) => GetLamfLandingPageSuccess(getImportLandingPageResponse: r)));
  }
}
