import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../../../../common/common.dart';

class RedeemPage extends StatefulWidget {
  const RedeemPage({Key? key}) : super(key: key);

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  bool loading = false;
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _hasForcedError = false;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            onPressed: () {
              loading
                  ? Navigator.pop(context)
                  : setState(() {
                      loading = true;
                    });
            },
            child: Text(loading ? 'Okay' : 'Continue'),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Redeem'),
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/redeem_successfull.json',
                    height: 140,
                  ),
                  const Gap(20),
                  const Text('You have successfully deleted your SIP')
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter OTP',
                          style: baseTextStyle2,
                        ),
                        Text(
                          'sent to +91 8105527317 ',
                          style: baseTextStyle1.copyWith(
                              color: const Color(0xFF47586E)),
                        )
                      ],
                    ),
                    const Gap(20),
                    Pinput(
                      obscureText: true,
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
                    Text(
                      'Request new OTP',
                      style: baseTextStyle1.copyWith(
                          color: const Color(0xFF297DFD)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
