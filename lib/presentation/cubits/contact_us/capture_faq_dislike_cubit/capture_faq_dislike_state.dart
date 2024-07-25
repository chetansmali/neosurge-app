part of 'capture_faq_dislike_cubit.dart';

abstract class CaptureFaqDislikeState extends Equatable {
  const CaptureFaqDislikeState();
}

class CaptureFaqDislikeInitial extends CaptureFaqDislikeState {
    @override
  List<Object> get props => [];
}

class CaptureFaqDislikeLoading extends CaptureFaqDislikeState {
  @override
  List<Object> get props => [];
}

class CaptureFaqDislikeStateFailure extends CaptureFaqDislikeState {
  final AppErrorType errorType;
  final String? errorMessage;

  const CaptureFaqDislikeStateFailure({
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}

class CaptureFaqDislikeSuccess extends CaptureFaqDislikeState
{
  @override
  List<Object> get props => [];
}