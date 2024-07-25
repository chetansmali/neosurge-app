part of 'generate_capital_gains_file_cubit.dart';

abstract class GenerateCapitalGainsFileState extends Equatable {
  const GenerateCapitalGainsFileState();
}

class GenerateCapitalGainsFileInitial extends GenerateCapitalGainsFileState {
  @override
  List<Object> get props => [];
}

class GenerateCapitalGainsFileLoading extends GenerateCapitalGainsFileState {
  @override
  List<Object> get props => [];
}

class GenerateCapitalGainsFileSuccess extends GenerateCapitalGainsFileState {
  @override
  List<Object> get props => [];
}

class GenerateCapitalGainsFileFailure extends GenerateCapitalGainsFileState {
  final AppErrorType appErrorType;
  final String? errorMessage;

  const GenerateCapitalGainsFileFailure(
      {required this.appErrorType, required this.errorMessage});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
