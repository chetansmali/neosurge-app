import 'package:json_annotation/json_annotation.dart';

import '../../enums.dart';

part 'get_mf_order_params.g.dart';

@JsonSerializable()
class GetMfOrderParams {
  final int userId;

  ///If true, this will ignore the status value and get all orders(Pending,Successful,Failure)
  final bool isAllOrders;

  /// This is optional only if [isAllOrders] is true.
  final MFOrderStatus? status;

  /// This is the limit of orders to be returned.
  /// Default value is 10.
  final int limit;

  /// This is the offset of orders to be returned.
  /// Default value is 1.
  final int from;

  /// This is used in getAllOrders api where by default the value will be false which will send All Orders.
  /// If the value is true it will send only the diy orders leaving the assisted service orders.
  final bool isDiyOrder;

  GetMfOrderParams({
    required this.userId,
    required this.isAllOrders,
    this.status,
    this.limit = 10,
    this.from = 1,
    this.isDiyOrder=false,
  });

  // assert(!isAllOrders && status != null,
  //     "If all orders is false, the status must be provided");

  factory GetMfOrderParams.fromJson(Map<String, dynamic> json) =>
      _$GetMfOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetMfOrderParamsToJson(this);
}
