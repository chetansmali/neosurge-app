import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_page_state.dart';

@LazySingleton()
class OnboardingPageCubit extends Cubit<OnboardingPageState> {
  OnboardingPageCubit() : super(const OnboardingInitial());

  void goToNextPage() {
    log('OnboardingPageCubit: goToNextPage, state.pageIndex: ${state.pageIndex}, state.maxCompletedStep: ${state.maxCompletedStep}');
    emit(
      OnboardingPageChanged(
        page: state.pageIndex + 1,
        maxStep: state.maxCompletedStep >= state.pageIndex
            ? state.maxCompletedStep
            : state.pageIndex,
        kycCompliant: state.isKycCompliant,
      ),
    );
  }

  void goToPreviousPage() => emit(
        OnboardingPageChanged(
          page: state.pageIndex - 1,
          maxStep: state.maxCompletedStep,
          kycCompliant: state.isKycCompliant,
          isDirectionForward: false,
        ),
      );

  void setPage(
    int page, {
    required int maxCompletedStep,
    required bool isKycCompliant,
    required String lastRoute,
  }) =>
      emit(
        OnboardingPageChanged(
          page: page,
          maxStep: maxCompletedStep,
          kycCompliant: isKycCompliant,
        ),
      );

  void reset() => emit(const OnboardingInitial());
}
