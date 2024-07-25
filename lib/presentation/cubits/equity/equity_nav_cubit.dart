import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/params/equity/equity_nav_entity.dart';

part 'equity_nav_state.dart';

@injectable
class EquityNavCubit extends Cubit<EquityNavState> {
  EquityNavCubit()
      : super(
          const EquityNavChanged(
            equityNavEntity: EquityNavEntity(),
          ),
        );

  void equityChangeTab(EquityNavEntity equityNavEntity) {
    emit(EquityNavChanged(equityNavEntity: equityNavEntity));
  }

  void equityResetTabState() {
    emit(const EquityNavChanged(equityNavEntity: EquityNavEntity()));
  }
}
