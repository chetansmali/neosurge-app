import 'package:json_annotation/json_annotation.dart';

part 'get_pincode_data_params.g.dart';

@JsonSerializable()
class GetPincodeDataParams {
  final String pinCode;

  GetPincodeDataParams({
    required this.pinCode,
  });

  factory GetPincodeDataParams.fromJson(Map<String, dynamic> json) =>
      _$GetPincodeDataParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetPincodeDataParamsToJson(this);
}
