part of 'discovery_animation_cubit.dart';

abstract class DiscoveryAnimationState extends Equatable {
  final int currentAnimationIndex;

  const DiscoveryAnimationState({
    this.currentAnimationIndex = 0,
  });
}

class DiscoveryAnimationInitial extends DiscoveryAnimationState {
  const DiscoveryAnimationInitial()
      : super(
          currentAnimationIndex: 0,
        );

  @override
  List<Object> get props => [];
}

class ForwardNeoCardsAnimation extends DiscoveryAnimationState {
  final int currentIndex;

  const ForwardNeoCardsAnimation({
    required this.currentIndex,
  }) : super(
          currentAnimationIndex: currentIndex,
        );

  @override
  List<Object> get props => [
        currentIndex,
      ];
}

class ForwardNeoPassesAnimation extends DiscoveryAnimationState {
  const ForwardNeoPassesAnimation();

  @override
  List<Object> get props => [];
}

class ForwardTransactionAnimation extends DiscoveryAnimationState {
  const ForwardTransactionAnimation();

  @override
  List<Object> get props => [];
}
