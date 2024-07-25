import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../data/models/equity/smart_filtering/smart_filter_indices_details.dart';
import '../../../../di/get_it.dart';
import '../../../../domain/entities/params/equity/equity_smart_watchlist/fetch_indices_params.dart';
import '../../../cubits/equity/equity_smart_filtering/cubit/fetch_smart_indices_cubit.dart';
import '../../../cubits/equity/equity_smart_filtering/cubit/filter_by_index_cubit.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/amount_widget.dart';
import '../../../widgets/widgets.dart';
import '../invest/explore/smart_index_single_screen.dart';

class SmartIndex extends StatefulWidget {
  const SmartIndex({super.key});

  @override
  State<SmartIndex> createState() => _SmartIndexState();
}

class _SmartIndexState extends State<SmartIndex> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Index'),
      ),
      bottomNavigationBar: SafeArea(
          child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.allIndexScreen);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'View all',
              style: baseTextStyle14400.copyWith(color: AppColors.neutral[400]),
            ),
            Icon(Icons.keyboard_arrow_right_rounded,
                color: AppColors.neutral[200])
          ],
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocBuilder<FetchSmartIndicesCubit, FetchSmartIndicesState>(
          builder: (context, state) {
            if (state is FetchSmartIndicesLoading ||
                state is FetchSmartIndicesInitial) {
              return const Center(child: CustomLoader());
            }

            if (state is FetchSmartIndicesFailure) {
              return Center(
                  child: AppErrorWidget(
                      errorType: state.errorType, error: state.errorMessage));
            }

            if (state is FetchSmartIndicesSuccess) {
              return Column(
                children: [
                  Row(
                    children: [
                      for (final String category in state
                          .smartFilterIndicesDetails.availableCategories)
                        GestureDetector(
                          onTap: () {
                            context
                                .read<FetchSmartIndicesCubit>()
                                .getSmartIndices(FetchIndicesParams(
                                  page: '',
                                  size: '',
                                  sort: '',
                                  category: category,
                                  searchString: '',
                                ));
                            setState(() => _selectedCategory = category);
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: _selectedCategory == category
                                      ? AppColors.primary[500]!
                                      : const Color(0xFF727579),
                                ),
                                color: _selectedCategory == category
                                    ? AppColors.primary[50]
                                    : null,
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 6.0),
                            margin: const EdgeInsets.only(right: 12.0),
                            child: Center(
                                child: Text(
                              category,
                              style: baseTextStyle12400.copyWith(
                                  color: _selectedCategory == category
                                      ? AppColors.primary[500]
                                      : const Color(0xFF727579)),
                            )),
                          ),
                        ),
                    ],
                  ),
                  const Gap(24),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 4,
                        mainAxisSpacing: 6.0,
                        crossAxisSpacing: 6.0,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: [
                          const QuiltedGridTile(1, 2),
                          const QuiltedGridTile(2, 1),
                          const QuiltedGridTile(2, 1),
                          const QuiltedGridTile(1, 2),
                        ],
                      ),
                      itemCount: state.smartFilterIndicesDetails.indices.length,
                      itemBuilder: (context, index) {
                        final IndexDetails item =
                            state.smartFilterIndicesDetails.indices[index];

                        return InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      getIt<FilterByIndexCubit>()
                                        ..filterByIndex(
                                          index: item.symbol,
                                          page: 0,
                                          size: 20,
                                          sort: 'marketCapitalization,DESC',
                                        ),
                                  child: SmartIndexSingleDetailScreen(
                                      index: item.symbol),
                                ),
                              )),
                          borderRadius: BorderRadius.circular(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                  color: item.oneDayChange.isNegative
                                      ? AppColors.error[500]!
                                      : AppColors.success[500]!),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: item.oneDayChange.isNegative
                                      ? [
                                          Colors.white,
                                          AppColors.error[50]!,
                                        ]
                                      : [
                                          Colors.white,
                                          AppColors.success[50]!,
                                        ]),
                            ),
                            padding: const EdgeInsets.all(6.0),
                            child: (index % 8 == 1 ||
                                    index % 8 == 2 ||
                                    index % 8 == 4 ||
                                    index % 8 == 5)
                                ? _ColumnTile(item: item)
                                : _RowTile(item: item),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _ColumnTile extends StatelessWidget {
  const _ColumnTile({required this.item});

  final IndexDetails item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: baseTextStyle14500.copyWith(color: AppColors.neutral[500]),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AmountWidget(
              amount: item.close,
              style: baseTextStyle14400.copyWith(color: AppColors.neutral[300]),
            ),
            const Gap(4.0),
            Text(
              '${item.oneDayChange.isNegative ? '' : '+'}'
              '${item.oneDayChange.toStringAsFixed(2)} '
              '(${item.oneDayPercentChange.isNegative ? '' : '+'}'
              '${item.oneDayPercentChange.toStringAsFixed(2)}%)',
              style: baseTextStyle12500.copyWith(
                  color: item.oneDayChange.isNegative
                      ? AppColors.error[500]
                      : AppColors.success[500]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}

class _RowTile extends StatelessWidget {
  const _RowTile({required this.item});

  final IndexDetails item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                item.name,
                style:
                    baseTextStyle14500.copyWith(color: AppColors.neutral[500]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Gap(8.0),
            Text(
              '${item.oneDayChange.isNegative ? '' : '+'}'
              '${item.oneDayChange.toStringAsFixed(2)}',
              style: baseTextStyle12500.copyWith(
                  color: item.oneDayChange.isNegative
                      ? AppColors.error[500]
                      : AppColors.success[500]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        const Gap(4.0),
        Row(
          children: [
            Expanded(
              child: AmountWidget(
                amount: item.close,
                style:
                    baseTextStyle14400.copyWith(color: AppColors.neutral[300]),
              ),
            ),
            Text(
              '(${item.oneDayPercentChange.isNegative ? '' : '+'}'
              '${item.oneDayPercentChange.toStringAsFixed(2)}%)',
              style: baseTextStyle12500.copyWith(
                  color: item.oneDayChange.isNegative
                      ? AppColors.error[500]
                      : AppColors.success[500]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
