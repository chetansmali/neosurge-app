import 'package:json_annotation/json_annotation.dart';

import 'data_item.dart';
part 'news_details.g.dart';

@JsonSerializable()
class NewsDetails {
  int errorCode;
  List<DataItem> data;

  NewsDetails({required this.errorCode, required this.data});

  factory NewsDetails.fromJson(Map<String, dynamic> json) => _$NewsDetailsFromJson(json);

  Map<String,dynamic>toJson()=>_$NewsDetailsToJson(this);
}






