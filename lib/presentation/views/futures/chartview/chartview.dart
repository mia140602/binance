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

class TradingChartScreen extends StatefulWidget {
  TradingChartScreen({super.key, required this.symbol, this.isSmall = false});
  final String symbol;
  final bool isSmall;

  @override
  State<TradingChartScreen> createState() => _TradingChartScreenState();
}

class _TradingChartScreenState extends State<TradingChartScreen> {
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
              if (widget.isSmall == true) {
                _controller!.runJavaScript("""
                  var observer = new MutationObserver(function(mutations) {
                    mutations.forEach(function(mutation) {
                      var klineContainer = document.querySelector('.kline-container');
                      if (klineContainer) {
                      klineContainer.style.transform = 'scale(1)'
                    klineContainer.style.transformOrigin = 'top left'; // Điều chỉnh gốc transform nếu cần
                    klineContainer.style.width = '100%'; // Đặt chiều rộng phần tử bằng 100%
                    klineContainer.style.height = '60%'; 
                    console.log('Kline container scaled down and adjusted');
                    observer.disconnect(); 
                      }
                    });
                  });

                  observer.observe(document.body, {
                    childList: true,
                    subtree: true
                  });
                """);
                _controller!.runJavaScript("""
              setTimeout(function() {
                  console.log('Chuẩn bị load Chart');
                  document.querySelectorAll('.chart-title-indicator-container').forEach(function (params) {
                      params.style.display = 'none';
                  });

                  var chart = document.querySelector('.kline-container');
                  if (chart) {
                      document.body.innerHTML = '';
                      document.body.appendChild(chart);
                      document.body.style.margin = '0';
                      document.body.style.overflow = 'hidden';
                      chart.style.width = '100%';
                      chart.style.height = 'auto';
                      console.log('Chart element found');
                      Toaster.postMessage('done');
                  } else {
                      console.error('Chart element not found');
                      Toaster.postMessage('done');
                  }
              }, 3000); // Tăng thời gian chờ lên 5000 milliseconds (5 giây)
          """);
              } else {
                _controller!.runJavaScript("""
                  var observer = new MutationObserver(function(mutations) {
                    mutations.forEach(function(mutation) {
                      var klineContainer = document.querySelector('.kline-container');
                      if (klineContainer) {
                      klineContainer.style.transform = 'scale(1)'
                    klineContainer.style.transformOrigin = 'top left'; // Điều chỉnh gốc transform nếu cần
                    klineContainer.style.width = '100%'; // Đặt chiều rộng phần tử bằng 100%
                    klineContainer.style.height = '80%'; 
                    console.log('Kline container scaled down and adjusted');
                    observer.disconnect(); 
                      }
                    });
                  });

                  observer.observe(document.body, {
                    childList: true,
                    subtree: true
                  });
                """);
                _controller!.runJavaScript("""
              setTimeout(function() {
                  console.log('Chuẩn bị load Chart');
                  document.querySelectorAll('.chart-title-indicator-container').forEach(function (params) {
                      params.style.display = 'none';
                  });

                  var chart = document.querySelector('.kline-container');
                  if (chart) {
                      document.body.innerHTML = '';
                      document.body.appendChild(chart);
                      document.body.style.margin = '0';
                      document.body.style.overflow = 'hidden';
                      chart.style.width = '100%';
                      chart.style.height = 'auto';
                      console.log('Chart element found');
                      Toaster.postMessage('done');
                  } else {
                      console.error('Chart element not found');
                      Toaster.postMessage('done');
                  }
              }, 3000); // Tăng thời gian chờ lên 5000 milliseconds (5 giây)
          """);
              }
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
