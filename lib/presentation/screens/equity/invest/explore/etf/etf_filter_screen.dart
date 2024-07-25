import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../common/common.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../cubits/equity/etf_fund_houses_cubit.dart';
import '../../../../../cubits/equity/etf_stocks_cubit.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../widgets/app_error_widget.dart';
import '../../../../../widgets/custom_loader.dart';

class ETFFilterScreen extends StatefulWidget {
  const ETFFilterScreen({
    super.key,
    this.selectedFundHouses,
    required this.selectedFilters,
    required this.selectedSort,
  });
  final List<String>? selectedFundHouses;
  final Function(List<String>) selectedFilters;
  final String selectedSort;

  @override
  State<ETFFilterScreen> createState() => _ETFFilterScreenState();
}

class _ETFFilterScreenState extends State<ETFFilterScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  final List<String> _allFundHouses = <String>[];
  List<String> _filteredFundHouses = <String>[];

  late List<String> _selectedFundHouses;

  @override
  void initState() {
    super.initState();
    _selectedFundHouses = widget.selectedFundHouses != null
        ? widget.selectedFundHouses!
        : <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter')),
      body: BlocBuilder<EtfFundHousesCubit, EtfFundHousesState>(
        builder: (context, state) {
          if (state is EtfFundHousesLoading) {
            return const Center(child: CustomLoader());
          }

          if (state is EtfFundHousesFailure) {
            return Center(
                child: AppErrorWidget(
              errorType: state.errorType,
              error: state.errorMessage,
              onRetry: context.read<EtfFundHousesCubit>().getFundHouses,
            ));
          }

          if (state is EtfFundHousesSuccess) {
            if (_allFundHouses.isEmpty) {
              _allFundHouses.addAll(state.etfFundHouses);
            }

            return Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(color: AppColors.neutral[50]!),
                            bottom: BorderSide(color: AppColors.neutral[50]!),
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColors.neutral[50]!))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'Filter by',
                                    style: baseTextStyle16500.copyWith(
                                        color: AppColors.neutral[900]),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColors.neutral[50]!))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.topRight,
                                      children: [
                                        Text(
                                          'Fund House',
                                          style: baseTextStyle14400.copyWith(
                                              color:
                                                  _selectedFundHouses.isNotEmpty
                                                      ? AppColors.primaryColor
                                                      : AppColors.neutral[600]),
                                        ),
                                        _selectedFundHouses.isNotEmpty
                                            ? Positioned(
                                                top: -14,
                                                right: -10,
                                                child: Text(
                                                  '•',
                                                  style: baseTextStyle21500
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryColor),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(color: AppColors.neutral[50]!),
                            left: BorderSide(color: AppColors.neutral[50]!),
                            bottom: BorderSide(color: AppColors.neutral[50]!),
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColors.neutral[50]!))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: TextFormField(
                                    controller: _textEditingController,
                                    textInputAction: TextInputAction.search,
                                    onFieldSubmitted: (value) => setState(() {
                                      _filteredFundHouses = _allFundHouses
                                          .where((element) => element
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                          .toList();
                                    }),
                                    textAlign: TextAlign.justify,
                                    focusNode: _searchFocusNode,
                                    onTapOutside: (onTapOutside) =>
                                        _searchFocusNode.unfocus(),
                                    decoration: InputDecoration(
                                      suffixIcon: _filteredFundHouses.isNotEmpty
                                          ? IconButton(
                                              onPressed: () {
                                                _textEditingController.clear();
                                                _searchFocusNode.unfocus();
                                                setState(() =>
                                                    _filteredFundHouses
                                                        .clear());
                                              },
                                              icon: const Icon(
                                                  Icons.cancel_rounded))
                                          : null,
                                      label: Row(
                                        children: [
                                          Assets.icons.magnifierIcon.image(
                                            height: 20,
                                            width: 20,
                                          ),
                                          const Gap(16),
                                          Text(
                                            'Search for Fund House',
                                            style: baseTextStyle12400.copyWith(
                                                color: AppColors.neutral[400]),
                                          ),
                                        ],
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16),
                                      fillColor: const Color(0xFFF4F4F4),
                                      filled: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelStyle: baseTextStyle2.copyWith(
                                          color: AppColors.textLightGrey,
                                          fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: BorderSide.none,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (String fundHouse
                                          in _filteredFundHouses.isEmpty
                                              ? _allFundHouses
                                              : _filteredFundHouses)
                                        InkWell(
                                          onTap: () {
                                            if (_selectedFundHouses
                                                .isNotEmpty) {
                                              if (!_selectedFundHouses
                                                  .contains(fundHouse)) {
                                                setState(() =>
                                                    _selectedFundHouses
                                                        .add(fundHouse));
                                              } else {
                                                setState(() =>
                                                    _selectedFundHouses
                                                        .remove(fundHouse));
                                              }
                                            } else {
                                              setState(() => _selectedFundHouses
                                                  .add(fundHouse));
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: AppColors
                                                            .neutral[50]!))),
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                fundHouse,
                                                style:
                                                    baseTextStyle14400.copyWith(
                                                        color: _selectedFundHouses
                                                                .contains(
                                                                    fundHouse)
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .neutral[300]),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      await _handleFundFetch(filters: _selectedFundHouses);
                      widget.selectedFilters(_selectedFundHouses);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Apply Changes'),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Future<void> _handleFundFetch({
    required List<String> filters,
  }) async {
    final String fundHouse = filters.join(',');

    await context.read<EtfStocksCubit>().fetchETFs(
          page: 0,
          filter: fundHouse,
          sort: widget.selectedSort,
        );
  }
}
