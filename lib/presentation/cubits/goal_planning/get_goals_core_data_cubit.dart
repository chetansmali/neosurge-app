import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/goal_planning/get_core_goals_model.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/no_params.dart';
import '../../../domain/usecases/goal_planning/get_goals_core_data.dart';

part 'get_goals_core_data_state.dart';

@injectable
class GetGoalsCoreDataCubit extends Cubit<GetGoalsCoreDataState> {
  final GetGoalsCoreData getGoalsCoreData;

  GetGoalsCoreDataCubit(this.getGoalsCoreData)
      : super(GetGoalsCoreDataInitial());

  Future fetchGoalCoreData() async {
    if (state is GetGoalsCoreDataLoading) return;

    emit(GetGoalsCoreDataLoading());
    final response = await getGoalsCoreData(NoParams());
    response.fold(
        (l) => emit(
              GetGoalsCoreDataFailure(
                  errorType: l.errorType, errorMessage: l.error),
            ), (r) {
      emit(GetGoalsCoreDataLoaded(r));
    });
  }
}
