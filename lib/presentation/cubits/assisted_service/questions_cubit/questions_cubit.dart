import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/assisted_service/question.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/no_params.dart';
import '../../../../domain/usecases/assisted_service/get_questions.dart';

part 'questions_state.dart';

@injectable
class QuestionsCubit extends Cubit<QuestionsState> {
  final GetQuestions _getQuestions;

  QuestionsCubit(this._getQuestions) : super(QuestionsInitial());

  Future<void> getQuestions() async {
    emit(QuestionsLoading());
    final result = await _getQuestions(NoParams());
    result.fold(
      (l) => emit(QuestionsLoadError(l.error, l.errorType)),
      (r) => emit(QuestionsLoaded(r)),
    );
  }
}
