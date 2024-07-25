part of 'confirm_pan_cubit.dart';

abstract class ConfirmPanState extends Equatable {
  const ConfirmPanState();
}

class ConfirmPanInitial extends ConfirmPanState {
  @override
  List<Object> get props => [];
}

class ConfirmPanLoading extends ConfirmPanState {
  final bool isFetch;

  const ConfirmPanLoading({this.isFetch = false});

  @override
  List<Object> get props => [isFetch];
}

class ConfirmPanSuccess extends ConfirmPanState {
  final bool isFetch;
  final GetKycDataModel? kycData;

  const ConfirmPanSuccess({this.isFetch = false, this.kycData});

  @override
  List<Object?> get props => [isFetch, kycData];
}

class ConfirmPanFailure extends ConfirmPanState {
  final bool isFetch;
  final String? errorMessage;
  final AppErrorType errorType;

  const ConfirmPanFailure({this.errorMessage, required this.errorType, this.isFetch = false});

  @override
  List<Object?> get props => [errorMessage, errorType, isFetch];
}
