import 'package:flutter/material.dart';

class DataSecure extends StatelessWidget {
  ///A widget that displays lock icon and data is secure text
  const DataSecure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.lock_outlined,
          color: Color(0xFF929191),
          size: 10,
        ),
        Text(
          'Don’t worry, your data is 100% safe & secure',
          style: TextStyle(
            color: Color(0xFF929191),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
