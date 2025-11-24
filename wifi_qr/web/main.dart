import 'package:web/web.dart' as web;
import 'dart:js_interop';

// qrcode.jsの型定義
@JS()
external void generateWifiQR(String text);


// エントリーポイント
void main() {
  // ボタンを取得
  final btn = web.document.querySelector('#btn') as web.HTMLButtonElement?;

  // ボタンクリックイベントの監視
  btn?.addEventListener('click', ((web.Event event) {
    generateQR();
  }).toJS,);
}

// QRコード生成関数
void generateQR() {
  // SSID
  final ssid =
      (web.document.querySelector('#ssid') as web.HTMLInputElement?)?.value ??
          '';
  // パスワード
  final pass =
      (web.document.querySelector('#pass') as web.HTMLInputElement?)?.value ??
          '';
  // セキュリティタイプ
  final selectedType =
      (web.document.querySelector('#type') as web.HTMLSelectElement?)?.value;

  final type = (selectedType == null || selectedType.isEmpty)
      ? 'WPA'
      : selectedType;
  // WIFI接続情報のフォーマット
  final wifiString = 'WIFI:T:$type;S:$ssid;P:$pass;;';

  generateWifiQR(wifiString);

}