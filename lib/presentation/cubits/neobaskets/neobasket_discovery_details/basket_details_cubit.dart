import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/models/neobaskets/basket_details.dart';
import '../../../../domain/entities/params/neobaskets/basket_details_params.dart';
import '../../../../domain/usecases/neobaskets/get_basket_details.dart';
import '../../../../domain/entities/app_error.dart';

part 'basket_details_state.dart';

@injectable
class BasketDetailsCubit extends Cubit<BasketDetailsState> {
  final GetBasketDetails _basketDetails;

  BasketDetailsCubit(
    this._basketDetails,
  ) : super(BasketDetailsInitial());

  void getBasketDetails(BasketDetailsParams param) async {
    emit(BasketDetailsLoading());
    final response = await _basketDetails(
      param,
    );

    emit(
      response.fold(
        (l) => BasketDetailsFailure(l.error, l.errorType),
        (r) => BasketDetailsSuccess(r),
      ),
    );
  }
}
