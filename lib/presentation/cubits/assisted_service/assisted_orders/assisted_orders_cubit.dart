import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/mf_order.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/entities/params/mutual_funds/get_mf_order_params.dart';
import '../../../../domain/usecases/assisted_service/get_assisted_orders.dart';

part 'assisted_orders_state.dart';

@injectable
class AssistedOrdersCubit extends Cubit<AssistedOrdersState> {
  final GetAssistedOrders _getAssistedOrders;

  AssistedOrdersCubit(this._getAssistedOrders) : super(AssistedOrdersInitial());

  int _from = 0;
  final int _pageSize = 10;

  Future<void> fetchOrders({
    required int userId,

    ///If orderStatus is null, this will get all orders(Pending,Successful,Failure)
    MFOrderStatus? orderStatus,
    int? limit,
  }) async {
    if (state is AssistedOrdersLoading) return;
    List<MfOrder> oldOrders = [];
    if (state is AssistedOrdersLoaded) {
      oldOrders = (state as AssistedOrdersLoaded).orders;
    } else if (state is AssistedOrdersLoadError) {
      oldOrders = (state as AssistedOrdersLoadError).oldOrders;
    }
    emit(AssistedOrdersLoading(isFirstFetch: _from == 0, oldOrders: oldOrders));
    final response = await _getAssistedOrders(GetMfOrderParams(userId: userId, isAllOrders: orderStatus == null, from: _from, limit: _pageSize, status: orderStatus));
    response.fold((l) => emit(AssistedOrdersLoadError(l.errorType, l.error, isFirstFetch: _from == 0, oldOrders: oldOrders)), (r) {
      List<MfOrder> newOrders = r;
      if (newOrders.length < _pageSize) {
        emit(AssistedOrdersLoaded(oldOrders, isLastPage: true));
      } else {
        _from += _pageSize;
        emit(AssistedOrdersLoaded(oldOrders + newOrders, isLastPage: false));
      }
    });
  }

  ///Function to fetch pending orders with _pageSize=1000 without pagination

  Future<void> fetchPendingOrders({
    required int userId,
  }) async {
    emit(const AssistedOrdersLoading());
    final response = await _getAssistedOrders(GetMfOrderParams(userId: userId, isAllOrders: false, from: 0, limit: 1000, status: MFOrderStatus.pending));
    emit(response.fold((l) => AssistedOrdersLoadError(l.errorType, l.error), (r) => AssistedOrdersLoaded(r)));
    return;
  }

  ///Function to refresh pending orders with _pageSize=1000 without pagination

  Future<void> refreshPendingOrders({
    required int userId,
  }) async {
    if (state is AssistedOrdersLoaded) {
      final List<MfOrder> pendingOrders = (state as AssistedOrdersLoaded).orders;
      final response = await _getAssistedOrders(GetMfOrderParams(userId: userId, isAllOrders: false, from: 0, limit: 1000, status: MFOrderStatus.pending));
      //This is added so as to prevent issue of refreshing issue of ExpandableSliverList
      emit(const AssistedOrdersLoading());
      emit(response.fold(
        (l) => AssistedOrdersLoaded(pendingOrders),
        (r) => AssistedOrdersLoaded(r),
      ));
      return;
    } else {
      return await fetchPendingOrders(userId: userId);
    }
  }
}
