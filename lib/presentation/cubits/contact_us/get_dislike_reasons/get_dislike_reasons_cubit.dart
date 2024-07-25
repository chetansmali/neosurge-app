import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/contact_us/get_dislike_reasons_list.dart';
part 'get_dislike_reasons_state.dart';

@injectable
class GetDislikeReasonsCubit extends Cubit<GetDislikeReasonsState> {
  final GetDislikeReasonsList _getDislikeReasonsList;

  GetDislikeReasonsCubit(this._getDislikeReasonsList)
      : super(GetDislikeReasonsInitial());

  void fetchDislikeReasons() async {
    emit(GetDislikeReasonsLoading());
    final response = await _getDislikeReasonsList(NoParams());
    emit(
      response.fold(
        (l) => GetDislikeReasonsLoadError(
            errorType: l.errorType, errorMessage: l.error),
        (r) => GetDislikeReasonsLoaded(r, const []),
      ),
    );
  }

  void toggleSelection(String item) {
    if (state is GetDislikeReasonsLoaded) {
      final currentSelectedReasons =
          (state as GetDislikeReasonsLoaded).selectedReasons.toList();
      if (currentSelectedReasons.contains(item)) {
        currentSelectedReasons.remove(item);
      } else {
        currentSelectedReasons.add(item);
      }
      emit(
        GetDislikeReasonsLoaded(
          (state as GetDislikeReasonsLoaded).getDislikereasonslist,
          currentSelectedReasons,
        ),
      );
    }
  }
}
