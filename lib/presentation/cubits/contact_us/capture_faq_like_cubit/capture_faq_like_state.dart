part of 'capture_faq_like_cubit.dart';

abstract class CaptureFaqLikeState extends Equatable {
  const CaptureFaqLikeState();
}

class CaptureFaqLikeInitial extends CaptureFaqLikeState {
    @override
  List<Object> get props => [];
}

class CaptureFaqLikeLoading extends CaptureFaqLikeState {
  @override
  List<Object> get props => [];
}

class CaptureFaqLikeStateFailure extends CaptureFaqLikeState {
  final AppErrorType errorType;
  final String? errorMessage;

  const CaptureFaqLikeStateFailure({
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}

class CaptureFaqLikeSuccess extends CaptureFaqLikeState
{
  @override
  List<Object> get props => [];
}
