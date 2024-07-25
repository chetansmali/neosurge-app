import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/mf_order.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/get_mf_order_params.dart';
import '../../../../domain/usecases/mutual_funds/get_mf_orders.dart';

part 'mf_orders_state.dart';

@injectable
class MfOrdersCubit extends Cubit<MfOrdersState> {
  final GetMfOrders _getMfOrders;

  MfOrdersCubit(this._getMfOrders) : super(PendingOrdersInitial());

  int _from = 0;
  final int _pageSize = 10;

  MFOrderStatus? _orderStatus;

  Future<void> fetchOrders({
    required int userId,
    int? offset,

    ///If orderStatus is null, this will get all orders(Pending,Successful,Failure)
    MFOrderStatus? orderStatus,
    int? limit,
  }) async {
    if (state is MfOrdersLoading) return;
    List<MfOrder> oldOrders = [];
    if (offset == null) {
      if (state is MfOrdersLoaded) {
        oldOrders = (state as MfOrdersLoaded).orders;
      } else if (state is MfOrdersLoadError) {
        oldOrders = (state as MfOrdersLoadError).oldOrders;
      }
    } else {
      _from = offset;
      _orderStatus = orderStatus;
    }
    emit(MfOrdersLoading(isFirstFetch: _from == 0, oldOrders: oldOrders));
    final response = await _getMfOrders(GetMfOrderParams(userId: userId, isAllOrders: _orderStatus == null, from: _from, limit: _pageSize, status: _orderStatus));
    if (isClosed) return;
    response.fold((l) => emit(MfOrdersLoadError(l.errorType, l.error, isFirstFetch: _from == 0, oldOrders: oldOrders)), (r) {
      List<MfOrder> newOrders = r;
      if (newOrders.isEmpty) {
        emit(MfOrdersLoaded(oldOrders, isLastPage: true));
      } else {
        _from += _pageSize;
        emit(MfOrdersLoaded(oldOrders + newOrders, isLastPage: false));
      }
    });
  }

  ///Function to fetch pending orders with _pageSize=1000 without pagination

  Future<void> fetchPendingOrders({
    required int userId,
  }) async {
    emit(const MfOrdersLoading());
    final response = await _getMfOrders(GetMfOrderParams(userId: userId, isAllOrders: false, from: 0, limit: 1000, status: MFOrderStatus.pending, isDiyOrder: true));
    if (isClosed) return;
    emit(response.fold((l) => MfOrdersLoadError(l.errorType, l.error), (r) => MfOrdersLoaded(r)));
    return;
  }

  ///Function to refresh pending orders with _pageSize=1000 without pagination

  Future<void> refreshPendingOrders({
    required int userId,
  }) async {
    if (state is MfOrdersLoaded) {
      final List<MfOrder> pendingOrders = (state as MfOrdersLoaded).orders;
      final response = await _getMfOrders(GetMfOrderParams(userId: userId, isAllOrders: false, from: 0, limit: 1000, status: MFOrderStatus.pending, isDiyOrder: true));
      //This is added so as to prevent issue of refreshing issue of ExpandableSliverList
      emit(const MfOrdersLoading());

      emit(response.fold(
        (l) => MfOrdersLoaded(pendingOrders),
        (r) => MfOrdersLoaded(r),
      ));
      return;
    } else {
      return await fetchPendingOrders(userId: userId);
    }
  }
}
