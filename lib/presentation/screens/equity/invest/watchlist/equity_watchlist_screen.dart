import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../component/smart_watch_button.dart';
import 'smart_watchlist/set_alert_bottom_sheet.dart';
import '../../../../cubits/equity/equity_smart_watchlist/set_alert_cubit.dart';
import '../../component/card_slide_menu.dart';
import 'smart_watchlist/delete_dialog_box.dart';
import '../../../../../domain/entities/params/equity/equity_smart_watchlist/get_users_alert_params.dart';
import '../../../../cubits/equity/equity_smart_watchlist/get_user_alerts_cubit.dart';
import '../../../../cubits/equity/equity_smart_watchlist/remove_alert_cubit.dart';
import '../../../../routes/routes.dart';
import 'smart_watchlist/smart_watchlist_card.dart';
import '../../../../../common/common.dart';
import '../../../../../domain/entities/params/equity/equity_nav_entity.dart';
import '../../../../../domain/entities/params/equity/equity_watchlist/get_watchlist_symbol.dart';
import '../../../../cubits/equity/equity_nav_cubit.dart';
import '../../../../cubits/equity/equity_watchlist/get_all_user_watchlis_cubit.dart';
import '../../../../cubits/equity/equity_watchlist/remove_symbol_watchlist_cubit.dart';
import '../../../../cubits/equity/equity_watchlist/remove_watchlist_cubit.dart';
import '../../../../theme/app_colors.dart';
import 'delete_watchlist_bttom_sheet.dart';
import 'watchlist_card.dart';
import '../../../../../di/get_it.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/equity/equity_watchlist/create_watchlist_cubit.dart';
import '../../../../cubits/equity/equity_watchlist/watchlist_symbol_cubit.dart';
import '../../../../widgets/app_error_widget.dart';
import 'watchlist_bottomsheet.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late int _isSelected;
  bool _isEditPress = false;
  bool _isDeleteAll = false;
  List<String> deleteAlert = [];
  String _fetchRes = '';

  @override
  void initState() {
    _isSelected = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Scaffold(
        body: Column(
          children: [
            const Gap(30),
            BlocConsumer<GetAllUserWatchlisCubit, GetAllUserWatchlisState>(
              listener: (context, state) {
                if (state is GetAllUserWatchlisLoaded) {
                  final watchlist = state.getAllWatchlist;
                  if (watchlist.isNotEmpty) {
                    _isSelected = 0;
                    context.read<WatchlistSymbolCubit>().fetchWatchlistSymbol(
                          GetWatchlistSymbolParams(
                            id: '${watchlist[0].id}/symbols',
                          ),
                        );
                  } else {
                    context.read<WatchlistSymbolCubit>().reset();
                  }
                }
              },
              builder: (context, wstate) {
                if (wstate is GetAllUserWatchlisLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (wstate is GetAllUserWatchlistFailure) {
                  return AppErrorWidget(
                    errorType: wstate.errorType,
                    error: wstate.errorMessage,
                    onRetry: () => context.read<GetAllUserWatchlisCubit>()
                      ..fetchAllWatchlist(),
                  );
                }
                if (wstate is GetAllUserWatchlisLoaded) {
                  final watchlist = wstate.getAllWatchlist;

                  return SizedBox(
                    height: 40.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: watchlist.length + 2,
                      itemBuilder: (BuildContext _, int index) {
                        if (index == 0) {
                          return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  context: context,
                                  builder: (_) {
                                    return MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) =>
                                              getIt<CreateWatchlistCubit>(),
                                        ),
                                        BlocProvider.value(
                                          value: context
                                              .read<GetAllUserWatchlisCubit>(),
                                        ),
                                      ],
                                      child: const MyBottomSheet(),
                                    );
                                  },
                                );
                              },
                              splashColor: Colors.transparent,
                              child: Row(
                                children: [
                                  Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppColors.primaryLightColor,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 30,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const Gap(10),
                                ],
                              ));
                        }
                        if (index == 1) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<GetUserAlertsCubit>()
                                    .fetchUserAlerts(
                                      GetUsersAlertParams(
                                          page: 0,
                                          size: 25,
                                          sort: 'symbol,desc'),
                                    );
                                setState(() {
                                  _colorChange(-1);
                                });
                              },
                              child: const SmartWatchlisButton(),
                            ),
                          );
                        }
                        final item = wstate.getAllWatchlist;
                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            _colorChange(index - 2);
                            context
                                .read<WatchlistSymbolCubit>()
                                .fetchWatchlistSymbol(
                                  GetWatchlistSymbolParams(
                                    id: '${wstate.getAllWatchlist[index - 2].id}/symbols',
                                  ),
                                );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _isSelected == index - 2
                                    ? AppColors.primaryColor
                                    : AppColors.borderColorGrey,
                              ),
                              color: _isSelected == index - 2
                                  ? AppColors.primaryLightColor
                                  : null,
                            ),
                            child: Center(
                                child: Text(
                              item[index - 2].name,
                              style: baseTextStyle14400,
                            )),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const Gap(10),
            _isSelected == -1
                ? Expanded(
                    child: Column(
                      children: [
                        BlocBuilder<GetUserAlertsCubit, GetUserAlertsState>(
                          builder: (context, state) {
                            if (state is GetUserAlertsLoading) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                            if (state is GetUserAlertsFailure) {
                              return AppErrorWidget(
                                errorType: state.errorType,
                                error: state.errorMessage,
                                onRetry: () => context
                                    .read<GetUserAlertsCubit>()
                                    .fetchUserAlerts(
                                      GetUsersAlertParams(
                                          page: 0,
                                          size: 25,
                                          sort: 'symbol,desc'),
                                    ),
                              );
                            }
                            if (state is GetUserAlertsLoaded) {
                              return state.getUserAlertModel.totalElements == 0
                                  ? Column(
                                      children: [
                                        const Gap(50),
                                        Assets.svgs.emptySmartWatchlist
                                            .svg(height: 200, width: 200),
                                        const Gap(35),
                                        Text(
                                          'No stock added to Smart Watchlist',
                                          style: baseTextStyle16500,
                                        ),
                                        const Gap(5),
                                        Text(
                                          'Set alerts and track stocks effectively',
                                          style: baseTextStyle12400,
                                        ),
                                        const Gap(30),
                                        SizedBox(
                                          height: 40,
                                          width: 170,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final reulst =
                                                  await Navigator.pushNamed(
                                                      context,
                                                      Routes
                                                          .equitySmartWatchlistHoldings);
                                              setState(() {
                                                _fetchRes = reulst as String;
                                              });

                                              if (_fetchRes == 'true') {
                                                if (context.mounted) {
                                                  context
                                                      .read<
                                                          GetUserAlertsCubit>()
                                                      .fetchUserAlerts(
                                                          GetUsersAlertParams(
                                                              page: 0,
                                                              size: 25,
                                                              sort: ''));
                                                }
                                              }
                                            },
                                            child: Text(
                                              'Add stocks',
                                              style: baseTextStyle14500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _isEditPress =
                                                        !_isEditPress;
                                                  });
                                                  if (_isDeleteAll == true) {
                                                    setState(() {
                                                      _isDeleteAll = false;
                                                    });
                                                  }
                                                },
                                                child: _isEditPress
                                                    ? Text(
                                                        'Done Edit',
                                                        style: baseTextStyle12500
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primaryColor),
                                                      )
                                                    : Text(
                                                        'Edit Watchlist',
                                                        style: baseTextStyle12500
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primaryColor),
                                                      ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  final reulst =
                                                      await Navigator.pushNamed(
                                                          context,
                                                          Routes
                                                              .equitySmartWatchlistHoldings);
                                                  setState(() {
                                                    _fetchRes =
                                                        reulst as String;
                                                  });

                                                  if (_fetchRes == 'true') {
                                                    context
                                                        .read<
                                                            GetUserAlertsCubit>()
                                                        .fetchUserAlerts(
                                                            GetUsersAlertParams(
                                                                page: 0,
                                                                size: 25,
                                                                sort: ''));
                                                  }
                                                },
                                                child: Text(
                                                  'Add stocks',
                                                  style: baseTextStyle12500
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryColor),
                                                ),
                                              )
                                            ],
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state.getUserAlertModel
                                                  .content.length,
                                              itemBuilder: (context, index) {
                                                if (_isDeleteAll) {
                                                  deleteAlert.add(state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .id ??
                                                      '');
                                                }

                                                return SmartWatchlistCard(
                                                  isEditWatchlist: _isEditPress,
                                                  deleteAll: _isDeleteAll,
                                                  id: state.getUserAlertModel
                                                          .content[index].id ??
                                                      '',
                                                  icon: state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .icon ??
                                                      '',
                                                  companyName: state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .companyName ??
                                                      '',
                                                  symbol: state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .symbol ??
                                                      '',
                                                  movingAverage: state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .lastSevenDaysMovingAverageTrend ??
                                                      '',
                                                  close: state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .close ??
                                                      0,
                                                  change: state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .change ??
                                                      0,
                                                  changePercentage: state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .percentChange ??
                                                      0,
                                                  sector: state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .sector ??
                                                      '',
                                                  alertPrice: state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .price ??
                                                      0,
                                                  qty: state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .quantity ??
                                                      0,
                                                  onItemSelected: (String
                                                      selectedWatchlistId) {
                                                    deleteAlert.add(
                                                        selectedWatchlistId);
                                                  },
                                                  onItemDisSelected: (String
                                                      disSelectedWatchlistId) {
                                                    deleteAlert.remove(
                                                        disSelectedWatchlistId);
                                                  },
                                                  triggered: state
                                                          .getUserAlertModel
                                                          .content[index]
                                                          .triggered ??
                                                      false,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  )
                : BlocBuilder<WatchlistSymbolCubit, WatchlistSymbolState>(
                    builder: (_, state) {
                      if (state is WatchlistSymbolLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      if (state is WatchlistSymbolFailure) {
                        return AppErrorWidget(
                          errorType: state.errorType,
                          error: state.errorMessage,
                          onRetry: () => context
                              .read<WatchlistSymbolCubit>()
                              .fetchWatchlistSymbol(
                                GetWatchlistSymbolParams(
                                  id: '${state.watchlistId}/symbols',
                                ),
                              ),
                        );
                      }
                      if (state is WatchlistSymbolLoaded) {
                        final item = state.watchlistStocksModel;
                        return Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: item.length + 1,
                            itemBuilder: (_, index) {
                              if (item.isEmpty) {
                                return Column(
                                  children: [
                                    const Gap(40),
                                    Assets.svgs.equityNoWatchlist.svg(),
                                    const Gap(24),
                                    const Text(
                                        'Uh-oh, your watchlist is empty'),
                                    const Gap(8),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<EquityNavCubit>()
                                            .equityChangeTab(
                                              const EquityNavEntity(
                                                  mainTabIndex: 0),
                                            );
                                      },
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                      ),
                                      child: const Text('+Add more stocks'),
                                    ),
                                  ],
                                );
                              } else {
                                if (index < item.length) {
                                  return SlideMenu(
                                    menuItems: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(30),
                                                ),
                                              ),
                                              isScrollControlled: true,
                                              isDismissible: true,
                                              context: context,
                                              builder: (BuildContext _) {
                                                return MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider(
                                                      create: (context) =>
                                                          getIt<
                                                              SetAlertCubit>(),
                                                    ),
                                                  ],
                                                  child: SetAlertBootmSheet(
                                                    icon: state
                                                            .watchlistStocksModel[
                                                                index]
                                                            .icon ??
                                                        '',
                                                    symbole: state
                                                            .watchlistStocksModel[
                                                                index]
                                                            .symbol ??
                                                        '',
                                                    companyName: state
                                                            .watchlistStocksModel[
                                                                index]
                                                            .companyName ??
                                                        '',
                                                    close: state
                                                            .watchlistStocksModel[
                                                                index]
                                                            .close ??
                                                        0,
                                                    change: state
                                                            .watchlistStocksModel[
                                                                index]
                                                            .change ??
                                                        0,
                                                    percentChange: state
                                                            .watchlistStocksModel[
                                                                index]
                                                            .percentChange ??
                                                        0,
                                                    qty: state
                                                            .watchlistStocksModel[
                                                                index]
                                                            .quantity ??
                                                        0,
                                                  ),
                                                );
                                              });
                                        },
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                              color: AppColors.lightYellow,
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Assets.pngs
                                                      .smartWatchlistAlertbell
                                                      .image(
                                                          height: 20,
                                                          width: 20),
                                                  const Gap(5),
                                                  Text(
                                                    'Set Alert',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    style: baseTextStyle10400
                                                        .copyWith(
                                                            color: AppColors
                                                                .mainBlack),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<
                                                  RemoveSymbolWatchlistCubit>()
                                              .earseSymbol(
                                                state
                                                        .watchlistStocksModel[
                                                            index]
                                                        .watchlistId ??
                                                    0,
                                                state
                                                        .watchlistStocksModel[
                                                            index]
                                                        .watchlistContentId ??
                                                    0,
                                              )
                                              .then((value) {
                                            context
                                                .read<WatchlistSymbolCubit>()
                                                .fetchWatchlistSymbol(
                                                  GetWatchlistSymbolParams(
                                                    id: '${state.watchlistStocksModel[index].watchlistId}/symbols',
                                                  ),
                                                );
                                          });
                                        },
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Assets.pngs
                                                      .equityRemoveWatchlist
                                                      .image(
                                                          height: 20,
                                                          width: 20),
                                                  const Gap(5),
                                                  Text(
                                                    'Remove',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    style: baseTextStyle10400
                                                        .copyWith(
                                                            color: AppColors
                                                                .primaryWhite),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                    child: WatchlistCardPage(
                                      symbol: state.watchlistStocksModel[index]
                                              .symbol ??
                                          '',
                                      image: state.watchlistStocksModel[index]
                                              .icon ??
                                          '',
                                      name: state.watchlistStocksModel[index]
                                              .companyName ??
                                          '',
                                      subtitle: state
                                              .watchlistStocksModel[index]
                                              .companyName ??
                                          '',
                                      price: state.watchlistStocksModel[index]
                                              .close ??
                                          0,
                                      highValue: state
                                              .watchlistStocksModel[index]
                                              .change ??
                                          0,
                                      percentage: state
                                              .watchlistStocksModel[index]
                                              .percentChange ??
                                          0,
                                    ),
                                  );
                                } else {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<EquityNavCubit>()
                                              .equityChangeTab(
                                                const EquityNavEntity(
                                                    mainTabIndex: 0),
                                              );
                                        },
                                        style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                            Colors.transparent,
                                          ),
                                        ),
                                        child: Text(
                                          '+ Add more stocks',
                                          style: baseTextStyle12600.copyWith(
                                            color: AppColors.primaryLightColor,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(30),
                                              ),
                                            ),
                                            isScrollControlled: true,
                                            isDismissible: true,
                                            context: context,
                                            builder: (BuildContext _) {
                                              return MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(
                                                    create: (context) => getIt<
                                                        RemoveWatchlistCubit>(),
                                                  ),
                                                  BlocProvider.value(
                                                    value: context.read<
                                                        GetAllUserWatchlisCubit>(),
                                                  ),
                                                ],
                                                child:
                                                    DeleteWatchlistBottomsheet(
                                                  watchlistId: state
                                                          .watchlistStocksModel[
                                                              0]
                                                          .watchlistId ??
                                                      0,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                        ),
                                        child: Row(
                                          children: [
                                            Assets.svgs.equityDeleteWatchlist
                                                .svg(height: 10),
                                            const Gap(4),
                                            Text(
                                              'Delete watchlist',
                                              style:
                                                  baseTextStyle12600.copyWith(
                                                      color: AppColors
                                                          .primaryLightColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }
                            },
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
          ],
        ),
        bottomNavigationBar: _isEditPress
            ? Container(
                padding: const EdgeInsets.all(4),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isDeleteAll = !_isDeleteAll;
                        });
                        deleteAlert.clear();
                      },
                      child: Text(
                        'Select All',
                        style: baseTextStyle14400.copyWith(
                            color: AppColors.primaryColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        deleteAlert.isNotEmpty
                            ? showDialog(
                                context: context,
                                builder: (_) {
                                  return MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) =>
                                            getIt<RemoveAlertCubit>(),
                                      ),
                                      BlocProvider.value(
                                        value:
                                            context.read<GetUserAlertsCubit>(),
                                      ),
                                    ],
                                    child: DeleteDialog(
                                      deleteWatchlist: deleteAlert,
                                    ),
                                  );
                                },
                              )
                            : null;
                        setState(() {
                          _isEditPress = !_isEditPress;
                        });
                      },
                      child: Text(
                        'Delete Selected',
                        style: baseTextStyle14400.copyWith(
                            color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  void _colorChange(int index) {
    setState(() {
      _isSelected = index;
    });
  }
}
