import 'dart:async';
import 'dart:html' as html;

import 'package:kakao_flutter_sdk_common/src/kakao_sdk.dart';
import 'package:kakao_flutter_sdk_common/src/web/utility.dart';

Future<String> handleAppsApi(
  final String transId,
  final String requestUrl,
  final String popupTitle,
) {
  final url = 'https://${KakaoSdk.hosts.apps}';
  final iframe = createHiddenIframe(transId, '$url/proxy?trans_id=$transId');
  html.document.body?.append(iframe);

  final completer = Completer<String>();

  addMessageEventListener(url, completer, () => iframe.remove());

  windowOpen(
    requestUrl,
    popupTitle,
    features:
        'location=no,resizable=no,status=no,scrollbars=no,width=460,height=608',
  );
  return completer.future;
}

html.WindowBase windowOpen(String url, String name, {String? features}) {
  return html.window.open(url, name, features);
}