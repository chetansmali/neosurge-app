import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../common/custom_styles.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../theme/app_colors.dart';

class OrderSummaryScreen extends StatefulWidget {
  final String type;
  final int? qty;
  final double price;
  final String name;

  const OrderSummaryScreen({
    super.key,
    required this.type,
    required this.qty,
    required this.price,
    required this.name,
  });

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime =
        " ${now.hour}:${now.minute} ${now.day}/${now.month}/${now.year}";
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
          child: ElevatedButton(
            child: const Text('Done'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (widget.type != 'COMPLETE')
                ? Assets.animations.orderFailed.lottie(height: 200, width: 200)
                : Assets.animations.orderSuccessfull
                    .lottie(height: 200, width: 200),
            (widget.type != 'COMPLETE')
                ? Text(
                    'Transaction ${widget.type.toLowerCase()}',
                    style: baseTextStyle21500,
                  )
                : Text(
                    'Order Placed',
                    style: baseTextStyle21500,
                  ),
            const Gap(32),
            Material(
              elevation: 0.1,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 17.0,
                  right: 17,
                  top: 12,
                  bottom: 12,
                ),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.name),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryLightColor,
                                borderRadius: BorderRadius.circular(70),
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 13.0, right: 13, top: 10, bottom: 10),
                                child: Text(
                                  'NSE',
                                  style: baseTextStyle12700.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Tile(
                          title: 'Qty',
                          value: widget.qty.toString(),
                        ),
                        Tile(
                          title:
                              '${widget.type.substring(0, 1)}${widget.type.substring(1).toLowerCase()} price',
                          value: '${widget.price}',
                        ),
                        Tile(
                          title: 'Date & Time',
                          value: formattedDateTime,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({super.key, required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: baseTextStyle14400.copyWith(color: AppColors.textGrey),
          ),
          Text(
            value,
            style: baseTextStyle.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
