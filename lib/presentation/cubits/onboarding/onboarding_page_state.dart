part of 'onboarding_page_cubit.dart';

abstract class OnboardingPageState extends Equatable {
  final int pageIndex;
  final int maxCompletedStep;
  final bool isKycCompliant;

  const OnboardingPageState(
    this.pageIndex, {
    required this.maxCompletedStep,
    required this.isKycCompliant,
  });
}

class OnboardingInitial extends OnboardingPageState {
  const OnboardingInitial()
      : super(
          0,
          maxCompletedStep: 0,
          isKycCompliant: false,
        );

  @override
  List<Object> get props => [];
}

class OnboardingPageChanged extends OnboardingPageState {
  final int page;
  final int maxStep;
  final bool kycCompliant;
  final bool isDirectionForward;

  const OnboardingPageChanged({
    required this.page,
    required this.maxStep,
    required this.kycCompliant,
    this.isDirectionForward = true,
  }) : super(
          page,
          maxCompletedStep: maxStep,
          isKycCompliant: kycCompliant,
        );

  @override
  List<Object> get props => [page];
}
