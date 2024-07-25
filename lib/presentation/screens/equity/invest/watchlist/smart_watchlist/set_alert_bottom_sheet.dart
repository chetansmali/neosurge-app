import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../common/custom_styles.dart';
import '../../../../../../common/utils.dart';
import '../../../../../../domain/entities/params/equity/equity_smart_watchlist/create_alert_params.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../cubits/equity/equity_smart_watchlist/set_alert_cubit.dart';
import '../../../../../theme/app_colors.dart';

class SetAlertBootmSheet extends StatefulWidget {
  final String icon;
  final String symbole;
  final String companyName;
  final double close;
  final double change;
  final double percentChange;
  final int qty;

  const SetAlertBootmSheet({
    super.key,
    required this.icon,
    required this.symbole,
    required this.companyName,
    required this.close,
    required this.change,
    required this.percentChange,
    required this.qty,
  });

  @override
  State<SetAlertBootmSheet> createState() => _SetAlertBootmSheetState();
}

class _SetAlertBootmSheetState extends State<SetAlertBootmSheet> {
  String selectedValue = 'EQUAL_TO';
  double _price = 0;
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingControllerDisable =
      TextEditingController();
  @override
  void initState() {
    _price = widget.close;
    _textEditingController.text = widget.close.toString();
    _textEditingControllerDisable.text = widget.close.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Set alert', style: baseTextStyle2),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Assets.icons.crossIcon.image(height: 24, width: 24)),
              ],
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryLightColor,
                  ),
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: widget.icon,
                      errorWidget: (context, url, error) {
                        return Text(
                          widget.symbole.substring(0, 1).toUpperCase(),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.symbole,
                                style: baseTextStyle14400,
                              ),
                              const Gap(5),
                              Container(
                                height: 5,
                                width: 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.textGrey,
                                ),
                              ),
                              const Gap(5),
                              Assets.pngs.equityShareHoldingsSw.image(
                                height: 20,
                                width: 20,
                              ),
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
                              Text(
                                ('(${widget.percentChange.toStringAsFixed(2)}%)'),
                                style: baseTextStyle10400.copyWith(
                                    color: widget.percentChange > 0
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
            const Gap(38),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingControllerDisable,
                          enabled: false,
                          readOnly: true,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.bottom,
                          textInputAction: TextInputAction.done,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          cursorColor: AppColors.primaryColor,
                          cursorRadius: Radius.zero,
                          style: baseTextStyle14500.copyWith(
                            color: AppColors.mainBlack,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            labelText: 'Market Price',
                            hintText: _textEditingControllerDisable.text,
                            floatingLabelStyle: baseTextStyle12400.copyWith(
                                color: AppColors.primaryColor),
                            labelStyle: baseTextStyle12400.copyWith(
                                color: AppColors.primaryColor),
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                      const Gap(15),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_right_outlined,
                          size: 15,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const Gap(15),
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          textAlign: TextAlign.center,
                          autofocus: true,
                          textAlignVertical: TextAlignVertical.bottom,
                          textInputAction: TextInputAction.done,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          cursorColor: AppColors.primaryColor,
                          cursorRadius: Radius.zero,
                          style: baseTextStyle14500.copyWith(
                            color: AppColors.mainBlack,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            labelText: 'Alert Price',
                            hintText: _textEditingController.text,
                            floatingLabelStyle: baseTextStyle12400.copyWith(
                                color: AppColors.primaryColor),
                            labelStyle: baseTextStyle12400.copyWith(
                                color: AppColors.primaryColor),
                            fillColor: Colors.transparent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _price = (5 / 100) * widget.close;
                      _price = widget.close + _price;
                      _textEditingController.text = _price.toStringAsFixed(2);
                    });
                  },
                  child: Container(
                      height: 32,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.green),
                      ),
                      child: Center(
                        child: Text(
                          '+5%',
                          style: baseTextStyle12500.copyWith(
                              color: AppColors.green),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _price = (10 / 100) * widget.close;
                      _price = widget.close + _price;
                      _textEditingController.text = _price.toStringAsFixed(2);
                    });
                  },
                  child: Container(
                      height: 32,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.green),
                      ),
                      child: Center(
                        child: Text(
                          '+10%',
                          style: baseTextStyle12500.copyWith(
                              color: AppColors.green),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _price = (5 / 100) * widget.close;
                      _price = widget.close - _price;
                      _textEditingController.text = _price.toStringAsFixed(2);
                    });
                  },
                  child: Container(
                      height: 32,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.errorRed),
                      ),
                      child: Center(
                        child: Text(
                          '-5%',
                          style: baseTextStyle12500.copyWith(
                              color: AppColors.errorRed),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _price = (10 / 100) * widget.close;
                      _price = widget.close - _price;
                      _textEditingController.text = _price.toStringAsFixed(2);
                    });
                  },
                  child: Container(
                    height: 32,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.errorRed),
                    ),
                    child: Center(
                        child: Text(
                      '-10%',
                      style: baseTextStyle12500.copyWith(
                          color: AppColors.errorRed),
                    )),
                  ),
                ),
              ],
            ),
            const Gap(48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Alert me when stock price is',
                  style: baseTextStyle12400,
                ),
                Container(
                  height: 32,
                  width: 122,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: selectedValue,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 20,
                        iconEnabledColor: AppColors.primaryColor,
                        style: baseTextStyle10500.copyWith(
                            color: AppColors.primaryColor),
                        underline: const SizedBox(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        items: <String>[
                          'EQUAL_TO',
                          'GREATER_THAN',
                          'LESS_THAN',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    _textEditingController.text != ''
                        ? _textEditingController.text
                        : widget.close.toStringAsFixed(2),
                    style: baseTextStyle12500,
                  ),
                )
              ],
            ),
            const Gap(38),
            ElevatedButton(
              onPressed: () {
                context.read<SetAlertCubit>().setAlert(
                      CreateAlertParams(
                          symbol: widget.symbole,
                          price: _textEditingController.text != ''
                              ? double.parse(_textEditingController.text)
                              : widget.close,
                          comparisonMetric: selectedValue),
                    );
              },
              child: BlocConsumer<SetAlertCubit, SetAlertState>(
                listener: (context, state) {
                  if (state is SetAlertSuccess) {
                    Navigator.pop(context, 'true');
                    Utils.showSuccessAlert(context,
                        'Alert set ${widget.symbole} at ${_textEditingController.text != '' ? _textEditingController.text : widget.close} price');
                  }
                },
                builder: (context, state) {
                  return state is SetAlertLoading
                      ? Assets.animations.loading.lottie()
                      : Text(
                          'Create alert',
                          style: baseTextStyle16500,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
