import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../data/models/equity/smart_filtering/smart_filter_indices_details.dart';
import '../../../../di/get_it.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cubits/equity/equity_smart_filtering/cubit/fetch_smart_indices_cubit.dart';
import '../../../cubits/equity/equity_smart_filtering/cubit/filter_by_index_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/widgets.dart';
import '../invest/explore/smart_index_single_screen.dart';

class AllIndexScreen extends StatefulWidget {
  const AllIndexScreen({super.key});

  @override
  State<AllIndexScreen> createState() => _AllIndexScreenState();
}

class _AllIndexScreenState extends State<AllIndexScreen> {
  List<IndexDetails> _allTiles = [];
  List<IndexDetails> _filteredTiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Index')),
      body: BlocBuilder<FetchSmartIndicesCubit, FetchSmartIndicesState>(
        builder: (context, state) {
          if (state is FetchSmartIndicesInitial ||
              state is FetchSmartIndicesLoading) {
            return const Center(child: CustomLoader());
          }

          if (state is FetchSmartIndicesFailure) {
            return Center(
                child: AppErrorWidget(
                    errorType: state.errorType, error: state.errorMessage));
          }

          if (state is FetchSmartIndicesSuccess) {
            if (_allTiles.isEmpty) {
              _allTiles = state.smartFilterIndicesDetails.indices;
              _filteredTiles = _allTiles;
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (val) => setState(() => _filteredTiles =
                        _allTiles
                            .where((tile) => tile.name
                                .toLowerCase()
                                .contains(val.toLowerCase()))
                            .toList()),
                    decoration: InputDecoration(
                      label: Row(
                        children: [
                          Assets.icons.magnifierIcon.image(
                            height: 20,
                            width: 20,
                          ),
                          const Gap(16),
                          Text(
                            'Search for Sector',
                            style: baseTextStyle12400.copyWith(
                                color: AppColors.neutral[400]),
                          ),
                        ],
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      fillColor: const Color(0xFFF4F4F4),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: baseTextStyle2.copyWith(
                          color: AppColors.textLightGrey, fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const Gap(32),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredTiles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      getIt<FilterByIndexCubit>()
                                        ..filterByIndex(
                                          index: _filteredTiles[index].symbol,
                                          page: 0,
                                          size: 20,
                                          sort: 'marketCapitalization,DESC',
                                        ),
                                  child: SmartIndexSingleDetailScreen(
                                      index: _filteredTiles[index].symbol),
                                ),
                              )),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColors.neutral[50]!)),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16.0),
                                  child: Text(
                                    _filteredTiles[index].name,
                                    style: baseTextStyle14400.copyWith(
                                        color: const Color(0xFF727579)),
                                  ),
                                ),
                              ),
                              const Gap(32.0),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF2E8EFF),
                                size: 16,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(32),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
