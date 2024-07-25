import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/enums.dart';

part 'discovery_animation_state.dart';

@injectable
class DiscoveryAnimationCubit extends Cubit<DiscoveryAnimationState> {
  DiscoveryAnimationCubit() : super(const DiscoveryAnimationInitial());

  DiscoveryAnimationType animationType =
      DiscoveryAnimationType.forwardNeoCardsAnimation;

  int _currentIndex = 0;

  void forwardNeoCardsAnimation() {
    emit(
      ForwardNeoCardsAnimation(currentIndex: _currentIndex),
    );

    if (_currentIndex == 3) {
      animationType = DiscoveryAnimationType.forwardNeoPassesAnimation;
    } else {
      _currentIndex++;
    }
  }

  void forwardNeoPassesAnimation() {
    animationType = DiscoveryAnimationType.forwardTransactionAnimation;
    emit(
      const ForwardNeoPassesAnimation(),
    );
  }

  void forwardTransactionAnimation() {
    animationType = DiscoveryAnimationType.discoveryAnimationCompleted;

    emit(
      const ForwardTransactionAnimation(),
    );
  }
}
