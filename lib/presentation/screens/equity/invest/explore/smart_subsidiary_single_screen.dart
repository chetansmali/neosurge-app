import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../common/common.dart';
import '../../../../../data/models/equity/smart_filtering/subsidiaries_model.dart';
import '../../../../../domain/entities/enums.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/equity/smart_filter_subsidiaries/cubit/get_subsidiaries_cubit.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/widgets.dart';
import '../../component/stock_banner.dart';
import '../../component/subsidiaries_sort_bottomsheet.dart';

class SmartSubsidiarySingleScreen extends StatefulWidget {
  const SmartSubsidiarySingleScreen({
    super.key,
    required this.businessHouse,
    required this.businessHouseEnum,
  });
  final String businessHouse;
  final String businessHouseEnum;

  @override
  State<SmartSubsidiarySingleScreen> createState() =>
      _SmartSubsidiarySingleScreenState();
}

class _SmartSubsidiarySingleScreenState
    extends State<SmartSubsidiarySingleScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool isSearchOpen = false;
  EquityStockSortTypes result = EquityStockSortTypes.highLow;

  List<SubsidiaryModel> _filteredStocks = <SubsidiaryModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.businessHouse),
      ),
      body: BlocBuilder<GetSubsidiariesCubit, GetSubsidiariesState>(
        builder: (context, state) {
          if (state is GetSubsidiariesLoading) {
            return const Center(child: CustomLoader());
          }

          if (state is GetSubsidiariesFailure) {
            return Center(
                child: AppErrorWidget(
              error: state.errorMessage,
              errorType: state.errorType,
            ));
          }

          if (state is GetSubsidiariesSuccess) {
            if (_filteredStocks.isEmpty) {
              _filteredStocks = state.businessHouses;
            }

            return Column(
              children: [
                if (!isSearchOpen) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0)),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (_) {
                                return BlocProvider.value(
                                  value: context.read<GetSubsidiariesCubit>(),
                                  child: SubsidiariesSortStocks(
                                    businessHouse: widget.businessHouseEnum,
                                    equitySortType: result,
                                    selectedSort: (value) => result = value,
                                  ),
                                );
                              },
                            );
                          },
                          child: Assets.icons.filterIcon
                              .image(height: 24, width: 24),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() => isSearchOpen = !isSearchOpen);
                          },
                          child: Assets.icons.magnifierIcon
                              .image(height: 24, width: 24),
                        ),
                      ],
                    ),
                  ),
                  const Gap(16),
                ] else ...[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: _textEditingController,
                      autofocus: true,
                      cursorColor: Colors.blue[50],
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) {
                        setState(() => _filteredStocks = state.businessHouses
                            .where((element) =>
                                element.companyName
                                    ?.toLowerCase()
                                    .contains(value.toLowerCase()) ??
                                false)
                            .toList());
                      },
                      textAlign: TextAlign.justify,
                      focusNode: _searchFocusNode,
                      decoration: InputDecoration(
                        suffixIcon: isSearchOpen
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _textEditingController.clear();
                                    _filteredStocks = state.businessHouses;
                                    isSearchOpen = !isSearchOpen;
                                  });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 30,
                                  color: AppColors.primaryColor,
                                ),
                              )
                            : const Icon(
                                Icons.search,
                                size: 30,
                                color: AppColors.primaryColor,
                              ),
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: baseTextStyle2.copyWith(
                            color: AppColors.textLightGrey, fontSize: 14),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: AppColors.primaryLightColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _filteredStocks.isEmpty
                            ? const Center(child: Text('No stocks found'))
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _filteredStocks.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 16.0, left: 20.0, right: 20.0),
                                  child: StockBanner(
                                    industry:
                                        _filteredStocks[index].industry ?? '',
                                    symbol: _filteredStocks[index].symbol ?? '',
                                    name: _filteredStocks[index].companyName ??
                                        '',
                                    close: _filteredStocks[index].close ?? 0,
                                    change: _filteredStocks[index].change ?? 0,
                                    percentage:
                                        _filteredStocks[index].percentChange ??
                                            0,
                                    icon: _filteredStocks[index].icon ?? '',
                                  ),
                                ),
                              ),
                      ],
                    ),
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
}
