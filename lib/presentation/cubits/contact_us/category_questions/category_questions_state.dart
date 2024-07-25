part of 'category_questions_cubit.dart';

abstract class CategoryQuestionsState extends Equatable {
  const CategoryQuestionsState();
}

class CategoryQuestionsInitial extends CategoryQuestionsState {
  
  @override
  List<Object> get props => [];
}

class CategoryQuestionsLoading extends CategoryQuestionsState {
  @override
  List<Object> get props => [];
}

class CategoryQuestionsLoaded extends CategoryQuestionsState {
  final List<ContactUsQuestionsModel> contactusQuestionsList;

  const CategoryQuestionsLoaded(this.contactusQuestionsList);

  @override
  List<Object> get props => [];
}

class CategoryQuestionsLoadError extends CategoryQuestionsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const CategoryQuestionsLoadError(
      {required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
