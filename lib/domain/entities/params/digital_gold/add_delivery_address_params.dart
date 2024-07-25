import 'package:json_annotation/json_annotation.dart';

part 'add_delivery_address_params.g.dart';

@JsonSerializable()
class AddDeliveryAddressParams {
  //{
  //     "address":"jeppu, mangalore",
  //     "pincode":575003,
  //     "cityId":"eN9bkmXD",
  //     "fullName":"sajan b",
  //     "mobileNumber":"7019292929"
  // }

  final String address;
  final String pincode;
  final String cityId;
  final String fullName;
  final String mobileNumber;

  AddDeliveryAddressParams({
    required this.address,
    required this.pincode,
    required this.cityId,
    required this.fullName,
    required this.mobileNumber,
  });

  factory AddDeliveryAddressParams.fromJson(Map<String, dynamic> json) =>
      _$AddDeliveryAddressParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddDeliveryAddressParamsToJson(this);
}
