import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/contact_us/contact_us_question_response.dart';
import '../../entities/app_error.dart';
import '../../entities/params/contact_us/get_category_question_detail_params.dart';
import '../../entities/usecase.dart';
import '../../repositories/contact_us_repository.dart';

@injectable
class GetCategoryQuestionDetail
    extends UseCase<ContactUsQuestionsModel, GetCategoryQuestionDetailParams> {
  final ContactUsRepository _contactUsRepository;

  GetCategoryQuestionDetail(this._contactUsRepository);

  @override
  Future<Either<AppError, ContactUsQuestionsModel>> call(
          GetCategoryQuestionDetailParams params) =>
      _contactUsRepository.getQuestionDetail(params.toJson());
}
