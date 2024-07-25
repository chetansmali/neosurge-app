import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_investment_idea_filters_params.dart';
import '../../../../domain/usecases/mutual_funds/get_investment_idea_filters.dart';

part 'get_investment_idea_filters_state.dart';

@injectable
class GetInvestmentIdeaFiltersCubit
    extends Cubit<GetInvestmentIdeaFiltersState> {
  final GetInvestmentIdeaFilters _getInvestmentIdeaFilters;

  GetInvestmentIdeaFiltersCubit(this._getInvestmentIdeaFilters)
      : super(const GetInvestmentIdeaFiltersInitial());

  void getInvestmentIdeaFilters({
    required String viewKey,
  }) async {
    if (state is GetInvestmentIdeaFiltersLoading) return;

    emit(const GetInvestmentIdeaFiltersLoading());

    final response = await _getInvestmentIdeaFilters(
      GetInvestmentIdeaFiltersParams(
        viewKey: viewKey,
      ),
    );

    response.fold(
      (l) => emit(
        GetInvestmentIdeaFiltersError(l.errorType, l.error),
      ),
      (r) => emit(
        GetInvestmentIdeaFiltersLoaded(r),
      ),
    );
  }
}
