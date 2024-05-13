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

class TradingOrderBookScreen extends StatefulWidget {
  const TradingOrderBookScreen({
    super.key,
    required this.symbol,
    this.isSmall = false,
  });
  final String symbol;
  final bool isSmall;

  @override
  State<TradingOrderBookScreen> createState() => _TradingOrderBookScreenState();
}

class _TradingOrderBookScreenState extends State<TradingOrderBookScreen> {
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
              _controller!.runJavaScript("""
              setTimeout(function() {
                  var tabOrderBook = document.getElementById('tab-order-book');
                  if (tabOrderBook) {
                      tabOrderBook.click(); // Click vào tab sổ lệnh
                      console.log('Clicked on tab-order-book');
                  } else {
                      console.error('tab-order-book element not found');
                  }

                  setTimeout(function() {
                      var futuresOrderbook = document.getElementById('futuresOrderbook');
                      if (futuresOrderbook) {
                          // Ẩn các phần tử header của sổ lệnh
                          var headers = document.querySelectorAll('.orderbook-header, .orderbook-tbheader');
                          headers.forEach(function(header) {
                              header.style.display = 'none';
                          });

                          // Thay thế nội dung hiện tại của body bằng futuresOrderbook
                          document.body.innerHTML = '';
                          document.body.appendChild(futuresOrderbook);
                          document.body.style.margin = '0';
                          document.body.style.overflow = 'hidden';
                          futuresOrderbook.style.width = '100%';
                          futuresOrderbook.style.height = '100vh'; // Đặt chiều cao bằng với viewport
                          console.log('futuresOrderbook element found and displayed');
                          Toaster.postMessage('done');
                      } else {
                          console.error('futuresOrderbook element not found');
                          Toaster.postMessage('done');
                      }
                  }, 1000); // Đợi 1 giây để đảm bảo tab sổ lệnh đã được tải
              }, 3000); // Đợi 3 giây để trang hoàn tất tải
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
