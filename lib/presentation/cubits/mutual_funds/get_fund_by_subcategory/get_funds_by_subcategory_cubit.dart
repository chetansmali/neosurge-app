import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/mutual_funds/mutual_fund.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/mutual_funds/get_funds_by_subcategory_params.dart';
import '../../../../domain/usecases/mutual_funds/get_fund_by_subcategory.dart';

part 'get_funds_by_subcategory_state.dart';

@injectable
class GetFundBySubcategoryCubit extends Cubit<GetFundBySubcategoryState> {
  GetFundBySubcategoryCubit(this._getFundsBySubCategory)
      : super(const GetFundBySubcategoryInitial());

  final GetFundsBySubCategory _getFundsBySubCategory;

  int currentPage = 0;
  final int size = 20;

  void getFundsBySubcategory({
    required String subCategory,
    required String category,
    String? sort,
    int? page,
  }) async {
    if (state is GetFundBySubcategoryLoading) return;

    List<MutualFund> oldFundList = state.fundList ?? [];
    currentPage = page ?? currentPage;

    emit(
      GetFundBySubcategoryLoading(
        oldFundList: oldFundList,
      ),
    );

    final response = await _getFundsBySubCategory(
      GetFundsBySubCategoryParams(
        page: currentPage,
        size: size,
        subCategory: subCategory,
        category: category,
        sort: sort ?? '_3Y,DESC',
      ),
    );

    response.fold(
      (l) => emit(
        GetFundBySubcategoryLoadError(
          oldFundList: oldFundList,
          error: l.error,
          errorType: l.errorType,
        ),
      ),
      (r) {
        currentPage++;
        oldFundList.addAll(r);
        emit(
          GetFundBySubcategoryLoaded(
            newFundList: oldFundList,
            isLastPage: r.length < size,
          ),
        );
      },
    );
  }
}
