import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/assisted_service/submit_choice_params.dart';
import '../../../../domain/usecases/assisted_service/submit_choices.dart';
import '../../util_cubits/loading_cubit.dart';

part 'submit_choices_state.dart';

@injectable
class SubmitChoicesCubit extends Cubit<SubmitChoicesState> {
  final SubmitChoices _submitChoices;
  final LoadingCubit _loadingCubit;

  SubmitChoicesCubit(this._submitChoices, this._loadingCubit) : super(SubmitChoicesInitial());

  void submitChoices({required int userId, required List<int> choiceList}) async {
    emit(SubmitChoicesLoading());
    _loadingCubit.show();
    final result = await _submitChoices(SubmitChoiceParams(
      userId: userId,
      userQuizeChoices: choiceList,
    ));
    emit(result.fold(
      (l) => SubmitChoicesFailure(l.error, l.errorType),
      (r) => const SubmitChoicesSuccess(),
    ));
    _loadingCubit.hide();
  }
}
