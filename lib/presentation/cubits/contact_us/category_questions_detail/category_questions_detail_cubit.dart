import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/contact_us/contact_us_question_response.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/contact_us/get_category_question_detail_params.dart';
import '../../../../domain/usecases/contact_us/get_category_question_detail.dart';
part 'category_questions_detail_state.dart';

@injectable
class CategoryQuestionsDetailCubit extends Cubit<CategoryQuestionsDetailState> {
  final GetCategoryQuestionDetail _getCategoryQuestionDetail;
  CategoryQuestionsDetailCubit(this._getCategoryQuestionDetail)
      : super(CategoryQuestionsDetailInitial());

  void fetchQuestionAnswer() async {
    emit(CategoryQuestionsDetailLoading());
    final response = await _getCategoryQuestionDetail(
        GetCategoryQuestionDetailParams(id: "6581548095f1a259581c2a7e"));
    emit(response.fold(
        (l) => CategoryQuestionsDetailLoadError(
            errorType: l.errorType, errorMessage: l.error),
        (r) => CategoryQuestionsDetailLoaded(r)));
  }
}
