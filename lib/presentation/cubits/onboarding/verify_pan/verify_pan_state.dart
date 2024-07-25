part of 'verify_pan_cubit.dart';

abstract class VerifyPanState extends Equatable {
  final VerifyPanResponseModel? panResponse;

  const VerifyPanState({this.panResponse});
}

class VerifyPanInitial extends VerifyPanState {
  @override
  List<Object> get props => [];
}

class VerifyPanLoading extends VerifyPanState {
  @override
  List<Object> get props => [];
}

class VerifyPanSuccess extends VerifyPanState {
  final VerifyPanResponseModel verifyPanResponseModel;

  const VerifyPanSuccess({required this.verifyPanResponseModel})
      : super(panResponse: verifyPanResponseModel);

  @override
  List<Object> get props => [];
}

class VerifyPanFailure extends VerifyPanState {
  final String? errorMessage;
  final AppErrorType errorType;

  const VerifyPanFailure({
    this.errorMessage,
    required this.errorType,
  });

  @override
  List<Object?> get props => [errorMessage, errorType];
}
