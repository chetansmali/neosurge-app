import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/nav_tab_entity.dart';

part 'nav_state.dart';

@injectable
class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavChanged(navTabEntity: NavTabEntity()));

  void changeTab(NavTabEntity navTabEntity) {
    emit(NavChanged(navTabEntity: navTabEntity));
  }

  void resetTabStates() {
    emit(const NavChanged(navTabEntity: NavTabEntity()));
  }
}
