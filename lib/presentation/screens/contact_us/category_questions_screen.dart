import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/params/contact_us/get_category_questions_params.dart';
import '../../../gen/assets.gen.dart';
import '../../cubits/contact_us/category_questions/category_questions_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/custom_loader.dart';
import 'widgets/similar_question_tile.dart';

class CategoryQuestionsScreen extends StatefulWidget {
  final String title;
  final String? category;
  const CategoryQuestionsScreen(
      {super.key, required this.title, this.category});

  @override
  State<CategoryQuestionsScreen> createState() =>
      _CategoryQuestionsScreenState();
}

class _CategoryQuestionsScreenState extends State<CategoryQuestionsScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                context.read<CategoryQuestionsCubit>().fetchQuestions(
                      GetCategoryQuestionsParams(
                          query: _searchController.text,
                          category: widget.category),
                    );
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: 'Search for categories, keywords eg: KYC',
                hintStyle: const TextStyle(fontSize: 13),
                prefixIcon: Assets.icons.magniferHome.svg(
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                  fit: BoxFit.scaleDown,
                ),
                fillColor: Colors.white,
                focusColor: AppColors.primary[500],
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.primary[500] ?? Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.primary[50] ?? Colors.white,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.primary[50] ?? Colors.white,
                  ),
                ),
                filled: true,
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
            ),
          ),
        ),
      ),
      body: BlocBuilder<CategoryQuestionsCubit, CategoryQuestionsState>(
        builder: (context, state) {
          if (state is CategoryQuestionsLoading) {
            return const Center(
              child: CustomLoader(),
            );
          }
          if (state is CategoryQuestionsLoadError) {
            return Center(
              child: AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
              ),
            );
          }
          if (state is CategoryQuestionsLoaded) {
            return ListView.builder(
              itemCount: state.contactusQuestionsList.length,
              itemBuilder: (BuildContext context, int index) {
                return SimiliarQuestionTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.categoryQuestionsDetail,
                      arguments: CategoryQuestionsDetailArgs(
                        title: widget.title,
                        articletitle:
                            state.contactusQuestionsList[index].question,
                        articleid: state.contactusQuestionsList[index].id,
                        query: state.contactusQuestionsList[index].question,
                      ),
                    );
                  },
                  title: state.contactusQuestionsList[index].question,
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
