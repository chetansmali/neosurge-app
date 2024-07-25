import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/holding_analysis.dart';
import '../../../../data/models/mutual_funds/sector_allocation.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_mutual_fund_details_params.dart';
import '../../../../domain/entities/params/mutual_funds/get_sector_allocation_params.dart';
import '../../../../domain/usecases/mutual_funds/get_holding_analysis.dart';
import '../../../../domain/usecases/mutual_funds/get_sector_allocation.dart';

part 'holding_analysis_state.dart';

@injectable
class HoldingAnalysisCubit extends Cubit<HoldingAnalysisState> {
  final GetHoldingAnalysis _getHoldingAnalysis;
  final GetSectorAllocation _getSectorAllocation;

  HoldingAnalysisCubit(this._getHoldingAnalysis, this._getSectorAllocation) : super(HoldingAnalysisInitial());

  void getHoldingAnalysis({required String schemeCode}) async {
    emit(HoldingAnalysisLoading());
    final result = await Future.wait([
      _getHoldingAnalysis(GetMutualFundDetailsParams(schemeCode: schemeCode)),
      _getSectorAllocation(GetSectorAllocationParams(schemeCode: schemeCode)),
    ]);

    late HoldingAnalysis holdingAnalysis;
    late SectorAllocationList sectorAllocationList;
    result[0].fold((l) {
      emit(HoldingAnalysisLoadError(appErrorType: l.errorType, errorMessage: l.error));
    }, (r) {
      holdingAnalysis = r as HoldingAnalysis;
    });
    result[1].fold((l) {
      emit(HoldingAnalysisLoadError(appErrorType: l.errorType, errorMessage: l.error));
    }, (r) {
      sectorAllocationList = r as SectorAllocationList;
    });
    if (state is HoldingAnalysisLoadError) return;
    emit(HoldingAnalysisLoaded(holdingAnalysis, sectorAllocationList));
  }
}
