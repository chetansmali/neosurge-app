import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../../../../common/extensions.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/label_text.dart';
import 'assited_service_expiry_banner.dart';

class AnalyseAssistedServiceScreen extends HookWidget {
  const AnalyseAssistedServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amountController = useTextEditingController();
    final tenureController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: CustomScrollView(
            primary: false,
            slivers: [
              const SliverToBoxAdapter(
                child: AssistedServiceExpiryBanner(),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(60),
                      Assets.svgs.analyseAssistedService.svg(height: 200),
                      const Gap(90),
                      const Text(
                        'Enter these Details to help us plan and analyze best Strategy for you',
                        style: TextStyle(
                          color: AppColors.secondaryViolet,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(20),
                      const LabelText(label: 'Enter the amount'),
                      TextFormField(
                        controller: amountController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the amount';
                          }
                          if (value.removeCommas < 500000) {
                            return 'Minimum amount should be 5,00,000';
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
                        decoration: const InputDecoration(prefixText: '₹ '),
                      ),
                      const Gap(20),
                      const LabelText(label: 'Enter the Investment Horizon'),
                      TextFormField(
                        controller: tenureController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the tenure';
                          }
                          if (int.parse(value) < 1) {
                            return 'Minimum tenure is 1 year';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(hintText: 'in Years'),
                      ),
                      const Gap(20),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            FocusScope.of(context).unfocus();
                            Navigator.pushNamed(context, Routes.fundSuggestion, arguments: FundSuggestionArgs(amount: amountController.text.removeCommas, tenure: int.parse(tenureController.text)));
                          },
                          child: const Text('Next'))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
