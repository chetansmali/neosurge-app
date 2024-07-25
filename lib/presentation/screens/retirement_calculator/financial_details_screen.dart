import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import '../../../common/extensions.dart';
import '../../routes/route_arguments.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/gradient_text.dart';
import '../../widgets/label_text.dart';
import '../../../common/custom_styles.dart';
import '../../theme/app_colors.dart';

class FinancialDetailsScreens extends HookWidget {
  const FinancialDetailsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeController = useTextEditingController();
    final expenceController = useTextEditingController();
    final savingontroller = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Financial Details',
          style: baseTextStyle14400,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomContainer(
                radius: 30,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Column(
                      children: [
                        GradientText(
                          'First, let’s get to know your financial status',
                          gradient: const LinearGradient(
                            colors: [Colors.black87, Color(0xFF0046D2)],
                          ),
                          style: baseTextStyle14600.copyWith(fontSize: 28),
                        ),
                        const Gap(30),
                        const LabelText(label: 'Monthly income'),
                        TextFormField(
                          controller: incomeController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Monthly income';
                            }
                            return null;
                          },
                          inputFormatters: [
                            CurrencyTextInputFormatter(
                              locale: 'en_IN',
                              symbol: '',
                              decimalDigits: 0,
                            ),
                          ],
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.rupeeSign,
                              size: 14,
                              color: AppColors.mainBlack,
                            ),
                          ),
                        ),
                        const Gap(20),
                        const LabelText(label: 'Monthly expense'),
                        TextFormField(
                          controller: expenceController,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Monthly expense';
                            }
                            return null;
                          },
                          inputFormatters: [
                            CurrencyTextInputFormatter(
                              locale: 'en_IN',
                              symbol: '',
                              decimalDigits: 0,
                            ),
                          ],
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.rupeeSign,
                              size: 14,
                              color: AppColors.mainBlack,
                            ),
                          ),
                        ),
                        const Gap(20),
                        const LabelText(label: 'Total current savings'),
                        TextFormField(
                          controller: savingontroller,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the total current savings';
                            }
                            return null;
                          },
                          inputFormatters: [
                            CurrencyTextInputFormatter(
                              locale: 'en_IN',
                              symbol: '',
                              decimalDigits: 0,
                            ),
                          ],
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.rupeeSign,
                              size: 14,
                              color: AppColors.mainBlack,
                            ),
                          ),
                        ),
                        const Gap(48),
                        ElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            FocusScope.of(context).unfocus();
                            Navigator.pushNamed(context, Routes.tellUsScreen,
                                arguments: RetirementFinancialDetailsArgs(
                                  expence: expenceController.text.removeCommas
                                      .toInt(),
                                  income: incomeController.text.removeCommas
                                      .toInt(),
                                  saving:
                                      savingontroller.text.removeCommas.toInt(),
                                ));
                          },
                          child: Text(
                            'Continue',
                            style: baseTextStyle16500.copyWith(
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
