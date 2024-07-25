part of 'systematic_plan_installments_cubit.dart';

abstract class SystematicPlanInstallmentsState extends Equatable {
  const SystematicPlanInstallmentsState();
}

class SipInstallmentsInitial extends SystematicPlanInstallmentsState {
  @override
  List<Object> get props => [];
}

class SystematicPlanInstallmentsLoading extends SystematicPlanInstallmentsState {
  @override
  List<Object> get props => [];
}

class SystematicPlanInstallmentsLoaded extends SystematicPlanInstallmentsState {
  final List<InstallmentDTO> installments;

  const SystematicPlanInstallmentsLoaded(this.installments);

  @override
  List<Object> get props => [installments];
}

class SystematicPlanInstallmentsError extends SystematicPlanInstallmentsState {
  final AppErrorType errorType;
  final String? error;

  const SystematicPlanInstallmentsError(this.errorType, this.error);

  @override
  List<Object?> get props => [errorType, error];
}
