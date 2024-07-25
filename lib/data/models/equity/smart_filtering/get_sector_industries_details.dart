import 'package:json_annotation/json_annotation.dart';

part 'get_sector_industries_details.g.dart';

@JsonSerializable()
class GetSectorIndustriesDetails {
  String sector;
  List<String> industries;

  GetSectorIndustriesDetails({required this.sector, required this.industries});

  factory GetSectorIndustriesDetails.fromJson(Map<String, dynamic> json) =>
      _$GetSectorIndustriesDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$GetSectorIndustriesDetailsToJson(this);

  static List<GetSectorIndustriesDetails> listFromJson(List<dynamic> json) =>
      json.map((e) => GetSectorIndustriesDetails.fromJson(e)).toList();
}
