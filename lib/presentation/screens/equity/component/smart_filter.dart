import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../common/common.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../data/models/equity/smart_filtering/get_sector_industries_details.dart';
import '../../../cubits/equity/equity_explore/all_stocks_cubit.dart';
import '../../../cubits/equity/equity_smart_filtering/cubit/get_sectors_and_industries_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';
import '../../credit/widgets/custom_checkbox.dart';

class EquitySmartFilterScreen extends StatefulWidget {
  const EquitySmartFilterScreen({
    super.key,
    this.selectedFundHouses,
    required this.selectedSectors,
    this.selectedSort,
  });
  final List<String>? selectedFundHouses;
  final Function(List<String>?) selectedSectors;
  final String? selectedSort;

  @override
  State<EquitySmartFilterScreen> createState() =>
      _EquitySmartFilterScreenState();
}

class _EquitySmartFilterScreenState extends State<EquitySmartFilterScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  final List<String> _selectedSectors = <String>[];
  List<String> _selectedIndustries = <String>[];
  String? _expandedSector;

  final List<String> _allIndustries = <String>[];
  List<String> _filteredIndustries = <String>[];

  @override
  void initState() {
    super.initState();
    _selectedIndustries = widget.selectedFundHouses != null
        ? widget.selectedFundHouses!
        : <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter')),
      body: BlocBuilder<GetSectorsAndIndustriesCubit,
          GetSectorsAndIndustriesState>(
        builder: (context, state) {
          if (state is GetSectorsAndIndustriesInitial ||
              state is GetSectorsAndIndustriesLoading) {
            return const Center(child: CustomLoader());
          }

          if (state is GetSectorsAndIndustriesFailure) {
            return AppErrorWidget(
              errorType: state.errorType,
              error: state.errorMessage,
            );
          }

          if (state is GetSectorsAndIndustriesSuccess) {
            if (_allIndustries.isEmpty) {
              for (final GetSectorIndustriesDetails sector
                  in state.getSectorIndustriesDetails) {
                _allIndustries.addAll(sector.industries);
              }
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
                                    child: GestureDetector(
                                      onTap: () => setState(
                                          () => _selectedIndustries.clear()),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.topRight,
                                        children: [
                                          Text(
                                            'Sector',
                                            style: baseTextStyle14400.copyWith(
                                                color: _selectedIndustries
                                                        .isNotEmpty
                                                    ? AppColors.primaryColor
                                                    : AppColors.neutral[600]),
                                          ),
                                          _selectedIndustries.isNotEmpty
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
                                    focusNode: _searchFocusNode,
                                    textInputAction: TextInputAction.search,
                                    onFieldSubmitted: (value) async {
                                      final String val = value.trim();
                                      _filteredIndustries = _allIndustries
                                          .where((element) => element
                                              .toLowerCase()
                                              .contains(val.toLowerCase()))
                                          .toList();
                                      setState(() {});
                                    },
                                    textAlign: TextAlign.justify,
                                    onTapOutside: (onTapOutside) =>
                                        _searchFocusNode.unfocus(),
                                    decoration: InputDecoration(
                                      suffixIcon: _filteredIndustries.isNotEmpty
                                          ? IconButton(
                                              onPressed: () {
                                                _textEditingController.clear();
                                                _searchFocusNode.unfocus();
                                                setState(() =>
                                                    _filteredIndustries
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
                                            'Search for Sector',
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
                                      if (_filteredIndustries.isEmpty)
                                        for (final GetSectorIndustriesDetails sectors
                                            in state.getSectorIndustriesDetails)
                                          Builder(
                                            builder: (context) {
                                              final bool isSectorSelected =
                                                  _selectedSectors
                                                      .contains(sectors.sector);
                                              final bool isExpanded =
                                                  _expandedSector ==
                                                      sectors.sector;

                                              return Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: AppColors
                                                                    .neutral[
                                                                50]!))),
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomCheckBox(
                                                              onChanged: (val) {
                                                                if (_selectedSectors
                                                                    .isNotEmpty) {
                                                                  if (!isSectorSelected) {
                                                                    setState(
                                                                        () {
                                                                      _selectedSectors.add(
                                                                          sectors
                                                                              .sector);
                                                                      _selectedIndustries
                                                                          .addAll(
                                                                              sectors.industries);
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      _selectedSectors
                                                                          .remove(
                                                                              sectors.sector);
                                                                      _selectedIndustries.removeWhere((element) => sectors
                                                                          .industries
                                                                          .contains(
                                                                              element));
                                                                    });
                                                                  }
                                                                } else {
                                                                  setState(() {
                                                                    _selectedSectors
                                                                        .add(sectors
                                                                            .sector);
                                                                    _selectedIndustries
                                                                        .addAll(
                                                                            sectors.industries);
                                                                  });
                                                                }
                                                              },
                                                              value:
                                                                  isSectorSelected),
                                                          const Gap(4.0),
                                                          Expanded(
                                                            child: Tooltip(
                                                              message: sectors
                                                                  .sector,
                                                              child: Text(
                                                                sectors.sector,
                                                                style: baseTextStyle14400.copyWith(
                                                                    color: isSectorSelected
                                                                        ? AppColors
                                                                            .primaryColor
                                                                        : AppColors
                                                                            .neutral[300]),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                          const Gap(4.0),
                                                          IconButton(
                                                            visualDensity:
                                                                VisualDensity
                                                                    .compact,
                                                            onPressed: () {
                                                              if (isExpanded) {
                                                                setState(() =>
                                                                    _expandedSector =
                                                                        null);
                                                              } else {
                                                                setState(() =>
                                                                    _expandedSector =
                                                                        sectors
                                                                            .sector);
                                                              }
                                                            },
                                                            icon: RotatedBox(
                                                              quarterTurns:
                                                                  isExpanded
                                                                      ? 2
                                                                      : 0,
                                                              child: Icon(
                                                                Icons
                                                                    .keyboard_arrow_down,
                                                                color: isSectorSelected
                                                                    ? AppColors
                                                                        .primaryColor
                                                                    : AppColors
                                                                            .neutral[
                                                                        300],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      if (isExpanded)
                                                        for (final String industry
                                                            in sectors
                                                                .industries)
                                                          Builder(builder:
                                                              (context) {
                                                            final bool
                                                                isSelected =
                                                                _selectedIndustries
                                                                    .contains(
                                                                        industry);

                                                            return InkWell(
                                                              onTap: () {
                                                                if (_selectedIndustries
                                                                    .contains(
                                                                        industry)) {
                                                                  setState(() =>
                                                                      _selectedIndustries
                                                                          .remove(
                                                                              industry));
                                                                } else {
                                                                  setState(() =>
                                                                      _selectedIndustries
                                                                          .add(
                                                                              industry));
                                                                }
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    bottom: BorderSide(
                                                                        color: AppColors
                                                                            .neutral[50]!),
                                                                  ),
                                                                ),
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20.0),
                                                                child: Row(
                                                                  children: [
                                                                    if (isSelected)
                                                                      Text(
                                                                        '•',
                                                                        style: baseTextStyle14600.copyWith(
                                                                            color:
                                                                                AppColors.primaryColor),
                                                                      ),
                                                                    const Gap(
                                                                        4.0),
                                                                    Expanded(
                                                                      child:
                                                                          Tooltip(
                                                                        message:
                                                                            industry,
                                                                        child:
                                                                            Text(
                                                                          industry,
                                                                          style:
                                                                              baseTextStyle14400.copyWith(color: isSelected ? AppColors.primaryColor : AppColors.neutral[300]),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                      else
                                        for (final String industry
                                            in _filteredIndustries)
                                          Builder(builder: (context) {
                                            print(_filteredIndustries.isEmpty);

                                            if (_filteredIndustries.isEmpty) {
                                              return const Center(
                                                  child:
                                                      Text('No matches found'));
                                            }

                                            final bool isSelected =
                                                _selectedIndustries
                                                    .contains(industry);

                                            return InkWell(
                                              onTap: () {
                                                if (_selectedIndustries
                                                    .contains(industry)) {
                                                  setState(() =>
                                                      _selectedIndustries
                                                          .remove(industry));
                                                } else {
                                                  setState(() =>
                                                      _selectedIndustries
                                                          .add(industry));
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        color: AppColors
                                                            .neutral[50]!),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                margin: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Row(
                                                  children: [
                                                    if (isSelected)
                                                      Text(
                                                        '•',
                                                        style: baseTextStyle14600
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primaryColor),
                                                      ),
                                                    const Gap(4.0),
                                                    Expanded(
                                                      child: Tooltip(
                                                        message: industry,
                                                        child: Text(
                                                          industry,
                                                          style: baseTextStyle14400.copyWith(
                                                              color: isSelected
                                                                  ? AppColors
                                                                      .primaryColor
                                                                  : AppColors
                                                                          .neutral[
                                                                      300]),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
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
                      widget.selectedSectors(_selectedIndustries);
                      await _handleFundFetch(sectors: _selectedIndustries);
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
    bool isFirstFetch = true,
    List<String>? sectors,
  }) async {
    String selectedSectors = '';
    if (sectors != null) {
      selectedSectors = sectors.join(',');
    }

    await context.read<AllStocksCubit>().fetchStocks(
          page: isFirstFetch ? 0 : null,
          direction: widget.selectedSort != null
              ? widget.selectedSort!.split(',')[1]
              : null,
          sortBy: widget.selectedSort != null
              ? widget.selectedSort!.split(',')[0]
              : null,
          sectors: selectedSectors,
          isInitialLoading: true,
        );
  }
}
