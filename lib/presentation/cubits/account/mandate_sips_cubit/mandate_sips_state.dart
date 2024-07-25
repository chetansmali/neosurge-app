part of 'mandate_sips_cubit.dart';

abstract class MandateSipsState extends Equatable {
  const MandateSipsState();
}

class MandateSipsInitial extends MandateSipsState {
  @override
  List<Object> get props => [];
}

class MandateSipsLoading extends MandateSipsState {
  @override
  List<Object> get props => [];
}

class MandateSipsSuccess extends MandateSipsState {
  final List<MandateSipModel> mandateSips;

  const MandateSipsSuccess({
    required this.mandateSips,
  });

  @override
  List<Object> get props => [];
}

class MandateSipsFailure extends MandateSipsState {
  final AppErrorType errorType;
  final String? error;

  const MandateSipsFailure({required this.errorType, this.error});

  @override
  List<Object?> get props => [errorType, error];
}
