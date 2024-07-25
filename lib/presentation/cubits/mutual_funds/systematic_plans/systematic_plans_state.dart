part of 'systematic_plans_cubit.dart';

abstract class SystematicPlansState extends Equatable {
  const SystematicPlansState();
}

class SystematicPlansInitial extends SystematicPlansState {
  @override
  List<Object> get props => [];
}

class SystematicPlansLoading extends SystematicPlansState {
  @override
  List<Object> get props => [];
}

class SystematicPlansLoaded extends SystematicPlansState {
  final List<SystematicPlan> plans;

  const SystematicPlansLoaded(this.plans);

  @override
  List<Object> get props => [plans];
}

class SystematicPlansError extends SystematicPlansState {
  final AppErrorType errorType;
  final String? error;

  const SystematicPlansError(this.errorType, this.error);

  @override
  List<Object?> get props => [errorType, error];
}
