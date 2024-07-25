import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../../logger.dart';

const String _h = 'about_webview';

class AboutWebView extends HookWidget {
  final String url;
  final String title;

  const AboutWebView({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urlProgress = useState<double>(0);

    dynamic controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest navigationRequest) {
            if (navigationRequest.url.contains('mailto:') || navigationRequest.url.contains('tel:')) {
              launchUrl(Uri.parse(navigationRequest.url));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onProgress: (int progress) {
            //urlProgress.value = 0.5;
            logDebugFinest(_h, 'onPageProgress: $url , $progress');
          },
          onPageStarted: (String url) {
            //urlProgress.value = 0.3;
            logDebugFinest(_h, 'onPageStarted: $url');
          },
          onPageFinished: (String url) {
            //urlProgress.value = 1;
            logDebugFinest(_h, 'onPageFinished: $url');
          },
          onWebResourceError: (WebResourceError error) {
            logError(_h, 'WebResourceError : ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    useEffect(() {
      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        controller.platform as WebKitWebViewController;
        // controller.setAllowsBackForwardNavigationGestures = true;
      } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
        controller.platform as AndroidWebViewController;
      }
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          urlProgress.value < 1
              ? LinearProgressIndicator(
                  value: urlProgress.value,
                  backgroundColor: Colors.white,
                )
              : const SizedBox.shrink(),
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
