import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/enums.dart';
import '../amc_logo.dart';

part 'sip_model.g.dart';

@JsonSerializable()
class SipModel {
  // {
  //             "id": 10,
  //             "isin": "INF090I01DG6",
  //             "amount": 11111.0,
  //             "startDay": "28",
  //             "startDate": "2022-06-28T00:00:00.000+00:00",
  //             "nextSipDate": "2022-07-28T00:00:00.000+00:00",
  //             "frequency": "MONTHLY",
  //             "installments": 12,
  //             "folioNumber": "SLLCARX8JGEWL",
  //             "mandateId": 10,
  //             "sourceRefId": "mf96788#10",
  //             "userIp": "192.168.2.92",
  //             "serverIp": "192.168.2.95",
  //             "status": "ACTIVATED",
  //             "createdAt": "2022-06-28T08:51:36.760+00:00",
  //             "updatedAt": "2022-06-28T08:54:39.236+00:00",
  //             "sipId": 31,
  //             "navAsOn": 100.9043,
  //             "calculatedUnits": 110.114236955214,
  //             "activatedAt": null,
  //             "sipInternalStatus": "submitted",
  //             "sipInternalStatusDate": "2022-06-28T00:00:00.000+00:00",
  //             "plan": "100528",
  //             "sipDueTriggered": false,
  //             "deleted": false
  //         },

  final int id;
  final String isin;
  final double amount;
  final String startDay;
  final DateTime startDate;
  final DateTime nextSipDate;
  final String frequency;
  final int installments;
  final String? folioNumber;
  final int mandateId;
  final String sourceRefId;
  final String userIp;
  final String serverIp;
  final SystematicPlansStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int sipId;
  final double navAsOn;
  final double calculatedUnits;
  final DateTime? activatedAt;
  final SipInternalStatus sipInternalStatus;
  final DateTime sipInternalStatusDate;
  final String plan;
  final String planName;
  final AmcLogo amcLogo;
  final bool sipDueTriggered;
  final bool deleted;

  SipModel({
    required this.id,
    required this.isin,
    required this.amount,
    required this.startDay,
    required this.startDate,
    required this.nextSipDate,
    required this.frequency,
    required this.installments,
    this.folioNumber,
    required this.mandateId,
    required this.sourceRefId,
    required this.userIp,
    required this.serverIp,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.sipId,
    required this.navAsOn,
    required this.calculatedUnits,
    this.activatedAt,
    required this.sipInternalStatus,
    required this.sipInternalStatusDate,
    required this.plan,
    required this.sipDueTriggered,
    required this.planName,
    required this.amcLogo,
    required this.deleted,
  });

  factory SipModel.fromJson(Map<String, dynamic> json) =>
      _$SipModelFromJson(json);

  Map<String, dynamic> toJson() => _$SipModelToJson(this);
}
