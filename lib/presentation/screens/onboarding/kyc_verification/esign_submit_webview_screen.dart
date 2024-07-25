import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../logger.dart';

const String _h = 'authorise_mandate_webview';

class ESignSubmitWebViewScreen extends StatefulWidget {
  final String url;

  const ESignSubmitWebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<ESignSubmitWebViewScreen> createState() => _ESignSubmitWebViewScreenState();
}

class _ESignSubmitWebViewScreenState extends State<ESignSubmitWebViewScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            logDebugFinest(_h, 'onPageStarted: $url');
          },
          onPageFinished: (String url) {
            logDebugFinest(_h, 'onPageFinished: $url');
            if (url.contains('success')) {
              Navigator.of(context).pop(true);
            }
          },
          onWebResourceError: (WebResourceError error) {
            logError(_h, 'WebResourceError : ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(context: context, builder: (ctx) => const _ConfirmExitDialog());
        return false;
      },
      child: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}

class _ConfirmExitDialog extends StatelessWidget {
  const _ConfirmExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Cancel ESign Submission?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            const Text(
              'This process has to be done again if you cancel.',
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
