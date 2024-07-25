import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../../../../common/common.dart';

class DigitalSignatureCaptureScreen extends StatefulWidget {
  final SignatureController signatureController;

  const DigitalSignatureCaptureScreen(
      {Key? key, required this.signatureController})
      : super(key: key);

  @override
  State<DigitalSignatureCaptureScreen> createState() =>
      _DigitalSignatureCaptureScreenState();
}

class _DigitalSignatureCaptureScreenState
    extends State<DigitalSignatureCaptureScreen> {
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    _isEmpty = widget.signatureController.isEmpty;
    widget.signatureController.addListener(() {
      if (mounted) {
        setState(() {
          _isEmpty = widget.signatureController.isEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    widget.signatureController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            // Expanded widget to occupy the remaining space
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  _isEmpty
                      ? const Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [],
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    height: screenHeight /
                        1.4, // Assuming you have screenHeight defined
                    child: DottedBorder(
                      dashPattern: const [4, 4],
                      strokeWidth: 1,
                      color: const Color(0xFFF1F1F1),
                      child: Signature(
                        controller: widget.signatureController,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            // Using a Container instead of Positioned
            padding: const EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth /
                      2.4, // Assuming you have screenWidth defined
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      side: const BorderSide(
                          color: Color(0xFF326CF9), width: 2.0),
                    ),
                    onPressed: () {
                      widget.signatureController.clear();
                    },
                    child: Text('Clear',
                        style: baseTextStyle.copyWith(
                            fontSize: 16, color: const Color(0xFF326CF9))),
                  ),
                ),
                const SizedBox(width: 10), // Using SizedBox instead of Gap
                SizedBox(
                  width: screenWidth / 2.4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Done',
                        style: baseTextStyle.copyWith(
                            fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
