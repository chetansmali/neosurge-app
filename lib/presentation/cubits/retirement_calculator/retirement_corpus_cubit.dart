import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/retirement_calculator/returement_corpus_model.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/params/retirement_calculator/retirement_corpus_params.dart';
import '../../../domain/usecases/retirement_calculator/get_retirement_corpus.dart';

part 'retirement_corpus_state.dart';

@injectable
class RetirementCorpusCubit extends Cubit<RetirementCorpusState> {
  final GetRetirementCorpus getRetirementCorpus;
  RetirementCorpusCubit(this.getRetirementCorpus)
      : super(RetirementCorpusInitial());

  Future fetchRetirementCorpus(RetirementCorpusParams params) async {
    emit(RetirementCorpusLoading());
    final response = await getRetirementCorpus(params);
    response.fold(
        (l) => emit(RetirementCorpusFailure(
            errorType: l.errorType, errorMessage: l.error)),
        (r) => emit(RetirementCorpusSuccess(r)));
  }
}
