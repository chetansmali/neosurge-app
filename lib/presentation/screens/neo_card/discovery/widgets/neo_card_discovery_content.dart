import 'package:flutter/material.dart';

class NeoCardDiscoveryContent extends StatelessWidget {
  const NeoCardDiscoveryContent({
    super.key,
    required this.title,
    required this.description,
  });

  final Widget title;
  final Widget description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Center(child: title),
        ),
        Expanded(
          child: description,
        ),
      ],
    );
  }
}
