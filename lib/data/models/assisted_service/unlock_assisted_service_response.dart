import 'package:json_annotation/json_annotation.dart';

part 'unlock_assisted_service_response.g.dart';

@JsonSerializable()
class UnlockAssistedServiceResponse {
  //{
  //         "key": "rzp_test_5jbQjgZ4Z4NHzE",
  //         "amount": "500000",
  //         "orderId": "order_KMu1uPgzzZW4Bq",
  //         "name": "Tony Soprano",
  //         "description": "Assisted Service",
  //         "contact": "9482249819",
  //         "email": "shashank.mayya@mindstack.in"
  //     }

  final String key;
  final String amount;
  final String orderId;
  final String name;
  final String description;
  final String contact;
  final String email;

  UnlockAssistedServiceResponse({
    required this.key,
    required this.amount,
    required this.orderId,
    required this.name,
    required this.description,
    required this.contact,
    required this.email,
  });

  factory UnlockAssistedServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$UnlockAssistedServiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnlockAssistedServiceResponseToJson(this);
}
