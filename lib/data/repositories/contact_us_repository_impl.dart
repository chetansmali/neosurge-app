import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_call_with_error.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/contact_us_repository.dart';
import '../data_sources/remote/contact_us_remote_data_source.dart';
import '../models/contact_us/contact_us_categories_response.dart';
import '../models/contact_us/contact_us_question_response.dart';

@LazySingleton(as: ContactUsRepository)
class ContactUsRepositoryImpl implements ContactUsRepository {
  final ContactUsRemoteDataSource _contactUsRemoteDataSource;

  ContactUsRepositoryImpl(this._contactUsRemoteDataSource);

  @override
  Future<Either<AppError, List<ContactUsCategoriesModel>>>
      getContactUsCategories() {
    return ApiCallWithError.call(
      () => _contactUsRemoteDataSource.getContactUsCategories(),
    );
  }

  @override
  Future<Either<AppError, List<String>>> getDislikeReasons() {
    return ApiCallWithError.call(
      () => _contactUsRemoteDataSource.getDislikeReasons(),
    );
  }

  @override
  Future<Either<AppError, List<ContactUsQuestionsModel>>> getFaqsearchQuestions(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _contactUsRemoteDataSource.getFaqsearchQuestions(params),
    );
  }

  @override
  Future<Either<AppError, ContactUsQuestionsModel>> getQuestionDetail(
      Map<String, dynamic> id) {
    return ApiCallWithError.call(
      () => _contactUsRemoteDataSource.getQuestionDetail(id),
    );
  }

  @override
  Future<Either<AppError, void>> postSupportEmail(FormData mailinput) {
    return ApiCallWithError.call(
      () => _contactUsRemoteDataSource.postSupportEmail(mailinput),
    );
  }

  @override
  Future<Either<AppError, void>> captureFaqDislike(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _contactUsRemoteDataSource.captureFaqDislike(params),
    );
  }

  @override
  Future<Either<AppError, void>> captureFaqLike(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () => _contactUsRemoteDataSource.captureFaqLike(params),
    );
  }
}
