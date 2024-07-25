import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../data/models/mutual_funds/capital_gain_report_model.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/capital_gain_report_params.dart';
import '../../../../domain/usecases/mutual_funds/get_capital_gain-report.dart';

part 'get_capital_gain_report_state.dart';

@injectable
class GetCapitalGainReportCubit extends Cubit<GetCapitalGainReportState> {
  final GetCapitalGainReport getCapitalGainReport;
  GetCapitalGainReportCubit(this.getCapitalGainReport)
      : super(GetCapitalGainReportInitial());

  Future fetchCapitalGainReport(CapitalGainReportParams params) async {
    emit(GetCapitalGainReportLoading());
    final response = await getCapitalGainReport(params);
    response.fold(
      (l) => emit(
        GetCapitalGainReportFailure(
            appErrorType: l.errorType, errorMessage: l.error),
      ),
      (r) => emit(
        GetCapitalGainReportLoaded(r),
      ),
    );
  }
}
