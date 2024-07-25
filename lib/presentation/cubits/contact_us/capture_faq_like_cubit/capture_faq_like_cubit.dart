import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/contact_us/capture_faq_like_params.dart';
import '../../../../domain/usecases/contact_us/capture_faq_like.dart';

part 'capture_faq_like_state.dart';

@injectable
class CaptureFaqLikeCubit extends Cubit<CaptureFaqLikeState> {
  final CaptureFaqLike _captureFaqLike;
  CaptureFaqLikeCubit(this._captureFaqLike) : super(CaptureFaqLikeInitial());

  void submitfeeback({required String faqId}) async {
    emit(CaptureFaqLikeLoading());
    await Future.delayed(const Duration(seconds: 6));
    final response = await _captureFaqLike(CaptureFaqLikeParams(id: faqId));
    emit(response.fold(
        (l) => CaptureFaqLikeStateFailure(
            errorType: l.errorType, errorMessage: l.error),
        (r) => CaptureFaqLikeSuccess()));
  }
}
