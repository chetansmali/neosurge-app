import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/custom_styles.dart';
import '../../../../gen/assets.gen.dart';

class CustomerCardScreen extends StatefulWidget {
  const CustomerCardScreen({Key? key}) : super(key: key);

  @override
  State<CustomerCardScreen> createState() => _CustomerCardScreenState();
}

class _CustomerCardScreenState extends State<CustomerCardScreen> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    String cardNumber = '4032778208246661';
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Gap(120),
              Text(
                'Your Prepaid Card is here!',
                style: baseTextStyle2.copyWith(
                  color: const Color(0xFF121517),
                ),
              ),
              const Gap(50),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: screenHeight / 2,
                            width: screenWidth / 1.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: screenWidth / 1.6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        Assets.pngs.cardVerifyLogo.path
                                            .toString(),
                                        height: 30,
                                        width: 30,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(100),
                                SizedBox(
                                  width: screenWidth / 1.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            Assets.pngs.cardExpiryIcon.path
                                                .toString(),
                                            height: 30,
                                            width: 30,
                                            color: Colors.black,
                                          ),
                                          const Gap(5),
                                          Text(
                                            'Expiry Date',
                                            style: baseTextStyle10400.copyWith(
                                                color: const Color(0xFF47586E)),
                                          ),
                                          const Gap(5),
                                          Text(
                                            '09/27',
                                            style: baseTextStyle,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(50),
                                SizedBox(
                                  width: screenWidth / 1.6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            Assets.pngs.cardLockIcon.path
                                                .toString(),
                                            height: 30,
                                            width: 30,
                                            color: Colors.black,
                                          ),
                                          const Gap(5),
                                          Text(
                                            'CVV (Security Code)',
                                            style: baseTextStyle10400.copyWith(
                                                color: const Color(0xFF47586E)),
                                          ),
                                          const Gap(5),
                                          Text(
                                            '365',
                                            style: baseTextStyle,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  AnimatedPositioned(
                    left: selected ? screenWidth / 8 : -70,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: screenHeight / 2,
                                width: screenWidth / 1.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: const Color(0xFF0F0F0F)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: screenWidth / 1.6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            Assets.pngs.cardVerifyLogo.path
                                                .toString(),
                                            height: 30,
                                            width: 30,
                                          ),
                                          Image.asset(
                                            Assets.pngs.cardIcon.path
                                                .toString(),
                                            height: 30,
                                            width: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(150),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                          (cardNumber.length / 4).ceil(),
                                          (index) {
                                        final start = index * 4;
                                        final end =
                                            (start + 4 < cardNumber.length)
                                                ? start + 4
                                                : cardNumber.length;
                                        return Column(
                                          children: [
                                            Text(
                                              cardNumber.substring(start, end),
                                              style:
                                                  baseTextStyle16500.copyWith(
                                                      color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                    const Gap(130),
                                    SizedBox(
                                      width: screenWidth / 1.6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Shreyash Buchadi',
                                            style: baseTextStyle14500.copyWith(
                                                color: Colors.white),
                                          ),
                                          Image.asset(
                                            Assets.pngs.cardVisa.path
                                                .toString(),
                                            height: 30,
                                            width: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(5),
              Text(
                'click on the card to check more details',
                style:
                    baseTextStyle10400.copyWith(color: const Color(0xFFBEBFC1)),
              ),
              const Gap(140),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Add Money to your Card'),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              const Text(
                'I’ll do it later',
                style: TextStyle(color: Color(0xFF326CF9)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
