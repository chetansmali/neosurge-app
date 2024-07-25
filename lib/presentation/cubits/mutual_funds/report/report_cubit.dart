import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/user_id_param.dart';
import '../../../../domain/usecases/mutual_funds/generate_holdings_report.dart';

part 'report_state.dart';

@injectable
class ReportCubit extends Cubit<ReportState> {
  final GenerateHoldingsReport _generateHoldingsReport;

  ReportCubit(this._generateHoldingsReport) : super(ReportInitial());

  void generateHoldingsReport({required int userId}) async {
    if (state is ReportGenerating) {
      return;
    }
    emit(ReportGenerating());
    final result = await _generateHoldingsReport(UserIdParam(userId: userId));
    result.fold(
      (l) => emit(ReportGenerateError(l.error, l.errorType)),
      (r) => emit(ReportGenerated(r)),
    );
  }
}
