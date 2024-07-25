part of 'ocr_read_cubit.dart';

abstract class OcrReadState extends Equatable {
  const OcrReadState();
}

class OcrReadInitial extends OcrReadState {
  @override
  List<Object> get props => [];
}

class OcrReadLoading extends OcrReadState {
  @override
  List<Object> get props => [];
}

class OcrReadLoaded extends OcrReadState {
  final OcrReadResponseModel ocrResponse;

  const OcrReadLoaded({required this.ocrResponse});

  @override
  List<Object> get props => [ocrResponse];
}

class OcrReadFailure extends OcrReadState {
  final String? errorMessage;
  final AppErrorType appErrorType;

  const OcrReadFailure({required this.appErrorType, this.errorMessage});

  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
