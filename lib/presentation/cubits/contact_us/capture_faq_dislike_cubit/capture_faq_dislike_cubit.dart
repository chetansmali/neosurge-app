import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/params/contact_us/capture_faq_dislike_params.dart';
import '../../../../domain/usecases/contact_us/capture_faq_dislike.dart';

part 'capture_faq_dislike_state.dart';

@injectable
class CaptureFaqDislikeCubit extends Cubit<CaptureFaqDislikeState> {
  final CaptureFaqDislike _captureFaqDislike;
  CaptureFaqDislikeCubit(this._captureFaqDislike)
      : super(CaptureFaqDislikeInitial());

  void submitFeeback(
      {required String faqId,
      required String dislikeReason,
      required String message}) async {
    emit(CaptureFaqDislikeLoading());
    await Future.delayed(const Duration(seconds: 6));
    final response = await _captureFaqDislike(CaptureFaqDislikeParams(
        faqId: faqId, dislikeReason: dislikeReason, message: message));
    emit(response.fold(
        (l) => CaptureFaqDislikeStateFailure(
            errorType: l.errorType, errorMessage: l.error),
        (r) => CaptureFaqDislikeSuccess()));
  }
}
