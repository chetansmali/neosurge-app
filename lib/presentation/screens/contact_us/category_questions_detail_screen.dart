import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/utils.dart';
import '../../../di/get_it.dart';
import '../../cubits/contact_us/capture_faq_dislike_cubit/capture_faq_dislike_cubit.dart';
import '../../cubits/contact_us/capture_faq_like_cubit/capture_faq_like_cubit.dart';
import '../../cubits/contact_us/category_questions/category_questions_cubit.dart';
import '../../cubits/contact_us/get_dislike_reasons/get_dislike_reasons_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/custom_loader.dart';
import 'widgets/feedback_bottom_sheet_widget.dart';
import 'widgets/similar_question_tile.dart';
import '../../theme/app_colors.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/contact_us/category_questions_detail/category_questions_detail_cubit.dart';
import '../../routes/routes.dart';

class CategoryQuestionsDetailScreen extends StatelessWidget {
  final String title;
  final String articletitle;
  final String articleid;
  final String query;
  const CategoryQuestionsDetailScreen({
    super.key,
    required this.title,
    required this.articletitle,
    required this.articleid,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<CategoryQuestionsDetailCubit,
          CategoryQuestionsDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoryQuestionsDetailLoading) {
            return const Center(
              child: CustomLoader(),
            );
          }
          if (state is CategoryQuestionsDetailLoadError) {
            return Center(
              child: AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
              ),
            );
          }
          if (state is CategoryQuestionsDetailLoaded) {
            return ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary[50] ?? Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        articletitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary[500],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    horizontalTitleGap: 20.0,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    subtitle: Text(
                      state.contactUsQuestionsModel.answer ?? "",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.neutral[300],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Was this article helpful?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocConsumer<CaptureFaqLikeCubit, CaptureFaqLikeState>(
                        listener: (context, state) {
                          if (state is CaptureFaqLikeSuccess) {
                            Utils.showSuccessAlert(
                              context,
                              "Successful",
                            );
                          }
                          if (state is CaptureFaqLikeStateFailure) {
                            Utils.showErrorAlert(
                              context,
                              "Please try after sometime",
                            );
                          }
                        },
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              context.read<CaptureFaqLikeCubit>().submitfeeback(
                                    faqId: articleid,
                                  );
                            },
                            child: Assets.icons.thumbsUpIcon.image(
                              height: 24,
                              width: 24,
                            ),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) =>
                                        getIt<GetDislikeReasonsCubit>()
                                          ..fetchDislikeReasons(),
                                  ),
                                  BlocProvider(
                                    create: (context) =>
                                        getIt<CaptureFaqDislikeCubit>(),
                                  ),
                                ],
                                child: FeedBackBottomSheet(
                                  faqId: articleid,
                                ),
                              );
                            },
                          );
                        },
                        child: Assets.icons.thumbsDownIcon.image(
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Assets.icons.emailIcon.image(
                          height: 24,
                          width: 24,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.contactUsForm);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Need more assistance? ',
                            style: TextStyle(
                              color: AppColors.neutral[200],
                              fontSize: 12,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Contact us',
                                style: TextStyle(
                                  color: AppColors.primary[500],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Related articles',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                BlocBuilder<CategoryQuestionsCubit, CategoryQuestionsState>(
                  builder: (context, state) {
                    if (state is CategoryQuestionsLoading) {
                      return const Center(
                        child: CustomLoader(),
                      );
                    }
                    if (state is CategoryQuestionsLoadError) {
                      return Scaffold(
                        body: Center(
                          child: AppErrorWidget(
                            errorType: state.errorType,
                            error: state.errorMessage,
                          ),
                        ),
                      );
                    }
                    if (state is CategoryQuestionsLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.contactusQuestionsList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            SimiliarQuestionTile(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.categoryQuestionsDetail,
                              arguments: CategoryQuestionsDetailArgs(
                                title: title,
                                articletitle: state
                                    .contactusQuestionsList[index].question,
                                articleid:
                                    state.contactusQuestionsList[index].id,
                                query: state
                                    .contactusQuestionsList[index].question,
                              ),
                            );
                          },
                          title: state.contactusQuestionsList[index].question,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
