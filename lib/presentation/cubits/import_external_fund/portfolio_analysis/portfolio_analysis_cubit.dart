import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/import_external_funds/portfolio_analysis_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/usecases/import_external_fund/get_portfolio_analysis.dart';

part 'portfolio_analysis_state.dart';

@injectable
class PortfolioAnalysisCubit extends Cubit<PortfolioAnalysisState> {
  final GetPortfolioAnalysis _getPortfolioAnalysis;

  PortfolioAnalysisCubit(
    this._getPortfolioAnalysis,
  ) : super(const PortfolioAnalysisInitial());

  Future getPortfolioAnalysis({required int userId}) async {
    emit(const PortfolioAnalysisLoading());
    final response = await _getPortfolioAnalysis(userId);
    response.fold(
      (l) => emit(
        PortfolioAnalysisError(l),
      ),
      (r) => emit(
        PortfolioAnalysisLoaded(r),
      ),
    );
  }
}
