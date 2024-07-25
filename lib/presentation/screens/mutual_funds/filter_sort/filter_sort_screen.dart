import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../constants/filter_sort_values.dart';
import '../../../cubits/mutual_funds/filter_sort/filter_sort_cubit.dart';
import '../../../theme/app_colors.dart';
import 'filter_sort_controller.dart';

class FilterSortScreen extends StatefulWidget {
  const FilterSortScreen({Key? key}) : super(key: key);

  @override
  State<FilterSortScreen> createState() => _FilterSortScreenState();
}

class _FilterSortScreenState extends State<FilterSortScreen> {
  @override
  Widget build(BuildContext context) {
    var fsController = Provider.of<FilterSortController>(context);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter-Sort'),
        actions: [
          TextButton(
              onPressed: () {
                fsController.resetFilter();
              },
              child: const Text('Clear All')),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => context.read<FilterSortController>().setSelectedFilterIndex(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(border: Border.all(color: AppColors.borderColorGrey, width: 0.5)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  FilterSortValues.filters[index],
                                  style: TextStyle(
                                      color: fsController.selectedFilterIndex == index
                                          ? AppColors.primaryColor
                                          : isDarkMode
                                              ? Colors.white
                                              : AppColors.mainBlack,
                                      fontSize: 12),
                                ),
                              ),
                              if (fsController.getAppliedFilterValueCount(index) > 0)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(4)),
                                )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: FilterSortValues.filters.length,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => fsController.handleOnTap(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(border: Border.all(color: AppColors.borderColorGrey, width: 0.5)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check,
                                size: 10,
                                color: fsController.isFilterSelected(index) ? AppColors.primaryColor : AppColors.mainBlack,
                              ),
                              const Gap(10),
                              Expanded(
                                child: fsController.selectedFilterIndex == 3
                                    ? RatingBarIndicator(
                                        itemBuilder: (context, index) {
                                          return const Icon(
                                            Icons.star,
                                            color: AppColors.ratingColor,
                                          );
                                        },
                                        itemCount: 5,
                                        itemSize: 20,
                                        rating: double.parse(fsController.getSelectedFilterValue[index]),
                                      )
                                    : Text(
                                        fsController.getSelectedFilterValue[index],
                                        style: TextStyle(fontSize: 12, color: fsController.isFilterSelected(index) ? AppColors.primaryColor : AppColors.mainBlack),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: fsController.getSelectedFilterValue.length,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                blurStyle: BlurStyle.outer,
                offset: const Offset(0, 4),
              ),
            ]),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const Gap(30),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<FilterSortCubit>().applyFilter(
                          appliedAmc: fsController.appliedAmc,
                          appliedAssetCategories: fsController.appliedAssetCategories,
                          appliedAssetSubCategories: fsController.appliedAssetSubCategories,
                          selectedRating: fsController.appliedRating,
                          selectedRisks: fsController.appliedRisks);

                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
