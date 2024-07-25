import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user/mandate_sip_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/account/get_sips_by_mandate_params.dart';
import '../../../../domain/usecases/account/get_sips_by_mandate.dart';

part 'mandate_sips_state.dart';

@injectable
class MandateSipsCubit extends Cubit<MandateSipsState> {
  final GetSipsByMandate _getSipsByMandate;

  MandateSipsCubit(
    this._getSipsByMandate,
  ) : super(MandateSipsInitial());

  void getSipsByMandate({
    required int mandateId,
  }) async {
    emit(MandateSipsLoading());
    final response = await _getSipsByMandate(
      GetSipsByMandateParams(
        mandateId: mandateId,
      ),
    );

    response.fold(
      (l) {
        emit(
          MandateSipsFailure(errorType: l.errorType, error: l.error),
        );
      },
      (r) async {
        emit(
          MandateSipsSuccess(
            mandateSips: r,
          ),
        );
      },
    );
  }
}
