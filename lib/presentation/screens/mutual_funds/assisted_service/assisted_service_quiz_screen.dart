import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/common.dart';
import '../../../cubits/assisted_service/questions_cubit/questions_cubit.dart';
import '../../../cubits/assisted_service/submit_choices_cubit/submit_choices_cubit.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';
import '../../loading_screen.dart';

class AssistedServiceQuizScreen extends StatefulWidget {
  const AssistedServiceQuizScreen({Key? key}) : super(key: key);

  @override
  State<AssistedServiceQuizScreen> createState() =>
      _AssistedServiceQuizScreenState();
}

class _AssistedServiceQuizScreenState extends State<AssistedServiceQuizScreen> {
  late final PageController _pageController;
  late final List<int?> _selectedChoiceIds;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      child: WillPopScope(
        onWillPop: () async {
          //If the questions are not loaded yet, then we can allow the user to go back
          if (context.read<QuestionsCubit>().state is! QuestionsLoaded) {
            return true;
          }
          if (_pageController.page == 0) {
            return true;
          } else {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic);
            return false;
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: BlocListener<SubmitChoicesCubit, SubmitChoicesState>(
              listener: (context, state) {
                if (state is SubmitChoicesSuccess) {
                  final user = context.read<AuthCubit>().state.user!;
                  context.read<AuthCubit>().updateUser(
                        user.copyWith(isRiskProfileTaken: true),
                      );

                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.analyseAssistedService,
                      (route) => route.settings.name == Routes.dashboard);
                }
                if (state is SubmitChoicesFailure) {
                  Utils.showErrorAlert(
                    context,
                    Utils.getErrorMessage(
                        errorType: state.errorType, msg: state.error),
                  );
                }
              },
              child: BlocConsumer<QuestionsCubit, QuestionsState>(
                listener: (context, state) {
                  if (state is QuestionsLoaded) {
                    _selectedChoiceIds =
                        List.filled(state.questions.length, null);
                  }
                },
                builder: (context, state) {
                  if (state is QuestionsLoading) {
                    return const Center(child: CustomLoader());
                  }
                  if (state is QuestionsLoadError) {
                    return Center(
                      child: AppErrorWidget(
                          errorType: state.errorType, error: state.error),
                    );
                  }
                  if (state is QuestionsLoaded) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      child: Column(
                        children: [
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: state.questions.length,
                            effect: const WormEffect(
                              dotWidth: 20,
                              radius: 0,
                              dotHeight: 5,
                              dotColor: Color(0xFFDDDDDD),
                              activeDotColor: AppColors.primaryColor,
                            ),
                          ),
                          Expanded(
                            child: PageView.builder(
                              controller: _pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.questions.length,
                              itemBuilder: (context, index) {
                                final question = state.questions[index];
                                return Column(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Question ${index + 1}',
                                            style: const TextStyle(
                                              color: AppColors.secondaryViolet,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const Gap(20),
                                          Text(
                                            state.questions[index].question,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          const Gap(20),
                                          ...List.generate(
                                            question.choices.length,
                                            (choiceIndex) {
                                              final choices =
                                                  question.choices[choiceIndex];
                                              return _QuizOption(
                                                text: choices.name,
                                                isSelected:
                                                    _selectedChoiceIds[index] ==
                                                        choices.choiceId,
                                                onTap: () {
                                                  HapticFeedback
                                                      .selectionClick();
                                                  setState(() {
                                                    _selectedChoiceIds[index] =
                                                        question
                                                            .choices[
                                                                choiceIndex]
                                                            .choiceId;
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              if (_selectedChoiceIds[index] ==
                                                  null) {
                                                Utils.showWarningAlert(context,
                                                    'Please select an option');
                                                return;
                                              }
                                              if (_pageController.page ==
                                                  state.questions.length - 1) {
                                                context
                                                    .read<SubmitChoicesCubit>()
                                                    .submitChoices(
                                                        userId: context
                                                            .read<AuthCubit>()
                                                            .state
                                                            .user!
                                                            .id,
                                                        choiceList:
                                                            _selectedChoiceIds
                                                                .map((e) => e!)
                                                                .toList());
                                              } else {
                                                _pageController.nextPage(
                                                    duration: const Duration(
                                                      milliseconds: 300,
                                                    ),
                                                    curve: Curves.linear);
                                              }
                                            },
                                            child: Text(_pageController.position
                                                        .haveDimensions &&
                                                    _pageController.page ==
                                                        state.questions.length -
                                                            1
                                                ? 'Submit'
                                                : 'Next'))),
                                    const Gap(20),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _QuizOption(
      {Key? key,
      required this.text,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? const Color(0xFF0C97F0) : AppColors.darkGrey,
        ),
      ),
      child: RadioTheme(
        data: RadioThemeData(
            splashRadius: 29,
            overlayColor: MaterialStateProperty.all(
              AppColors.darkGrey,
            )),
        child: ListTile(
          selected: isSelected,
          contentPadding: const EdgeInsets.all(8),
          selectedTileColor: const Color(0xFF98D7FF),
          selectedColor: AppColors.mainBlack,
          onTap: onTap,
          leading: isSelected
              ? const Icon(
                  Icons.radio_button_checked,
                  color: Color(0xFF3278CC),
                  size: 30,
                )
              : const Icon(
                  Icons.radio_button_unchecked,
                  color: AppColors.darkGrey,
                  size: 30,
                ),
          title: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
