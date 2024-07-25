import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/enums.dart';

part 'systematic_plan.g.dart';

@JsonSerializable()
class SystematicPlan {
  // {
  //             "id": 101,
  //             "orderId": null,
  //             "orderType": "Sip",
  //             "amount": 1000,
  //             "startDate": "2022-08-11",
  //             "createdAt": "2022-08-04T10:23:33.668+00:00",
  //             "status": "DEACTIVATED",
  //             "plan": "Franklin India Corporate Debt Fund - Growth",
  //             "planIn": "105",
  //             "imgUrl": "https://bullsurge.mindstack.in/ff/amclogo/AMC11.png"
  //         }

  final int id;
  final String? orderId;
  final MFTransactionTypes orderType;
  final double amount;
  final DateTime startDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SystematicPlansStatus status;
  final String plan;
  final String? planIn;
  final String imgUrl;

  final DateTime nextInstallmentDate;

  SystematicPlan({
    required this.id,
    this.orderId,
    required this.orderType,
    required this.amount,
    required this.startDate,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.plan,
    this.planIn,
    required this.imgUrl,
    required this.nextInstallmentDate,
  });

  factory SystematicPlan.fromJson(Map<String, dynamic> json) =>
      _$SystematicPlanFromJson(json);

  Map<String, dynamic> toJson() => _$SystematicPlanToJson(this);
}
