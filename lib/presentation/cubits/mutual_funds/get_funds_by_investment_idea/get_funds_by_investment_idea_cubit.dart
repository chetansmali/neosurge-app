import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/mutual_fund.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_funds_by_investment_idea_params.dart';
import '../../../../domain/usecases/mutual_funds/get_funds_by_investment_idea.dart';

part 'get_funds_by_investment_idea_state.dart';

@injectable
class GetFundsByInvestmentIdeaCubit
    extends Cubit<GetFundsByInvestmentIdeaState> {
  final GetFundsByInvestmentIdea _getFundsByInvestmentIdea;

  int currentPage = 0;
  final int size = 20;
  String currentFilter = '';

  GetFundsByInvestmentIdeaCubit(this._getFundsByInvestmentIdea)
      : super(
          const GetFundsByInvestmentIdeaInitial(),
        );

  void getFundsByInvestmentIdea({
    required String viewKey,
    String? filter,
    String? sort,
    int? page,
  }) async {
    if (state is GetFundsByInvestmentIdeaLoading) return;

    List<MutualFund> oldFundList = state.fundList ?? [];
    currentPage = page ?? currentPage;
    filter = filter ?? currentFilter;

    if (currentPage == 0) oldFundList.clear();

    emit(
      GetFundsByInvestmentIdeaLoading(
        oldFundList: oldFundList,
        isFirstFetch: currentPage == 0,
      ),
    );

    final response = await _getFundsByInvestmentIdea(
      GetFundsByInvestmentIdeaParams(
        page: currentPage,
        size: size,
        viewKey: viewKey,
        filter: filter,
        sort: sort ?? '_3Y,DESC',
      ),
    );

    response.fold(
      (l) => emit(
        GetFundsByInvestmentIdeaLoadFailure(
          oldFundList: oldFundList,
          error: l.error,
          errorType: l.errorType,
        ),
      ),
      (r) {
        currentPage++;
        oldFundList.addAll(r);

        emit(
          GetFundsByInvestmentIdeaLoaded(
            newFundList: oldFundList,
            isLastPage: r.length < size,
          ),
        );
      },
    );
  }
}
