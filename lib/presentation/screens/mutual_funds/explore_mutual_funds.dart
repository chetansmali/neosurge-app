import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../domain/entities/params/mutual_funds/get_explore_diy_data_params.dart';
import '../../cubits/mutual_funds/explore_fund/explore_diy_data_cubit.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import 'widgets/investment_idea_list.dart';

class ExploreMutualFunds extends StatelessWidget {
  const ExploreMutualFunds({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        const Gap(24),
        const _DIYCategoriesList(),
        const Gap(24),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Explore funds by categories',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.neutral[200],
              ),
            ),
          ),
        ),
        const SliverGap(16),
        const _DIYSubCategoriesList(),
        const SliverGap(24),
        const _PopularFundsList(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Here\'s some investment ideas for you',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.neutral[400]!,
              ),
            ),
          ),
        ),
        const Gap(16),
        const PopularInvestmentIdeaList(),
      ],
    );
  }
}

enum _DIYCategories {
  equity,
  hybrid,
  commodity,
  fixedIncome,
  global;

  @override
  String toString() {
    switch (this) {
      case _DIYCategories.equity:
        return 'Equity';
      case _DIYCategories.commodity:
        return 'Commodity';
      case _DIYCategories.hybrid:
        return 'Hybrid';
      case _DIYCategories.fixedIncome:
        return 'Fixed Income';
      case _DIYCategories.global:
        return 'Global';
    }
  }
}

class _DIYCategoriesList extends StatefulWidget {
  const _DIYCategoriesList();

  @override
  State<_DIYCategoriesList> createState() => _DIYCategoriesState();
}

class _DIYCategoriesState extends State<_DIYCategoriesList> {
  _DIYCategories selectedCategory = _DIYCategories.equity;

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
      child: Container(
        height: 48,
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.symmetric(
          vertical: 6,
        ),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              height: 100,
              decoration: BoxDecoration(
                color: selectedCategory == _DIYCategories.values[index]
                    ? Colors.black
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = _DIYCategories.values[index];
                  });

                  context.read<ExploreDIYDataCubit>().getExploreDIYData(
                        params: GetExploreDIYDataParams(
                          assetcategory: selectedCategory.toString(),
                        ),
                      );
                },
                child: Center(
                  child: Text(
                    _DIYCategories.values[index].toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: selectedCategory == _DIYCategories.values[index]
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DIYSubCategoriesList extends StatelessWidget {
  const _DIYSubCategoriesList();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 100,
          child: BlocBuilder<ExploreDIYDataCubit, ExploreDIYDataState>(
            builder: (context, state) {
              if (state is ExploreDIYDataLoading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }

              if (state is ExploreDIYDataLoaded) {
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.27,
                  ),
                  itemCount: state.exploreDIYDataResponse.categoryAndSubCategory
                      .assetSubCategories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 12,
                        bottom: 10,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Routes.fundsListBySubcategory,
                            arguments: FundsListBySubCategoryArgs(
                              category: state
                                  .exploreDIYDataResponse.currentAssetCategory,
                              subCategory: state
                                  .exploreDIYDataResponse
                                  .categoryAndSubCategory
                                  .assetSubCategories[index],
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: AppColors.primary[100]!,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              state
                                  .exploreDIYDataResponse
                                  .categoryAndSubCategory
                                  .assetSubCategories[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primary[500],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _PopularFundsList extends StatelessWidget {
  const _PopularFundsList();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<ExploreDIYDataCubit, ExploreDIYDataState>(
          builder: (context, state) {
            if (state is ExploreDIYDataLoaded &&
                state.exploreDIYDataResponse.popularMutualFunds.isNotEmpty) {
              return SizedBox(
                height: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular ${state.exploreDIYDataResponse.currentAssetCategory} Funds',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.neutral[400]!,
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: state
                            .exploreDIYDataResponse.popularMutualFunds.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.detailedFundView,
                                arguments: DetailedFundViewArgs(
                                  schemeCode: state.exploreDIYDataResponse
                                      .popularMutualFunds[index].schemeCode,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              margin: const EdgeInsets.only(
                                right: 20,
                              ),
                              width: 146,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.neutral[50]!,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (state.exploreDIYDataResponse
                                          .popularMutualFunds[index].imgUrl !=
                                      null)
                                    CachedNetworkImage(
                                      imageUrl: state.exploreDIYDataResponse
                                          .popularMutualFunds[index].imgUrl!,
                                      height: 50,
                                      width: 50,
                                    ),
                                  const Gap(12),
                                  Text(
                                    state.exploreDIYDataResponse
                                        .popularMutualFunds[index].schemeName,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.neutral[300],
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${state.exploreDIYDataResponse.popularMutualFunds[index].threeY} (3Y)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.neutral[900],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Gap(4),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(24),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
