import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:lottie/lottie.dart';

// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../theme/palette.dart';

// #enddocregion platform_imports

class FundingTime extends StatefulWidget {
  FundingTime({super.key, required this.symbol, this.isSmall = false});
  final String symbol;
  final bool isSmall;

  @override
  State<FundingTime> createState() => _FundingTimeState();
}

class _FundingTimeState extends State<FundingTime> {
  WebViewController? _controller;
  int websiteProgress = 0;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              websiteProgress = progress;
            });
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');

            if (_controller != null) {
              _controller!.runJavaScript(
                  'document.querySelector("header").style.display="none";');
              _controller!.runJavaScript("""
              setTimeout(function() {
                  console.log('Chuẩn bị load FundingTime');
                 

                  var fundingTime = document.querySelector('.css-r7e7ok');
                  if (fundingTime) {
                      document.body.innerHTML = '';
                      document.body.appendChild(fundingTime);
                      document.body.style.margin = '0';
                      document.body.style.overflow = 'hidden';
                      fundingTime.style.width = '100%';
                      fundingTime.style.height = 'auto';
                      // Set background color
                      document.body.style.backgroundColor = '#1F2630';
                      console.log('fundingTime element found');
                      Toaster.postMessage('done');
                  } else {
                      console.error('fundingTime element not found');
                      Toaster.postMessage('done');
                  }
              }, 3000); // Tăng thời gian chờ lên 5000 milliseconds (5 giây)
          """);
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          if (message.message == 'done') {
            setState(() {
              isLoading = false;
            });
          }
        },
      )
      ..loadRequest(
          Uri.parse('https://www.binance.com/vi/futures/${widget.symbol}'));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: _controller!),
          isLoading
              ? Positioned.fill(
                  child: Visibility(
                    visible: isLoading,
                    child: Container(
                      color: palette.cardColor,
                      child: Lottie.asset(
                        "assets/icons/loading.json",
                        frameRate: FrameRate.max,
                        repeat: true,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
