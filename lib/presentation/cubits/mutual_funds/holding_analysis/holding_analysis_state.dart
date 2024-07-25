part of 'holding_analysis_cubit.dart';

abstract class HoldingAnalysisState extends Equatable {
  const HoldingAnalysisState();
}

class HoldingAnalysisInitial extends HoldingAnalysisState {
  @override
  List<Object> get props => [];
}

class HoldingAnalysisLoading extends HoldingAnalysisState {
  @override
  List<Object> get props => [];
}

class HoldingAnalysisLoaded extends HoldingAnalysisState {
  final HoldingAnalysis holdingAnalysis;
  final SectorAllocationList sectorAllocationList;

  const HoldingAnalysisLoaded(this.holdingAnalysis, this.sectorAllocationList);

  @override
  List<Object> get props => [holdingAnalysis, sectorAllocationList];
}

class HoldingAnalysisLoadError extends HoldingAnalysisState {
  final AppErrorType appErrorType;
  final String? errorMessage;

  const HoldingAnalysisLoadError({required this.appErrorType, this.errorMessage});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
