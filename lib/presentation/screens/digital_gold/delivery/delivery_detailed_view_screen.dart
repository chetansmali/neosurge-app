import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../../common/decimal_input_formatter.dart';
import '../../../../data/models/digital_gold/delivery_product_model.dart';
import '../../../../data/models/digital_gold/gold_user.dart';
import '../../../../domain/entities/enums.dart';
import '../../../cubits/digital_gold/gold_user_cubit/gold_user_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/two_row_text.dart';
import '../widgets/dg_product_view.dart';
import '../widgets/metal_image.dart';

class DeliveryDetailedViewScreen extends StatefulWidget {
  final DeliveryProductModel deliveryProduct;

  const DeliveryDetailedViewScreen({
    super.key,
    required this.deliveryProduct,
  });

  @override
  State<DeliveryDetailedViewScreen> createState() =>
      _DeliveryDetailedViewScreenState();
}

class _DeliveryDetailedViewScreenState
    extends State<DeliveryDetailedViewScreen> {
  int _minCount = 1;
  final TextEditingController _qtyController = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    final GoldUser goldUser = context.read<GoldUserCubit>().state.goldUser!;

    return Scaffold(
      appBar: AppBar(title: const Text('Get Delivery')),
      body: Column(
        children: [
          if (_minCount * widget.deliveryProduct.reedemWeight >
              (widget.deliveryProduct.metalType == MetalType.gold
                  ? goldUser.transactionalGoldBalance
                  : goldUser.transactionalSilverBalance)) ...[
            const Gap(12.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: AppColors.error[50],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.info_rounded,
                    color: AppColors.errorRed,
                  ),
                  const Gap(4.0),
                  Text(
                    'Not enough ${widget.deliveryProduct.metalType.name} balance to buy this coin',
                    style: baseTextStyle12400.copyWith(
                      color: AppColors.errorRed,
                    ),
                  )
                ],
              ),
            )
          ],
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: Column(
                children: [
                  const Gap(30.0),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20.0,
                            offset: const Offset(0, 6),
                            color: Colors.black.withOpacity(0.12),
                          )
                        ]),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        widget.deliveryProduct.defaultImageUrl == null
                            ? MetalImage(
                                metalType: widget.deliveryProduct.metalType,
                                size: 200,
                              )
                            : DgProductView(
                                defaultImageUrl:
                                    widget.deliveryProduct.defaultImageUrl!,
                                imageUrls: widget.deliveryProduct.productImages
                                    .map((e) => e.url)
                                    .toList(),
                              ),
                        const Gap(14),
                        Text(
                          widget.deliveryProduct.name,
                          style: baseTextStyle18500.copyWith(
                              color: AppColors.neutral[500]),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(8),
                        RichText(
                          text: TextSpan(
                            style: baseTextStyle12400.copyWith(
                                color: AppColors.neutral[400]),
                            children: [
                              TextSpan(
                                  text: 'SKU - ${widget.deliveryProduct.sku}'),
                              TextSpan(
                                  text:
                                      ' (${widget.deliveryProduct.status != 'active' ? 'Not in' : 'In'} Stock)',
                                  style: baseTextStyle12400.copyWith(
                                      color: widget.deliveryProduct.status !=
                                              'active'
                                          ? AppColors.errorRed
                                          : AppColors.success[500])),
                            ],
                          ),
                        ),
                        const Gap(14),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.neutral[50],
                          ),
                          width: MediaQuery.sizeOf(context).width / 2,
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (int.parse(_qtyController.text) > 1) {
                                    setState(() {
                                      _qtyController.text =
                                          '${int.parse(_qtyController.text) - 1}';
                                      _minCount -= 1;
                                    });
                                  }
                                },
                                color: AppColors.neutral[800],
                                icon: const Icon(Icons.remove_rounded),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _qtyController,
                                  style: baseTextStyle16500.copyWith(
                                      color: AppColors.neutral[400]),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    if (widget.deliveryProduct.metalType ==
                                        MetalType.gold) {
                                      if (goldUser.transactionalGoldBalance <
                                          (_minCount + 1) *
                                              widget.deliveryProduct
                                                  .reedemWeight) {
                                        Fluttertoast.showToast(
                                            msg: 'Not enough gold balance');
                                      }
                                    } else {
                                      if (goldUser.transactionalSilverBalance <
                                          (_minCount + 1) *
                                              widget.deliveryProduct
                                                  .reedemWeight) {
                                        Fluttertoast.showToast(
                                            msg: 'Not enough silver balance');
                                      }
                                    }
                                    setState(
                                        () => _minCount = int.parse(value));
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.transparent,
                                  ),
                                  inputFormatters: [
                                    DecimalTextInputFormatter(decimalRange: 0),
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'^0*$'),
                                        replacementString: '1'),
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'^\s*$')),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (widget.deliveryProduct.metalType ==
                                        MetalType.gold) {
                                      if (goldUser.transactionalGoldBalance >
                                          (_minCount + 1) *
                                              widget.deliveryProduct
                                                  .reedemWeight) {
                                        _qtyController.text =
                                            '${int.parse(_qtyController.text) + 1}';
                                        _minCount += 1;
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Not enough gold balance');
                                      }
                                    } else {
                                      if (goldUser.transactionalSilverBalance >
                                          (_minCount + 1) *
                                              widget.deliveryProduct
                                                  .reedemWeight) {
                                        _qtyController.text =
                                            '${int.parse(_qtyController.text) + 1}';
                                        _minCount += 1;
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Not enough silver balance');
                                      }
                                    }
                                  });
                                },
                                color: AppColors.neutral[800],
                                icon: const Icon(Icons.add_rounded),
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        Divider(color: AppColors.neutral[50]),
                        const Gap(20),
                        TwoRowText(
                          title: 'Total coins',
                          subtitle: _qtyController.value.text,
                          titleStyle: _titleStyle,
                          subtitleStyle: _subtitleStyle,
                        ),
                        const Gap(12),
                        TwoRowText(
                          title: 'Making & Delivery charges',
                          subtitle: '₹${widget.deliveryProduct.basePrice}',
                          titleStyle: _titleStyle,
                          subtitleStyle: _subtitleStyle,
                        ),
                        const Gap(16),
                        DottedLine(dashColor: AppColors.neutral[50]!),
                        const Gap(16),
                        TwoRowText(
                          title: 'Total payable',
                          subtitle:
                              '₹${widget.deliveryProduct.basePrice * _minCount}',
                          titleStyle: _titleStyle,
                          subtitleStyle:
                              baseTextStyle18500.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const Gap(30.0),
                ],
              ),
            ),
          ),
          const Gap(12.0),
          Container(),
          ElevatedButton(
            onPressed: (_minCount * widget.deliveryProduct.reedemWeight <
                    (widget.deliveryProduct.metalType == MetalType.gold
                        ? goldUser.transactionalGoldBalance
                        : goldUser.transactionalSilverBalance))
                ? () => Navigator.pushNamed(
                    context, Routes.selectDeliveryAddress,
                    arguments: DeliveryProductArgs(
                        deliveryProductModel: widget.deliveryProduct,
                        quantity: _minCount))
                : null,
            child: const Text('Select Delivery Address'),
          ),
          const Gap(30.0),
        ],
      ),
    );
  }

  TextStyle get _titleStyle =>
      baseTextStyle12400.copyWith(color: AppColors.neutral[400]);

  TextStyle get _subtitleStyle =>
      baseTextStyle12500.copyWith(color: Colors.black);
}
