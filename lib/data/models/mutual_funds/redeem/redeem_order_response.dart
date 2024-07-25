//"data": {
//         "id": 38,
//         "oldId": 163,
//         "mfInvestmentAccountId": "mfia_44544b6f28494e2da1c42f90cf499408",
//         "folioNumber": "8838178888718",
//         "state": "CONFIRMED",
//         "amount": 1000,
//         "scheme": "INF209KB1ZC3",
//         "redemptionMode": "normal",
//         "tradedOn": null,
//         "failedAt": null,
//         "plan": null,
//         "euin": "E260421",
//         "distributorId": null,
//         "units": null,
//         "redeemedPrice": null,
//         "redeemedUnits": null,
//         "redeemedAmount": null,
//         "redemptionBankAccountNumber": null,
//         "redemptionBankAccountIfscCode": null,
//         "scheduledOn": "2022-07-04",
//         "confirmedAt": "2022-07-04 13:24:29.13",
//         "succeededAt": null,
//         "submittedAt": null,
//         "reversedAt": null,
//         "gateway": "bse",
//         "initiatedBy": null,
//         "initiatedVia": null,
//         "sourceRefId": "mf_38#220",
//         "userIp": null,
//         "serverIp": null,
//         "tenantId": null,
//         "createdAt": "2022-07-04T13:24:25.982+00:00",
//         "updatedAt": "2022-07-04T13:24:29.402+00:00",
//         "isDeleted": false,
//         "mfRedemptionId": "mfr_c685a3f051a24ca8a50cd728fb055927",
//         "navAsOn": 0,
//         "calculatedUnits": 0,
//         "isMailSent": false,
//         "isFull": false,
//         "otpVerified": false,
//         "otpString": "3574",
//         "otpCount": 1,
//         "deleted": false
//     }
import 'package:json_annotation/json_annotation.dart';

part 'redeem_order_response.g.dart';

@JsonSerializable()
class RedeemOrderResponse {
  final int id;
  final int oldId;
  final String mfInvestmentAccountId;
  final String folioNumber;
  final String state;
  final double? amount;
  final String scheme;
  final String redemptionMode;
  final DateTime? tradedOn;
  final DateTime? failedAt;
  final String? plan;
  final String? euin;
  final String? distributorId;
  final double? units;
  final double? redeemedPrice;
  final String? redeemedUnits;
  final double? redeemedAmount;
  final String? redemptionBankAccountNumber;
  final String? redemptionBankAccountIfscCode;
  final DateTime? scheduledOn;
  final DateTime? confirmedAt;
  final DateTime? succeededAt;
  final DateTime? submittedAt;
  final DateTime? reversedAt;
  final String? gateway;
  final String? initiatedBy;
  final String? initiatedVia;
  final String? sourceRefId;
  final String? userIp;
  final String? serverIp;
  final String? tenantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final String mfRedemptionId;
  final double navAsOn;
  final double calculatedUnits;
  final bool isMailSent;
  final bool isFull;
  final bool otpVerified;
  final String otpString;
  final int otpCount;
  final bool deleted;

  RedeemOrderResponse({
    required this.id,
    required this.oldId,
    required this.mfInvestmentAccountId,
    required this.folioNumber,
    required this.state,
    required this.amount,
    required this.scheme,
    required this.redemptionMode,
    this.tradedOn,
    this.failedAt,
    this.plan,
    this.euin,
    this.distributorId,
    this.units,
    this.redeemedPrice,
    this.redeemedUnits,
    this.redeemedAmount,
    this.redemptionBankAccountNumber,
    this.redemptionBankAccountIfscCode,
    this.scheduledOn,
    this.confirmedAt,
    this.succeededAt,
    this.submittedAt,
    this.reversedAt,
    this.gateway,
    this.initiatedBy,
    this.initiatedVia,
    this.sourceRefId,
    this.userIp,
    this.serverIp,
    this.tenantId,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.mfRedemptionId,
    required this.navAsOn,
    required this.calculatedUnits,
    required this.isMailSent,
    required this.isFull,
    required this.otpVerified,
    required this.otpString,
    required this.otpCount,
    required this.deleted,
  });

  factory RedeemOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$RedeemOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RedeemOrderResponseToJson(this);
}
