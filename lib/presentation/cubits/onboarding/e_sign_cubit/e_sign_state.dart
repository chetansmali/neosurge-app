part of 'e_sign_cubit.dart';

abstract class ESignState extends Equatable {
  const ESignState();
}

class ESignInitial extends ESignState {
  @override
  List<Object> get props => [];
}

class ESignLoading extends ESignState {
  const ESignLoading();

  @override
  List<Object> get props => [];
}

class ESignLoadSuccess extends ESignState {
  final String eSignUrl;

  const ESignLoadSuccess({
    required this.eSignUrl,
  });

  @override
  List<Object> get props => [eSignUrl];
}

class ESignSubmitSuccess extends ESignState {
  const ESignSubmitSuccess();

  @override
  List<Object> get props => [];
}

class ESignFailure extends ESignState {
  final String? errorMessage;
  final AppErrorType errorType;

  const ESignFailure({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
