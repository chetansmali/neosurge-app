import 'package:flutter/material.dart';

///[LabelText] is a widget that displays the label for the [TextField] widget.
///We are using this as the default labelText property in [InputDecoration],
///cannot have spacing between the Floating Label and [TextField] box.

class LabelText extends StatelessWidget {
  final String label;

  const LabelText({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}
