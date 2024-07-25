part of 'import_holding_data_cubit.dart';

abstract class ImportHoldingDataState extends Equatable {
  const ImportHoldingDataState();
}

class ImportHoldingDataInital extends ImportHoldingDataState {
  @override
  List<Object?> get props => [];
}

class ImportHoldingDataLoading extends ImportHoldingDataState {
  @override
  List<Object?> get props => [];
}

class ImportHoldingDataLoaded extends ImportHoldingDataState {
  final ImportedHoldingResponse importedHoldingResponse;
  final HoldingDistribution? neoSurgeInvestment;

  const ImportHoldingDataLoaded({
    required this.importedHoldingResponse,
    this.neoSurgeInvestment,
  });

  @override
  List<Object?> get props => [importedHoldingResponse];
}

class ImportHoldingDataLoadError extends ImportHoldingDataState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const ImportHoldingDataLoadError({
    required this.appErrorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        appErrorType,
        errorMessage,
      ];
}
