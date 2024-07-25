import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/enums.dart';

part 'mf_sort_by_switch_state.dart';

@injectable
class MfSortBySwitchCubit extends Cubit<MfSortBySwitchState> {
  MfSortBySwitchCubit() : super(const MfSortBySwitchLoaded(MFSortBy.currInvested));

  void switchSortBy() {
    final int max = MFSortBy.values.length;
    final int curr = state.sortBy.index;
    return emit(MfSortBySwitchLoaded(MFSortBy.values[(curr + 1) % max]));
  }
}
