import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/explore_diy_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_explore_diy_data_params.dart';
import '../../../../domain/usecases/mutual_funds/get_explore_diy_data.dart';

part 'explore_diy_data_state.dart';

@injectable
class ExploreDIYDataCubit extends Cubit<ExploreDIYDataState> {
  final GetExploreDIYData _getExploreDIYData;

  ExploreDIYDataCubit(
    this._getExploreDIYData,
  ) : super(ExploreDIYDataInitial());

  void getExploreDIYData({
    required GetExploreDIYDataParams params,
  }) async {
    emit(ExploreDIYDataLoading());
    final res = await _getExploreDIYData(
      params,
    );
    emit(
      res.fold(
        (l) => ExploreDIYDataError(
            appErrorType: l.errorType, message: l.error ?? ''),
        (r) => ExploreDIYDataLoaded(
          r,
        ),
      ),
    );
  }
}
