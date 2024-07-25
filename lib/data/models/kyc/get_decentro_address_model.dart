import 'package:json_annotation/json_annotation.dart';

part 'get_decentro_address_model.g.dart';

@JsonSerializable()
class GetDecentroAddressModel {
  final String sequence;
  final String reportedDate;
  final String address;
  final String state;
  final String type;
  final String postal;

  GetDecentroAddressModel({
    required this.sequence,
    required this.reportedDate,
    required this.address,
    required this.state,
    required this.type,
    required this.postal,
  });

  factory GetDecentroAddressModel.fromJson(Map<String, dynamic> json) =>
      _$GetDecentroAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetDecentroAddressModelToJson(this);
}
