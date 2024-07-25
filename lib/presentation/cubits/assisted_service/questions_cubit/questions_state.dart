part of 'questions_cubit.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();
}

class QuestionsInitial extends QuestionsState {
  @override
  List<Object> get props => [];
}

class QuestionsLoading extends QuestionsState {
  @override
  List<Object> get props => [];
}

class QuestionsLoaded extends QuestionsState {
  final List<Question> questions;

  const QuestionsLoaded(this.questions);

  @override
  List<Object> get props => [questions];
}

class QuestionsLoadError extends QuestionsState {
  final String? error;
  final AppErrorType errorType;

  const QuestionsLoadError(this.error, this.errorType);

  @override
  List<Object?> get props => [error, errorType];
}
