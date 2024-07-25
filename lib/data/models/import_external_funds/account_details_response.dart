import 'package:json_annotation/json_annotation.dart';

part 'account_details_response.g.dart';

@JsonSerializable()
class AccountDetailsResponse {
  final String phoneNumber;
  final String panNumber;
  final bool hasImported;
  final int? lastRefresh;
  final bool refreshAvailable;

  AccountDetailsResponse({
    required this.phoneNumber,
    required this.panNumber,
    required this.hasImported,
    this.lastRefresh,
    required this.refreshAvailable,
  });

  factory AccountDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDetailsResponseToJson(this);
}
