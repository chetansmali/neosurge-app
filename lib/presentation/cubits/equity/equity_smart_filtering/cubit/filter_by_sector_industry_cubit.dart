import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data/models/equity/smart_filtering/filter_by_sector_industry_details.dart';
import '../../../../../domain/entities/app_error.dart';
import '../../../../../domain/entities/params/equity/equity_smart_watchlist/filter_by_sector_industry_params.dart';
import '../../../../../domain/usecases/equity/filter_by_sector_industry.dart';
part 'filter_by_sector_industry_state.dart';

@Injectable()
class FilterBySectorIndustryCubit extends Cubit<FilterBySectorIndustryState> {
  final FilterBySectorIndustry _filterBySectorIndustry;
  FilterBySectorIndustryCubit(this._filterBySectorIndustry)
      : super(FilterBySectorIndustryInitial());
  void filterBySectorIndustry(FilterBySectorIndustryParams params) async {
    emit(FilterBySectorIndustryLoading());
    final response = await _filterBySectorIndustry(params);
    emit(response.fold(
        (l) => FilterBySectorIndustryFailure(l.error, l.errorType),
        (r) => FilterBySectorIndustrySuccess(r)));
  }
}
