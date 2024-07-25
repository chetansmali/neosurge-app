import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../widgets/error_info_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common/custom_styles.dart';
import 'card_screen.dart';

class EnterCustomerOTPScreen extends StatefulWidget {
  const EnterCustomerOTPScreen({Key? key}) : super(key: key);

  @override
  State<EnterCustomerOTPScreen> createState() => _EnterCustomerOTPScreenState();
}

class _EnterCustomerOTPScreenState extends State<EnterCustomerOTPScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String? _otpErrorMsg = '';
  bool _hasForcedError = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CustomerCardScreen()));
            },
            child: const Text('Verify'),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter OTP',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('sent to +91 8105527317',
                          style: baseTextStyle.copyWith(
                            color: const Color(0xFF727579),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    const Gap(20),
                    Pinput(
                      obscureText: false,
                      length: 6,
                      controller: _controller,
                      focusNode: _focusNode,
                      validator: (value) {
                        String? error;
                        if (value!.isEmpty) {
                          error = 'Please enter OTP';
                        }
                        if (value.length != 6) {
                          error = 'Please enter 6 digit OTP';
                        }
                        if (value.length == 6) {}
                        _otpErrorMsg = error;
                        return error;
                      },
                      onChanged: (String value) {
                        _formKey.currentState!.validate();
                        _hasForcedError = false;
                        setState(() {});
                      },
                      errorTextStyle: const TextStyle(
                        fontSize: 0,
                      ),
                      defaultPinTheme: CustomStyles.defaultPinTheme,
                      errorPinTheme: CustomStyles.errorPinTheme,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      forceErrorState: _hasForcedError,
                      showCursor: false,
                      cursor: cursor,
                    ),
                    const Gap(20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Request new OTP',
                          style: baseTextStyle.copyWith(
                            color: const Color(0xFF2D8EFF),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => setState(() => isChecked = !isChecked),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            width: 20, // Checkbox size
                            height: 20, // Checkbox size
                            child: isChecked
                                ? const Icon(Icons.check,
                                    size: 14, color: Colors.black)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 8), // You can adjust this space
                        GestureDetector(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://transcorpint.com/ppi-policies-and-tc/');
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                'I agree to issuance and ',
                                style: baseTextStyle1.copyWith(
                                    color: const Color(0xFFBEBFC1)),
                              ),
                              Text(
                                'T&C',
                                style: baseTextStyle1.copyWith(
                                    color: const Color(0xFF2D8EFF)),
                              ),
                              Text(
                                ' of Transcorp PPI',
                                style: baseTextStyle1.copyWith(
                                    color: const Color(0xFFBEBFC1)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    if (_otpErrorMsg != null && _otpErrorMsg!.isNotEmpty) ...[
                      ErrorInfoWidget(otpErrorMsg: _otpErrorMsg),
                      const Gap(20),
                    ]
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
