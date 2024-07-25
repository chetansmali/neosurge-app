part of 'mf_returns_switch_cubit.dart';

abstract class MfReturnsSwitchState extends Equatable {
  final ReturnsType returnsType;

  const MfReturnsSwitchState(this.returnsType);
}

class MfReturnsSwitchLoaded extends MfReturnsSwitchState {
  const MfReturnsSwitchLoaded(ReturnsType returnsType) : super(returnsType);

  @override
  List<Object> get props => [returnsType];
}
