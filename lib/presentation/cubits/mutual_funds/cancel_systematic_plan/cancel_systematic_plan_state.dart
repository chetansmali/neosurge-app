part of 'cancel_systematic_plan_cubit.dart';

abstract class CancelSystematicPlanState extends Equatable {
  const CancelSystematicPlanState();
}

class CancelSystematicPlanInital extends CancelSystematicPlanState {
  @override
  List<Object> get props => [];
}

class CancelSystematicPlanLoading extends CancelSystematicPlanState {
  @override
  List<Object> get props => [];
}

class CancelSystematicPlanSuccess extends CancelSystematicPlanState {
  @override
  List<Object> get props => [];
}

class CancelSystematicPlanError extends CancelSystematicPlanState {
  final AppErrorType errorType;
  final String? errorMessage;

  const CancelSystematicPlanError({required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
