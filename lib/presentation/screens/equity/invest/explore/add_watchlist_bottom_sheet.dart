import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../common/custom_styles.dart';
import '../../../../../di/get_it.dart';
import '../../../../../domain/entities/params/equity/equity_watchlist/add_stock_watchlist.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../cubits/equity/equity_smart_watchlist/set_alert_cubit.dart';
import '../../../../cubits/equity/equity_watchlist/add_stock_watchlist_cubit.dart';
import '../../../../cubits/equity/equity_watchlist/create_watchlist_cubit.dart';
import '../../../../cubits/equity/equity_watchlist/get_all_user_watchlis_cubit.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/gradient_text.dart';
import '../watchlist/smart_watchlist/set_alert_bottom_sheet.dart';
import '../watchlist/watchlist_bottomsheet.dart';

class AddStockToWatchList extends StatefulWidget {
  final String synbolName;
  final String icon;
  final String companyName;
  final double close;
  final double change;
  final double percentageChange;
  final int qty;

  const AddStockToWatchList(
      {super.key,
      required this.synbolName,
      required this.icon,
      required this.close,
      required this.change,
      required this.percentageChange,
      required this.qty,
      required this.companyName});

  @override
  State<AddStockToWatchList> createState() => _AddStockToWatchListState();
}

class _AddStockToWatchListState extends State<AddStockToWatchList> {
  int selectedWatchlist = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Choose watchlist', style: baseTextStyle2),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Assets.icons.crossIcon.image(height: 24, width: 24)),
              ],
            ),
            const Gap(20),
            BlocBuilder<GetAllUserWatchlisCubit, GetAllUserWatchlisState>(
              builder: (context, state) {
                if (state is GetAllUserWatchlisLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (state is GetAllUserWatchlisLoaded) {
                  final watchlist = state.getAllWatchlist;
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: ListView.builder(
                            itemCount: watchlist.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return ListTile(
                                  title: GradientText(
                                    'Smart Watchlist',
                                    style: baseTextStyle16500,
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primaryColor,
                                        AppColors.errorRed,
                                        AppColors.lightYellow,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  leading: Radio(
                                    value: -1,
                                    groupValue: selectedWatchlist,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedWatchlist = value!;
                                      });
                                    },
                                  ),
                                );
                              } else {
                                return ListTile(
                                  title: Text(
                                    watchlist[index - 1].name,
                                    style: baseTextStyle16500,
                                  ),
                                  leading: Radio(
                                    value: watchlist[index - 1].id,
                                    groupValue: selectedWatchlist,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedWatchlist = value!;
                                      });
                                    },
                                  ),
                                );
                              }
                            }),
                      ),
                      Row(
                        children: [
                          Text(
                            'Prefer a new watchlist?',
                            style: baseTextStyle14400.copyWith(
                                color: AppColors.textGrey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30),
                                  ),
                                ),
                                isScrollControlled: true,
                                isDismissible: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) =>
                                            getIt<CreateWatchlistCubit>(),
                                      ),
                                    ],
                                    child: const MyBottomSheet(
                                      refreshWatchlist: false,
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Text('Create now'),
                          ),
                        ],
                      ),
                      const Gap(8),
                      ElevatedButton(
                        onPressed: () {
                          selectedWatchlist != -1
                              ? {
                                  context
                                      .read<AddStockWatchlistCubit>()
                                      .pushStockWatchlist(
                                        AddStockWatchlistParams(
                                          symbol: widget.synbolName,
                                          watchlistId: selectedWatchlist,
                                        ),
                                      ),
                                  Navigator.pop(context)
                                }
                              : {
                                  Navigator.pop(context),
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
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
                                                  getIt<SetAlertCubit>(),
                                            ),
                                          ],
                                          child: SetAlertBootmSheet(
                                            icon: widget.icon,
                                            symbole: widget.synbolName,
                                            companyName: widget.companyName,
                                            close: widget.close,
                                            change: widget.change,
                                            percentChange:
                                                widget.percentageChange,
                                            qty: widget.qty,
                                          ),
                                        );
                                      }),
                                };
                        },
                        child: BlocConsumer<AddStockWatchlistCubit,
                            AddStockWatchlistState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return state is AddStockWatchlistLoading
                                ? Assets.animations.loading.lottie()
                                : const Text('Continue');
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
