import 'package:flutter/material.dart';

class CustomRadioTile extends StatelessWidget {
  final String title;
  final Radio radio;

  const CustomRadioTile({Key? key, required this.title, required this.radio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        radio,
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ],
    );
  }
}
