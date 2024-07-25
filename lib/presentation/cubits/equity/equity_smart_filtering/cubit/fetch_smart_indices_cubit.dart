import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/models/equity/smart_filtering/smart_filter_indices_details.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/equity/equity_smart_watchlist/fetch_indices_params.dart';
import '../../../../../domain/usecases/equity/get_smart_indices.dart';

part 'fetch_smart_indices_state.dart';

@Injectable()
class FetchSmartIndicesCubit extends Cubit<FetchSmartIndicesState> {
  final GetSmartIndices _getSmartIndices;
  FetchSmartIndicesCubit(this._getSmartIndices)
      : super(FetchSmartIndicesInitial());
  void getSmartIndices(FetchIndicesParams params) async {
    emit(FetchSmartIndicesLoading());
    final response = await _getSmartIndices(params);
    emit(response.fold((l) => FetchSmartIndicesFailure(l.error, l.errorType),
        (r) => FetchSmartIndicesSuccess(r)));
  }
}
