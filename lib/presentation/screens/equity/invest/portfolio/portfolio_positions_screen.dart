import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../component/equity_sort_stocks.dart';
import 'etf/widgets/etf_positions_tile.dart';
import '../../../../../domain/entities/enums.dart';
import '../../../../theme/app_colors.dart';
import '../../../../../common/custom_styles.dart';
import '../../../../../data/models/equity/equity_portfolio/portfolio_positions.dart';
import '../../../../../gen/assets.gen.dart';

class PositionScreen extends StatefulWidget {
  final PortfolioPositionModel portfolioPositionModel;

  const PositionScreen({super.key, required this.portfolioPositionModel});

  @override
  State<PositionScreen> createState() => _PositionScreenState();
}

class _PositionScreenState extends State<PositionScreen> {
  var result = EquityStockSortTypes.ase;
  late List<Position> displayedPersons;
  bool isSearchOpen = false;
  late String selectedSort = '';
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedPersons = List.from(widget.portfolioPositionModel.positions);
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        setState(() {
          isSearchOpen = false;
        });
      }
    });
  }

  void _sortList(bool ascending, String field) {
    setState(() {
      if (field == 'name') {
        displayedPersons.sort((a, b) {
          if (ascending) {
            return a.tradingSymbol.compareTo(b.tradingSymbol);
          } else {
            return b.tradingSymbol.compareTo(a.tradingSymbol);
          }
        });
      } else if (field == 'price') {
        displayedPersons.sort((a, b) {
          if (ascending) {
            return a.averagePrice.compareTo(b.averagePrice);
          } else {
            return b.averagePrice.compareTo(a.averagePrice);
          }
        });
      }
    });
  }

  void _searchList(String query) {
    setState(() {
      displayedPersons = widget.portfolioPositionModel.positions
          .where((person) =>
              person.tradingSymbol.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(28),
            if (!isSearchOpen) ...[
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      result = await showModalBottomSheet(
                        isDismissible: false,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.0),
                                topRight: Radius.circular(32.0))),
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return SortStocks(
                            equitySortType: result,
                          );
                        },
                      );
                      if (result == EquityStockSortTypes.ase) {
                        setState(() {
                          selectedSort = 'A-Z';
                        });
                        _sortList(true, 'name');
                      } else if (result == EquityStockSortTypes.dse) {
                        setState(() {
                          selectedSort = 'Z-A';
                        });
                        _sortList(false, 'name');
                      } else if (result == EquityStockSortTypes.lowHigh) {
                        setState(() {
                          selectedSort = 'price:Low-High';
                        });
                        _sortList(true, 'avgPrice');
                      } else if (result == EquityStockSortTypes.highLow) {
                        setState(() {
                          selectedSort = 'price:High-Low';
                        });
                        _sortList(false, 'avgPrice');
                      }
                    },
                    child: Assets.pngs.equitySort.image(height: 24, width: 24),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSearchOpen = !isSearchOpen;
                      });
                    },
                    child:
                        Assets.icons.magnifierIcon.image(height: 24, width: 24),
                  ),
                ],
              )
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
                    _searchList(_textEditingController.text.toUpperCase());
                  },
                  textAlign: TextAlign.justify,
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    suffixIcon: isSearchOpen
                        ? IconButton(
                            onPressed: () {
                              _searchList(
                                  _textEditingController.text.toUpperCase());
                              setState(() {
                                _textEditingController.clear();
                                isSearchOpen = false;
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
              ),
            ],
            const Gap(10),
            widget.portfolioPositionModel.positions.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: displayedPersons.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 6.0, bottom: 12.0),
                          child: ETFPositionsTile(
                            icon: displayedPersons[index].icon ?? '--',
                            title: displayedPersons[index].tradingSymbol,
                            subtitle:
                                displayedPersons[index].companyName ?? '--',
                            type:
                                displayedPersons[index].transactionType ?? '--',
                            price: displayedPersons[index].averagePrice,
                            qty: displayedPersons[index].quantity,
                          ));
                    },
                  )
                : Column(
                    children: [
                      Assets.pngs.equityHoldings.image(height: 200, width: 200),
                      const Gap(5),
                      Text(
                        'No positions',
                        style: baseTextStyle16500,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
