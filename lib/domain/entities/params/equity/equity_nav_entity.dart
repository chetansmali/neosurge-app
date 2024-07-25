import 'package:equatable/equatable.dart';

class EquityNavEntity extends Equatable {
  final int mainTabIndex;

  const EquityNavEntity({
    this.mainTabIndex = 0,
  });

  EquityNavEntity copyWith({
    int? mainTabIndex,
  }) {
    return EquityNavEntity(
      mainTabIndex: mainTabIndex ?? this.mainTabIndex,
    );
  }

  @override
  List<Object> get props => [mainTabIndex];
}
