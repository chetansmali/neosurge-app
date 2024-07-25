import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'emandate_timer_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../../data/models/user/user_bank_details_model.dart';
import '../../../../data/models/user/user_mandate_details_model.dart';
import '../../../../flavors.dart';
import '../../../../logger.dart';
import '../../../cubits/mutual_funds/mandate_token_cubit/authorise_mandate_cubit.dart';
import '../../../routes/route_arguments.dart';
import '../../../routes/routes.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/custom_loader.dart';

const _h = 'authorise_mandate_webview';

class AuthoriseMandateWebView extends HookWidget {
  final UserMandate mandate;
  final UserBank bank;

  const AuthoriseMandateWebView(
      {Key? key, required this.mandate, required this.bank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urlProgress = useState<double>(0);

    dynamic controller = WebViewController()
      ..setUserAgent(
          'Mozilla/5.0 (Linux; Android 10; Pixel 4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Mobile Safari/537.36')
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest navigationRequest) {
            final url = navigationRequest.url;
            if (url.contains('custom://neosurgeapp.com/success')) {
              _refreshMandate(context);
              return NavigationDecision.prevent;
            }
            if (url.contains('custom://neosurgeapp.com/failure')) {
              logDebugFinest(_h, 'Authorise Mandate Failed');
              _refreshMandate(context, isFailed: true);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onProgress: (int progress) {
            logDebugFinest(_h, 'onProgress: $progress');
            // urlProgress.value = progress / 100;
          },
          onPageStarted: (String url) {
            logDebugFinest(_h, 'onPageStarted: $url');
            // urlProgress.value = 0;
          },
          onPageFinished: (String url) {
            logDebugFinest(_h, 'onPageFinished: $url');

            // Since in DEV auto redirect is not happening
            if (url.contains('status=S') && F.appFlavor == Flavor.DEV) {
              _refreshMandate(context);
            } else if ((url.contains('status=F') || url.contains('status=M')) &&
                F.appFlavor == Flavor.DEV) {
              _refreshMandate(context, isFailed: true);
            }
          },
          onWebResourceError: (WebResourceError error) {
            logError(_h, 'WebResourceError : ${error.description}');
          },
        ),
      );

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
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<AuthoriseMandateCubit, AuthoriseMandateState>(
          listener: (_, authoriseState) async {
            if (authoriseState is AuthoriseMandateLoaded) {
              if (authoriseState.mandate.tokenUrl == null) {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmandateTimerScreen()));
                context
                    .read<AuthoriseMandateCubit>()
                    .refreshMandate(mandateId: mandate.mandateId);
              }
            }
          },
          builder: (_, state) {
            if (state is AuthoriseMandateLoading) {
              return const Center(
                child: CustomLoader(),
              );
            }
            if (state is AuthoriseMandateLoadError) {
              return Center(
                child: AppErrorWidget(
                  error: state.errorMessage,
                  errorType: state.errorType,
                  onRetry: () => context
                      .read<AuthoriseMandateCubit>()
                      .refreshMandate(mandateId: mandate.mandateId),
                ),
              );
            }
            if (state is AuthoriseMandateLoaded) {
              if (state.mandate.tokenUrl == null) return const SizedBox();
              controller.loadRequest(Uri.parse(state.mandate.tokenUrl ?? ""));
              return SafeArea(
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
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _refreshMandate(BuildContext context, {bool isFailed = false}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.autoMandateStatus,
      (route) => route.settings.name == Routes.bankDetails,
      arguments: AutoMandateStatusArgs(
        bank: bank,
        mandate: mandate,
        isCreate: false,
        isFailed: isFailed,
      ),
    );
  }
}
