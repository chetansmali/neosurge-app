import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_details_model.g.dart';

@JsonSerializable()
class DeliveryAddressDetailsModel extends Equatable {
  //  "id": 1,
  //             "fullName": "sajan b",
  //             "mobileNumber": "7019292929",
  //             "emailId": "sajan.bappal@mindstack.in",
  //
  //             "address": "jeppu, mangalore",
  //             "state": {
  //                 "stateId": "eyqMQqYd",
  //                 "name": "Karnataka"
  //             },
  //             "city": {
  //                 "cityId": "eN9bkmXD",
  //                 "name": "Dakshina Kannada",
  //                 "state": {
  //                     "stateId": "eyqMQqYd",
  //                     "name": "Karnataka"
  //                 }
  //             },
  //             "pincode": "575003",
  //             "userAddressId": "N9blzoqD",
  //             "userAccountId": "XDZAdwb7",
  //             "isDelivered": false

  final int id;
  final String fullName;
  final String mobileNumber;
  final String emailId;
  final String address;
  final DGUserState state;
  final DGUserCity city;
  final String pincode;
  final String userAddressId;
  final String userAccountId;
  final bool isDelivered;

  const DeliveryAddressDetailsModel({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.emailId,
    required this.address,
    required this.state,
    required this.city,
    required this.pincode,
    required this.userAddressId,
    required this.userAccountId,
    required this.isDelivered,
  });

  factory DeliveryAddressDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAddressDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryAddressDetailsModelToJson(this);

  @override
  List<Object?> get props => [id];
}

@JsonSerializable()
class DGUserCity extends Equatable {
  final String cityId;
  final String name;
  final DGUserState state;

  const DGUserCity({
    required this.cityId,
    required this.name,
    required this.state,
  });

  factory DGUserCity.fromJson(Map<String, dynamic> json) =>
      _$DGUserCityFromJson(json);

  Map<String, dynamic> toJson() => _$DGUserCityToJson(this);

  @override
  List<Object?> get props => [cityId, name, state];
}

@JsonSerializable()
class DGUserState extends Equatable {
  final String stateId;
  final String name;

  const DGUserState({
    required this.stateId,
    required this.name,
  });

  factory DGUserState.fromJson(Map<String, dynamic> json) =>
      _$DGUserStateFromJson(json);

  Map<String, dynamic> toJson() => _$DGUserStateToJson(this);

  @override
  List<Object?> get props => [stateId, name];
}
