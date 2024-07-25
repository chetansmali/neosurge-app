// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../cubits/contact_us/category_questions/category_questions_cubit.dart';
import '../../../data/models/contact_us/contact_us_categories_response.dart';
import '../../../domain/entities/params/contact_us/get_category_questions_params.dart';
import '../../cubits/contact_us/contact_us_cubit/contact_us_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/custom_shimmer.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/app_colors.dart';
import 'widgets/similar_question_tile.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  late final TextEditingController _searchController;
  bool inputtext = false;

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
    return BlocBuilder<ContactUsCubit, ContactUsState>(
      builder: (context, state) {
        if (state is ContactUsLoading) {
          return const Scaffold(
            body: Center(
              child: CustomLoader(),
            ),
          );
        }
        if (state is ContactUsLoadError) {
          return Scaffold(
            body: Center(
              child: AppErrorWidget(
                errorType: state.errorType,
                error: state.errorMessage,
              ),
            ),
          );
        }
        if (state is ContactUsLoaded) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  height: 205,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.primary[50],
                  ),
                ),
                SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    // appBar:
                    body: ListView(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        AppBar(
                          scrolledUnderElevation: 0,
                          elevation: 0,
                          centerTitle: true,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "How can we help you?",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Do not worry, we got your back",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.neutral[400],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          toolbarHeight: 105,
                        ),
                        !inputtext
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: TextField(
                                  onTap: () {
                                    setState(() {
                                      inputtext = true;
                                    });
                                  },
                                  readOnly: true,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Search for categories, keywords eg: KYC',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    prefixIcon: Assets.icons.magniferHome.svg(
                                      color: AppColors.primaryColor,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    fillColor: Colors.white,
                                    focusColor: AppColors.primary[500],
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: AppColors.primary[50] ??
                                            Colors.white,
                                      ),
                                    ),
                                    filled: true,
                                  ),
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                ),
                              )
                            : const SizedBox.shrink(),
                        const Gap(20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'You might be looking for',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Gap(10),
                        BlocBuilder<CategoryQuestionsCubit,
                            CategoryQuestionsState>(
                          builder: (context, state) {
                            if (state is CategoryQuestionsLoading) {
                              return const Center(
                                child: CustomLoader(),
                              );
                            }
                            if (state is CategoryQuestionsLoadError) {
                              return Column(
                                children: [
                                  SimiliarQuestionTile(
                                    title:
                                        "Can I sell the pledged Mutual Funds?",
                                    onTap: () {},
                                  ),
                                  SimiliarQuestionTile(
                                    title:
                                        "How is LAMF different from personal loans?",
                                    onTap: () {},
                                  ),
                                ],
                              );
                            }
                            if (state is CategoryQuestionsLoaded) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    state.contactusQuestionsList.length > 2
                                        ? 2
                                        : 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return SimiliarQuestionTile(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.categoryQuestionsDetail,
                                        arguments: CategoryQuestionsDetailArgs(
                                          title: state
                                              .contactusQuestionsList[index]
                                              .category,
                                          articletitle: state
                                              .contactusQuestionsList[index]
                                              .question,
                                          articleid: state
                                              .contactusQuestionsList[index].id,
                                          query: state
                                              .contactusQuestionsList[index]
                                              .question,
                                        ),
                                      );
                                    },
                                    title: state
                                        .contactusQuestionsList[index].question,
                                  );
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        const Gap(20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Gap(20),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height / 3.6),
                          child: _categoriesGrid(state.categoriesList),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Assets.icons.emailIcon.image(
                                  height: 18,
                                  width: 18,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.contactUsForm);
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Didn\'t find a solution? ',
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
                        )
                      ],
                    ),
                  ),
                ),
                inputtext
                    ? _searchSuggestions(context)
                    : const SizedBox.shrink(),
              ],
            ),
          );
        }
        return const Scaffold(body: SizedBox.shrink());
      },
    );
  }

  Widget _searchBar(BuildContext context, {double toppadding = 170.0}) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: toppadding),
      child: TextFormField(
        controller: _searchController,
        onChanged: (value) {
          context.read<CategoryQuestionsCubit>().fetchQuestions(
                GetCategoryQuestionsParams(
                  query: _searchController.text,
                ),
              );
        },
        onTap: () {
          setState(() {
            inputtext = true;
          });
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search for categories, keywords eg: KYC',
          hintStyle: const TextStyle(fontSize: 13),
          suffixIcon: inputtext
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      inputtext = false;
                    });
                  },
                  child: const Icon(
                    Icons.close,
                  ),
                )
              : const SizedBox.shrink(),
          prefixIcon: Assets.icons.magniferHome.svg(
            color: AppColors.primaryColor,
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
    );
  }

  Widget _categoriesGrid(
      List<ContactUsCategoriesModel> contactuscategoriesmodel) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // crossAxisSpacing: 8.0,
        // mainAxisSpacing: 8.0,
        childAspectRatio: 0.9,
      ),
      itemCount: contactuscategoriesmodel.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 2,
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.categoryQuestions,
                arguments: CategoryQuestionsArgs(
                  title: contactuscategoriesmodel[index].displayName,
                  category: contactuscategoriesmodel[index].enumName,
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                contactuscategoriesmodel[index].icon == ""
                    ? Assets.pngs.categoriesCards.image(height: 40, width: 30)
                    : CachedNetworkImage(
                        imageUrl: contactuscategoriesmodel[index].icon,
                        width: 30,
                        height: 30,
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) => CustomShimmer(
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 8),
                Text(
                  contactuscategoriesmodel[index].displayName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _searchSuggestions(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: const Color.fromRGBO(44, 49, 55, 0.5),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              _searchBar(context),
              BlocBuilder<CategoryQuestionsCubit, CategoryQuestionsState>(
                builder: (context, state) {
                  if (state is CategoryQuestionsLoading &&
                      _searchController.text.isNotEmpty) {
                    return const Center(
                      child: CustomLoader(),
                    );
                  }
                  if (state is CategoryQuestionsLoadError &&
                      _searchController.text.isNotEmpty) {
                    return Center(
                      child: AppErrorWidget(
                        errorType: state.errorType,
                        error: state.errorMessage,
                      ),
                    );
                  }
                  if (state is CategoryQuestionsLoaded &&
                      _searchController.text.isNotEmpty) {
                    return state.contactusQuestionsList.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 10.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "No results fetched for your query",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.contactUsForm);
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.only(left: 17, right: 17),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.contactusQuestionsList.length > 3
                                  ? 3
                                  : state.contactusQuestionsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppColors.neutral[50] ??
                                            Colors.grey.shade100,
                                      ),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.categoryQuestionsDetail,
                                        arguments: CategoryQuestionsDetailArgs(
                                          title: state
                                              .contactusQuestionsList[index]
                                              .category,
                                          articletitle: state
                                              .contactusQuestionsList[index]
                                              .question,
                                          articleid: state
                                              .contactusQuestionsList[index].id,
                                          query: state
                                              .contactusQuestionsList[index]
                                              .question,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      state.contactusQuestionsList[index]
                                          .question,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
