import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/enums.dart';

part 'mf_returns_switch_state.dart';

@injectable
class MfReturnsSwitchCubit extends Cubit<MfReturnsSwitchState> {
  MfReturnsSwitchCubit() : super(const MfReturnsSwitchLoaded(ReturnsType.fiveYear));

  void switchReturns() {
    final int max = ReturnsType.values.length;
    final int curr = state.returnsType.index;
    return emit(MfReturnsSwitchLoaded(ReturnsType.values[(curr + 1) % max]));
  }
}
