import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/equity/equity_explore/index_price.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/equity/equity_explore/index_price_params.dart';
import '../../../../domain/usecases/equity/get_index_price.dart';

part 'index_price_banner_state.dart';

@injectable
class IndexPriceBannerCubit extends Cubit<IndexPriceBannerState> {
  final GetIndexPrice getindexPrice;

  IndexPriceBannerCubit(this.getindexPrice) : super(IndexPriceBannerInitial());

  Future<void> fetchIndexPrice(IndexPriceParams params) async {
    emit(IndexPriceBannerLoading());
    final response = await getindexPrice(params);
    response.fold(
        (l) => emit(IndexPriceBannerFailure(
            errorType: l.errorType, errorMessage: l.error)), (r) {
      emit(IndexPriceBannerLoaded(r));
    });
  }
}
