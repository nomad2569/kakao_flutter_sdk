import 'dart:async';
import 'dart:js_interop';
import 'package:web/web.dart' as web;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

String androidNaviIntent(String scheme, String queries) {
  var url = '$scheme?$queries';

  final intent = [
    'intent:$url#Intent',
    'package=${KakaoSdk.platforms.web.kakaoNaviOrigin}',
    'S.browser_fallback_url=${Uri.encodeComponent('${KakaoSdk.platforms.web.kakaoNaviInstallPage}?$queries')}',
    'end;'
  ].join(';');
  return intent;
}

Timer deferredFallback(String storeUrl, Function(String) fallback) {
  int timeout = 5000;

  return Timer(Duration(milliseconds: timeout), () {
    fallback(storeUrl);
  });
}

void bindPageHideEvent(Timer timer) {
  EventListener? listener;

  listener = (event) {
    if (!_isPageVisible()) {
      timer.cancel();

      JSFunction jsListener = listener!.jsify() as JSFunction;
      web.window.removeEventListener('pagehide', jsListener);
      web.window.removeEventListener('visibilitychange', jsListener);
    }
  };

  JSFunction jsListener = listener!.jsify() as JSFunction;

  web.window.addEventListener('pagehide', jsListener);
  web.window.addEventListener('visibilitychange', jsListener);
}

bool _isPageVisible() {
  return !web.document.hidden;
}
