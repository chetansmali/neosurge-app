part of 'equity_nav_cubit.dart';

abstract class EquityNavState extends Equatable {
  final EquityNavEntity equityNavEntity;

  const EquityNavState({required this.equityNavEntity});
}

class EquityNavChanged extends EquityNavState {
  const EquityNavChanged({required EquityNavEntity equityNavEntity})
      : super(equityNavEntity: equityNavEntity);

  @override
  List<Object> get props => [equityNavEntity];
}
