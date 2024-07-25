import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../../domain/entities/enums.dart';
import '../../../../logger.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';

const String _h = 'mf_payment_webview';

class PaymentWebViewScreen extends HookWidget {
  final String url;
  final MFTransactionTypes transactionType;

  const PaymentWebViewScreen(
      {Key? key, required this.url, required this.transactionType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urlProgress = useState<double>(0);

    dynamic controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest navigationRequest) {
            if (navigationRequest.url
                .contains('custom://neosurgeapp.com/success')) {
              if (transactionType == MFTransactionTypes.basket) {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.buyBasketStatus,
                  arguments: BasketTransactionStatus.success,
                );
              } else if (transactionType == MFTransactionTypes.cart) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.statusCartTrasaction,
                  ModalRoute.withName(Routes.mutualFunds),
                  arguments: MfTransactionStatus.success,
                );
              } else {
                logDebugFinest(_h, 'MF Payment Successful');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.mfTransactionStatus,
                  (route) => route.isFirst,
                  arguments: MfTransactionStatusArgs(
                    transactionType: transactionType,
                    isAssistedService:
                        transactionType == MFTransactionTypes.assistedService,
                    transactionStatus: MfTransactionStatus.success,
                  ),
                );
              }
              return NavigationDecision.prevent;
            }
            if (navigationRequest.url
                .contains('custom://neosurgeapp.com/failure')) {
              logDebugFinest(_h, 'MF Payment Failed');

              if (transactionType == MFTransactionTypes.basket) {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.buyBasketStatus,
                  arguments: BasketTransactionStatus.failed,
                );
              } else if (transactionType == MFTransactionTypes.cart) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.statusCartTrasaction,
                  ModalRoute.withName(Routes.mutualFunds),
                  arguments: MfTransactionStatus.failure,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.mfTransactionStatus,
                  (route) => route.isFirst,
                  arguments: MfTransactionStatusArgs(
                    transactionType: transactionType,
                    isAssistedService:
                        transactionType == MFTransactionTypes.assistedService,
                    transactionStatus: MfTransactionStatus.failure,
                  ),
                );
              }

              return NavigationDecision.prevent;
            }

            if (navigationRequest.url
                .contains('custom://neosurgeapp.com/pending')) {
              if (transactionType == MFTransactionTypes.basket) {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.buyBasketStatus,
                  arguments: BasketTransactionStatus.pending,
                );
              } else if (transactionType == MFTransactionTypes.cart) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.statusCartTrasaction,
                  ModalRoute.withName(Routes.mutualFunds),
                  arguments: MfTransactionStatus.pending,
                );
              } else {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.mfTransactionStatus,
                  arguments: MfTransactionStatusArgs(
                    transactionType: transactionType,
                    isAssistedService:
                        transactionType == MFTransactionTypes.assistedService,
                    transactionStatus: MfTransactionStatus.pending,
                  ),
                );
              }

              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onProgress: (int progress) {
            // urlProgress.value = progress / 100;
          },
          onPageStarted: (String url) {
            logDebugFinest(_h, 'onPageStarted: $url');
            // urlProgress.value = 0;
          },
          onPageFinished: (String url) {
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

    return WillPopScope(
      onWillPop: () async {
        final res = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to cancel this transaction?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });
        return res ?? false;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
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
        ),
      ),
    );
  }
}
