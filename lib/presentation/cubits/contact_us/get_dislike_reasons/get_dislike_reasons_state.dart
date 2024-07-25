part of 'get_dislike_reasons_cubit.dart';

abstract class GetDislikeReasonsState extends Equatable {
  const GetDislikeReasonsState();

}

class GetDislikeReasonsInitial extends GetDislikeReasonsState {
  
  @override
  List<Object> get props => [];
}

class GetDislikeReasonsLoading extends GetDislikeReasonsState {
  @override
  List<Object> get props => [];
}

class GetDislikeReasonsLoaded extends GetDislikeReasonsState {
  final List<String> getDislikereasonslist;
  final List<String> selectedReasons;

  const GetDislikeReasonsLoaded(this.getDislikereasonslist, this.selectedReasons);

  @override
  List<Object> get props => [getDislikereasonslist, selectedReasons];
}

class GetDislikeReasonsLoadError extends GetDislikeReasonsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetDislikeReasonsLoadError({
    required this.errorType,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
