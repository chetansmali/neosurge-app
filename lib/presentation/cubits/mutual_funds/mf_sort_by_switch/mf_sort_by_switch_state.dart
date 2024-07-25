part of 'mf_sort_by_switch_cubit.dart';

abstract class MfSortBySwitchState extends Equatable {
  final MFSortBy sortBy;

  const MfSortBySwitchState(this.sortBy);
}

class MfSortBySwitchLoaded extends MfSortBySwitchState {
  const MfSortBySwitchLoaded(MFSortBy sortBy) : super(sortBy);

  @override
  List<Object> get props => [sortBy];
}
