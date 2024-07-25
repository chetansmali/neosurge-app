import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/contact_us/contact_us_question_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/contact_us/get_category_questions_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/contact_us_repository.dart';

@injectable
class GetCategoryQuestionsList
    extends UseCase<List<ContactUsQuestionsModel>, GetCategoryQuestionsParams> {
  final ContactUsRepository _contactUsRepository;

  GetCategoryQuestionsList(this._contactUsRepository);

  @override
  Future<Either<AppError, List<ContactUsQuestionsModel>>> call(
          GetCategoryQuestionsParams params) =>
      _contactUsRepository.getFaqsearchQuestions(params.toJson());
}
