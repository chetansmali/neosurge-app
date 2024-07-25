import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../data/models/contact_us/contact_us_categories_response.dart';
import '../../data/models/contact_us/contact_us_question_response.dart';
import '../entities/app_error.dart';

abstract class ContactUsRepository {
  Future<Either<AppError, List<ContactUsCategoriesModel>>>
      getContactUsCategories();
  Future<Either<AppError, List<String>>> getDislikeReasons();
  Future<Either<AppError, List<ContactUsQuestionsModel>>> getFaqsearchQuestions(
      Map<String, dynamic> params);
  Future<Either<AppError, ContactUsQuestionsModel>> getQuestionDetail(
      Map<String, dynamic> id);
  Future<Either<AppError, void>> postSupportEmail(FormData mailinput);
  Future<Either<AppError, void>> captureFaqDislike(Map<String, dynamic> params);
  Future<Either<AppError, void>> captureFaqLike(Map<String, dynamic> params);
}
