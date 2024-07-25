import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/enums.dart';

part 'mf_orders_filter_sort_state.dart';

@injectable
class MfOrdersFilterSortCubit extends Cubit<MfOrdersFilterSortState> {
  MfOrdersFilterSortCubit() : super(const MfOrdersFilterSortInitial());

  void applyFilter(MFOrderStatus orderStatus) {
    emit(MfOrdersFilterSortInitial(orderStatus: orderStatus));
  }

  void clearFilter() {
    emit(const MfOrdersFilterSortInitial());
  }
}
