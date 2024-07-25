part of 'category_questions_detail_cubit.dart';

abstract class CategoryQuestionsDetailState extends Equatable {
  const CategoryQuestionsDetailState();
}

class CategoryQuestionsDetailInitial extends CategoryQuestionsDetailState {
  @override
  List<Object> get props => [];
}

class CategoryQuestionsDetailLoading extends CategoryQuestionsDetailState {
  @override
  List<Object> get props => [];
}

class CategoryQuestionsDetailLoaded extends CategoryQuestionsDetailState {
  final ContactUsQuestionsModel contactUsQuestionsModel;

  const CategoryQuestionsDetailLoaded(this.contactUsQuestionsModel);
  @override
  List<Object> get props => [];
}

class CategoryQuestionsDetailLoadError extends CategoryQuestionsDetailState {
  final AppErrorType errorType;
  final String? errorMessage;

  const CategoryQuestionsDetailLoadError(
      {required this.errorType, this.errorMessage});

  @override
  List<Object?> get props => [errorType, errorMessage];
}
