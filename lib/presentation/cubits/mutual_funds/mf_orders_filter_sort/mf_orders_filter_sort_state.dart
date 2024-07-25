part of 'mf_orders_filter_sort_cubit.dart';

abstract class MfOrdersFilterSortState extends Equatable {
  final MFOrderStatus? orderStatus;

  const MfOrdersFilterSortState({this.orderStatus});
}

class MfOrdersFilterSortInitial extends MfOrdersFilterSortState {
  const MfOrdersFilterSortInitial({final MFOrderStatus? orderStatus}) : super(orderStatus: orderStatus);

  @override
  List<Object?> get props => [orderStatus];
}
