import 'package:json_annotation/json_annotation.dart';

part 'get_decentro_address_params.g.dart';

@JsonSerializable()
class GetDecentroAddressParams {
  final String name;
  final String mobile;
  @JsonKey(name: 'document_type')
  final String documentType;
  @JsonKey(name: 'id_value')
  final String idValue;

  GetDecentroAddressParams({
    required this.name,
    required this.mobile,
    required this.documentType,
    required this.idValue,
  });

  factory GetDecentroAddressParams.fromJson(Map<String, dynamic> json) =>
      _$GetDecentroAddressParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetDecentroAddressParamsToJson(this);
}
