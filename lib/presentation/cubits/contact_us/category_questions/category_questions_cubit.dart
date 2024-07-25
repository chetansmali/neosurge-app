import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/contact_us/contact_us_question_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/contact_us/get_category_questions_params.dart';
import '../../../../domain/usecases/contact_us/get_category_questions_list.dart';

part 'category_questions_state.dart';

@injectable
class CategoryQuestionsCubit extends Cubit<CategoryQuestionsState> {
  final GetCategoryQuestionsList _getCategoryQuestionsList;
  CategoryQuestionsCubit(this._getCategoryQuestionsList)
      : super(CategoryQuestionsInitial());

  void fetchQuestions(
      GetCategoryQuestionsParams getCategoryQuestionsParams) async {
    emit(CategoryQuestionsLoading());
    final response =
        await _getCategoryQuestionsList(getCategoryQuestionsParams);
    emit(
      response.fold(
          (l) => CategoryQuestionsLoadError(
              errorType: l.errorType, errorMessage: l.error),
          (r) => CategoryQuestionsLoaded(r)),
    );
  }
}
