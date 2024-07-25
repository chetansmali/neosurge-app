import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/systematic_plan.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_systematic_plans_params.dart';
import '../../../../domain/usecases/mutual_funds/get_systematic_plans.dart';

part 'systematic_plans_state.dart';

mixin ActiveSystematicPlansCubit on Cubit<SystematicPlansState> {}

mixin InactiveSystematicPlansCubit on Cubit<SystematicPlansState> {}

@injectable
class SystematicPlansCubit extends Cubit<SystematicPlansState> with ActiveSystematicPlansCubit, InactiveSystematicPlansCubit {
  final GetSystematicPlans _getSystematicPlans;

  SystematicPlansCubit(this._getSystematicPlans) : super(SystematicPlansInitial());

  void getSystematicPlans(GetSystematicPlansParams params) async {
    emit(SystematicPlansLoading());
    final result = await _getSystematicPlans(params);
    result.fold(
      (l) => emit(SystematicPlansError(l.errorType, l.error)),
      (r) => emit(SystematicPlansLoaded(r)),
    );
  }

  void cancelSystematicPlans(int id) async {
    final systematicPlans = (state as SystematicPlansLoaded).plans.where((element) => element.id != id).toList();
    emit(SystematicPlansLoaded(systematicPlans));
  }
}
