import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:scgateway_flutter_plugin/scgateway_flutter_plugin.dart';
import '../../../../../common/common.dart';
import '../../../../../domain/entities/params/equity/equity_portfolio/get_holdings_token_params.dart';
import '../../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../../cubits/equity/equity_portfolio/portfolio_holdings_token_cubit.dart';
import '../../component/equity_sort_stocks.dart';
import '../explore/explore_dialog_box.dart';
import 'etf/widgets/etf_holding_tile.dart';
import '../../../../theme/app_colors.dart';

import '../../../../../data/models/equity/equity_portfolio/portfolio_holdings.dart';
import '../../../../../domain/entities/enums.dart';
import '../../../../../gen/assets.gen.dart';

class HoldingsScreen extends StatefulWidget {
  final PortfolioHoldingsModel portfolioHoldingsModel;

  const HoldingsScreen({super.key, required this.portfolioHoldingsModel});

  @override
  State<HoldingsScreen> createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {
  var result = EquityStockSortTypes.ase;
  late List<Holding> displayedPersons;
  bool isSearchOpen = false;
  late String selectedSort = '';
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedPersons = List.from(widget.portfolioHoldingsModel.holdings ?? []);
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
            return a.holdingKey?.compareTo(b.holdingKey ?? '') ?? 0;
          } else {
            return b.holdingKey?.compareTo(a.holdingKey ?? '') ?? 0;
          }
        });
      } else if (field == 'avgPrice') {
        displayedPersons.sort((a, b) {
          if (ascending) {
            return a.avgPrice?.compareTo(b.avgPrice ?? 0.0) ?? 0;
          } else {
            return b.avgPrice?.compareTo(a.avgPrice ?? 0.0) ?? 0;
          }
        });
      }
    });
  }

  void _searchList(String query) {
    setState(() {
      displayedPersons = widget.portfolioHoldingsModel.holdings
              ?.where(
                (person) => (person.holdingKey ?? '')
                    .toLowerCase()
                    .contains(query.toLowerCase()),
              )
              .toList() ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            const Gap(18),
            BlocListener<PortfolioHoldingsTokenCubit,
                PortfolioHoldingsTokenState>(
              listener: (context, state) {
                if (state is PortfolioHoldingsTokenFailure) {
                  Utils.showErrorAlert(context, 'Could not refresh holdings');
                }

                if (state is PortfolioHoldingsTokenLoaded) {
                  _triggerSDK(state.getFundsModel.transactionId);
                }
              },
              child: GestureDetector(
                onTap: () {
                  if (context
                          .read<AuthCubit>()
                          .state
                          .user
                          ?.smallcaseAuthToken !=
                      null) {
                    context
                        .read<PortfolioHoldingsTokenCubit>()
                        .fetchHoldingsToken(EquityHoldingsTokenParams(
                          smallcaseAuthToken: context
                                  .read<AuthCubit>()
                                  .state
                                  .user
                                  ?.smallcaseAuthToken ??
                              '',
                        ));
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ShowDialog();
                      },
                    );
                  }
                },
                child: Row(
                  children: [
                    Text(
                      'Refresh holdings',
                      style: baseTextStyle14400.copyWith(
                          color: AppColors.neutral[300]),
                    ),
                    const Gap(4),
                    Assets.svgs.equityPortfolioRefresh.svg(height: 24),
                  ],
                ),
              ),
            ),
            const Gap(12.0),
            widget.portfolioHoldingsModel.holdings?.isNotEmpty ?? false
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: displayedPersons.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 6.0, right: 6.0, bottom: 12.0),
                        child: ETFHoldingTile(
                          image: displayedPersons[index].icon ?? '',
                          symbol: displayedPersons[index].holdingKey ?? '',
                          subtitle: displayedPersons[index].companyName ?? '',
                          price: displayedPersons[index].avgPrice ?? 0.0,
                          qty: displayedPersons[index].quantity ?? 0,
                          ltp: displayedPersons[index].returns ?? 0.0,
                          ltppercentage:
                              displayedPersons[index].percentageReturns ?? 0.0,
                          invested:
                              displayedPersons[index].investedValue ?? 0.0,
                          avgPrice: displayedPersons[index].avgPrice ?? 0.0,
                          dayHighPrice:
                              displayedPersons[index].lastTradedPrice ?? 0.0,
                          dayHighPercent: displayedPersons[index]
                                  .lastTradedPricePercentageChange ??
                              0.0,
                        ),
                      );
                    },
                  )
                : Column(
                    children: [
                      Assets.pngs.equityHoldings.image(height: 200, width: 200),
                      const Gap(5),
                      Text(
                        'No holdings',
                        style: baseTextStyle16500,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _triggerSDK(String transactionId) async {
    await ScgatewayFlutterPlugin.setConfigEnvironment(
      GatewayEnvironment.PRODUCTION,
      'bullsurge',
      false,
      [
        context.read<AuthCubit>().state.user!.equityBroker ?? '',
      ],
      isAmoenabled: true,
    );
    String? scToken;
    if (mounted) {
      scToken = context.read<AuthCubit>().state.user!.smallcaseAuthToken;
    }

    await ScgatewayFlutterPlugin.initGateway(scToken ?? '');

    final result = await ScgatewayFlutterPlugin.triggerGatewayTransaction(
      transactionId,
    );

    Map<String, dynamic> jsonData = jsonDecode(result!);
    if (jsonData.containsKey('errorMessage') &&
        jsonData['errorMessage'] != null) {
      String errorMessage = jsonData['errorMessage'];
      if (!mounted) return;
      Utils.showWarningAlert(context, errorMessage);
      Navigator.pop(context);
    } else {
      if (mounted) {
        Utils.showSuccessAlert(context, 'Holdings refreshed');
        Navigator.pop(context);
      }
    }
  }
}
