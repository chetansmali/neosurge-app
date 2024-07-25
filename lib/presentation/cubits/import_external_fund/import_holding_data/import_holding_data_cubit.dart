import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/import_external_funds/imported_holding_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/import_external_fund/get_imported_user_holding_params.dart';
import '../../../../domain/usecases/import_external_fund/get_holding_data.dart';

part 'import_holding_data_state.dart';

@injectable
class ImportHoldingDataCubit extends Cubit<ImportHoldingDataState> {
  final GetHoldingData _getHoldingData;
  HoldingDistribution? neoSurgeInvestment;

  ImportHoldingDataCubit(this._getHoldingData)
      : super(ImportHoldingDataInital());

  Future getImportedHoldingData({required int userId}) async {
    emit(ImportHoldingDataLoading());
    final response = await _getHoldingData(
      GetImportedUserHoldingParams(
        userID: userId,
      ),
    );
    response.fold(
      (l) => emit(
        ImportHoldingDataLoadError(
          appErrorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) {
        ImportedHoldingResponse formattedData = _formatHoldingData(r);
        emit(
          ImportHoldingDataLoaded(
            importedHoldingResponse: formattedData,
            neoSurgeInvestment: neoSurgeInvestment,
          ),
        );
      },
    );
  }

  ImportedHoldingResponse _formatHoldingData(ImportedHoldingResponse r) {
    for (int i = 0; i < r.holdingDistribution.length; i++) {
      if (r.holdingDistribution[i].brokerName == 'BULLSURGE PRIVATE LIMITED') {
        neoSurgeInvestment = r.holdingDistribution[i];
        r.holdingDistribution.removeAt(i);
      }
    }

    return r;
  }
}
