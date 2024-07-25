import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/retirement_calculator/retirement_inflation_calculator_model.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/retirement_calculator/retirement_inflation_calculator_params.dart';
import '../../../domain/usecases/retirement_calculator/get_retirement_inflation_calculation.dart';

part 'retirement_inflation_calculator_state.dart';

@injectable
class RetirementInflationCalculatorCubit
    extends Cubit<RetirementInflationCalculatorState> {
  final GetRetirementInflationCalculation getRetirementInflationCalculation;
  RetirementInflationCalculatorCubit(this.getRetirementInflationCalculation)
      : super(RetirementInflationCalculatorInitial());

  Future fetchInflationCalculator(
      RetirementInflationCalculatorParams params) async {
    emit(RetirementInflationCalculatorLoading());
    final response = await getRetirementInflationCalculation(params);

    response.fold(
        (l) => emit(RetirementInflationCalculatorFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(RetirementInflationCalculatorSuccess(r)));
  }
}
