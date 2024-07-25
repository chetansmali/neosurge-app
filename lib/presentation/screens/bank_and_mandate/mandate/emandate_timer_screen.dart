import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';

class EmandateTimerScreen extends StatelessWidget {
  const EmandateTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryLightColor,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                ),
              ),
              const Gap(
                20,
              ),
              Text(
                'We are working on E-Mandate',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: EmandateTimerWidget(onFinished: () {
                    Navigator.of(context).pop(true);
                  }),
                ),
              ),
              Assets.svgs.emandate.svg(),
            ],
          ),
        ),
      ),
    );
  }
}

class EmandateTimerWidget extends StatefulWidget {
  final VoidCallback onFinished;
  const EmandateTimerWidget({super.key, required this.onFinished});

  @override
  State<EmandateTimerWidget> createState() => _EmandateTimerWidgetState();
}

class _EmandateTimerWidgetState extends State<EmandateTimerWidget> {
  late Timer _timer;
  late int _secondsRemaining;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = 59;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '00: ${_secondsRemaining.toString().padLeft(2, '0')}',
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
          color: AppColors.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          widget.onFinished();
          _timer.cancel();
        }
      });
    });
  }
}
