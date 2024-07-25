import 'package:flutter/material.dart';

import '../../../routes/routes.dart';

class CheckboxWithText extends StatefulWidget {
  const CheckboxWithText({super.key});

  @override
  State<CheckboxWithText> createState() => _CheckboxWithTextState();
}

class _CheckboxWithTextState extends State<CheckboxWithText> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
            });
          },
          side: BorderSide(
            color: _isChecked == true ? Colors.blueAccent : Colors.black,
          ),
          checkColor: Colors.blueAccent,
          activeColor: Colors.blue[50],
        ),
        const Text(
          'Yes, I agree',
          style: TextStyle(fontSize: 12),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, Routes.equityTermsConditions),
          child: const Text(
            'Terms and Conditions',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
