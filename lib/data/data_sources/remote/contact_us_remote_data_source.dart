import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../models/contact_us/contact_us_categories_response.dart';
import '../../models/contact_us/contact_us_question_response.dart';

abstract class ContactUsRemoteDataSource {
  Future<List<ContactUsCategoriesModel>> getContactUsCategories();

  Future<List<String>> getDislikeReasons();

  Future<List<ContactUsQuestionsModel>> getFaqsearchQuestions(
      Map<String, dynamic> params);

  Future<ContactUsQuestionsModel> getQuestionDetail(Map<String, dynamic> id);

  Future<void> postSupportEmail(FormData mailinput);

  Future<void> captureFaqDislike(Map<String, dynamic> params);

  Future<void> captureFaqLike(Map<String, dynamic> params);
}

@LazySingleton(as: ContactUsRemoteDataSource)
class ContactUsRemoteDataSourceImpl implements ContactUsRemoteDataSource {
  final ApiClient _client;

  ContactUsRemoteDataSourceImpl(this._client);

  @override
  Future<List<ContactUsCategoriesModel>> getContactUsCategories() async {
    final response = await _client.get(ApiConstants.chatSupportCategories);
    return response
        .map<ContactUsCategoriesModel>(
            (json) => ContactUsCategoriesModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<String>> getDislikeReasons() async {
    final response = await _client.get(ApiConstants.disLikeReasons);
    return (response as List<dynamic>).map((item) => item.toString()).toList();
  }

  @override
  Future<List<ContactUsQuestionsModel>> getFaqsearchQuestions(
      Map<String, dynamic>? params) async {
    final response = await _client.get(ApiConstants.chatSupportSearch,
        queryParameters: params);
    return response["content"]
        .map<ContactUsQuestionsModel>(
            (json) => ContactUsQuestionsModel.fromJson(json))
        .toList();
  }

  @override
  Future<ContactUsQuestionsModel> getQuestionDetail(
      Map<String, dynamic> id) async {
    final response =
        await _client.get("${ApiConstants.singleFaqDetails}/${id["id"]}");
    return ContactUsQuestionsModel.fromJson(response);
  }

  @override
  Future<void> postSupportEmail(FormData mailinput) async {
    return await _client.post(
      ApiConstants.sendSupportEmail,
      formData: mailinput,
      isFormData: true,
    );
  }

  @override
  Future<void> captureFaqDislike(Map<String, dynamic> params) async {
    return await _client.post(ApiConstants.capturefaqdislike, params: params);
  }

  @override
  Future<void> captureFaqLike(Map<String, dynamic> params) async {
    return await _client.post(ApiConstants.capturefaqlike, params: params);
  }
}
