import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/retirement_calculator/retirement_passbook_model.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/retirement_calculator/retirement_passbook_params.dart';
import '../../../domain/usecases/retirement_calculator/get_retirement_passbook.dart';

part 'retirement_passbook_state.dart';

@injectable
class RetirementPassbookCubit extends Cubit<RetirementPassbookState> {
  final GetRetirementPassbook getRetirementPassbook;
  RetirementPassbookCubit(this.getRetirementPassbook)
      : super(RetirementPassbookInitial());

  Future fetchEPFReport(RetirementPassbookParams params) async {
    emit(RetirementPassbookLoading());
    final response = await getRetirementPassbook(params);
    response.fold(
        (l) => emit(RetirementPassbookFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(RetirementPassbookLoaded(r)));
  }
}
