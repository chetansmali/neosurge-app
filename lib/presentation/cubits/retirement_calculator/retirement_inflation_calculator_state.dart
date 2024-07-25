part of 'retirement_inflation_calculator_cubit.dart';

abstract class RetirementInflationCalculatorState extends Equatable {
  const RetirementInflationCalculatorState();
}

class RetirementInflationCalculatorInitial
    extends RetirementInflationCalculatorState {
  @override
  List<Object> get props => [];
}

class RetirementInflationCalculatorLoading
    extends RetirementInflationCalculatorState {
  @override
  List<Object> get props => [];
}

class RetirementInflationCalculatorSuccess
    extends RetirementInflationCalculatorState {
  final RetirementInflationCalculatorModel retirementInflationCalculatorModel;

  const RetirementInflationCalculatorSuccess(
      this.retirementInflationCalculatorModel);
  @override
  List<Object> get props => [retirementInflationCalculatorModel];
}

class RetirementInflationCalculatorFailure
    extends RetirementInflationCalculatorState {
  final String? errorMessage;
  final AppErrorType errorType;

  const RetirementInflationCalculatorFailure(
      {required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
