import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../../di/get_it.dart';
import '../../../../../../domain/entities/params/equity/equity_smart_watchlist/alert_details_params.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../cubits/equity/equity_smart_watchlist/get_alert_details_cubit.dart';
import '../../../../../cubits/equity/equity_smart_watchlist/get_user_alerts_cubit.dart';
import 'alert_detail_bottom_sheet.dart';

import '../../../../../../common/custom_styles.dart';
import '../../../../../../common/utils.dart';
import '../../../../../theme/app_colors.dart';

class SmartWatchlistCard extends StatefulWidget {
  final bool isEditWatchlist;
  final bool deleteAll;
  final String icon;
  final String companyName;
  final String symbol;
  final String movingAverage;
  final double close;
  final double change;
  final double changePercentage;
  final String sector;
  final double alertPrice;
  final String id;
  final int qty;
  final bool triggered;
  final ValueChanged<String> onItemSelected;
  final ValueChanged<String> onItemDisSelected;

  const SmartWatchlistCard({
    super.key,
    required this.onItemSelected,
    required this.onItemDisSelected,
    required this.isEditWatchlist,
    required this.deleteAll,
    required this.icon,
    required this.companyName,
    required this.symbol,
    required this.movingAverage,
    required this.close,
    required this.change,
    required this.changePercentage,
    required this.sector,
    required this.alertPrice,
    required this.id,
    required this.triggered,
    required this.qty,
  });

  @override
  State<SmartWatchlistCard> createState() => _SmartWatchlistCardState();
}

class _SmartWatchlistCardState extends State<SmartWatchlistCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: false,
          context: context,
          builder: (BuildContext _) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<GetAlertDetailsCubit>()
                    ..fetchAlertDetails(
                        AlertDetailsParams(symbol: widget.symbol)),
                ),
                BlocProvider.value(value: context.read<GetUserAlertsCubit>()),
              ],
              child: AlertDetailsBootmSheet(symbol: widget.symbol),
            );
          },
        );
      },
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isSelected = !_isSelected;
                      });
                      if (_isSelected) {
                        widget.onItemSelected(widget.id);
                      } else {
                        widget.onItemDisSelected(widget.id);
                      }
                    },
                    splashColor: Colors.transparent,
                    child: SizedBox(
                      child: widget.isEditWatchlist
                          ? Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColors.textGrey),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: _isSelected
                                  ? const Icon(
                                      Icons.check,
                                      size: 30,
                                      color: Colors.green,
                                    )
                                  : widget.deleteAll
                                      ? const Icon(
                                          Icons.check,
                                          size: 30,
                                          color: Colors.green,
                                        )
                                      : null,
                            )
                          : widget.triggered
                              ? Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.primaryLightColor,
                                  ),
                                  child: Center(
                                    child: Assets.gifs.smartWatchlistAlarm
                                        .image(height: 40, width: 40),
                                  ),
                                )
                              : Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.primaryLightColor,
                                  ),
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl: widget.icon,
                                      errorWidget: (context, url, error) {
                                        return Text(
                                          widget.symbol
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.symbol,
                                  style: baseTextStyle14400,
                                ),
                                const Gap(5),
                                Assets.pngs.equityShareHoldingsSw
                                    .image(height: 20, width: 20),
                                const Gap(5),
                                Text(widget.qty.toString()),
                              ],
                            ),
                            Text(
                              Utils.compactCurrency(widget.close),
                              style: baseTextStyle14400,
                            ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.companyName,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: baseTextStyle10400.copyWith(
                                    color: AppColors.textGrey),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.change > 0
                                      ? ('+${widget.change.toStringAsFixed(2)}')
                                      : (widget.change.toStringAsFixed(2)),
                                  style: baseTextStyle10400.copyWith(
                                    color: widget.change > 0
                                        ? AppColors.green
                                        : AppColors.errorRed,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  ('(${widget.changePercentage.toStringAsFixed(2)}%)'),
                                  style: baseTextStyle10400.copyWith(
                                      color: widget.changePercentage > 0
                                          ? AppColors.green
                                          : AppColors.errorRed),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Gap(5),
              Row(
                children: [
                  widget.movingAverage == 'UP'
                      ? Assets.gifs.trendingUp.image(
                          height: 20,
                          width: 20,
                        )
                      : Assets.gifs.trendingDown.image(
                          height: 20,
                          width: 20,
                        ),
                  const Gap(20),
                  widget.movingAverage == 'UP'
                      ? Text(
                          'The stock has been moving up',
                          style: baseTextStyle10400,
                        )
                      : Text(
                          'The stock has been moving down',
                          style: baseTextStyle10400,
                        ),
                ],
              ),
              const Divider(
                thickness: 0.5,
                color: AppColors.textGrey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Assets.pngs.smartWatchlistAlertbell
                          .image(height: 20, width: 20),
                      const Gap(10),
                      Text(widget.alertPrice.toStringAsFixed(2),
                          style: baseTextStyle12500),
                    ],
                  ),
                  Container(
                    height: 22,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 6),
                      child: Center(
                        child: Text(
                          widget.sector,
                          overflow: TextOverflow.ellipsis,
                          style: baseTextStyle10500.copyWith(
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
