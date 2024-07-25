import 'package:flutter/material.dart';

import 'widgets/digital_gold_sip_card.dart';

class DigitalGoldSipsScreen extends StatelessWidget {
  const DigitalGoldSipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY Digital Gold SIPs'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        itemCount: 10,
        itemBuilder: (context, index) => const DigitalGoldSipCard(),
      ),
    );
  }
}
