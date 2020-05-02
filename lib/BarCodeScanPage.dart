import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class BarCodeScanPage extends StatefulWidget {
  BarCodeScanPage({Key key}) : super(key: key);

  @override
  _BarCodeScanPageState createState() => _BarCodeScanPageState();
}

class _BarCodeScanPageState extends State<BarCodeScanPage> {

  String content = '';

  scan() async {
    var options = ScanOptions();

    ScanResult result = await BarcodeScanner.scan(options: options);
    print(result.type);
    print(result.rawContent);
    setState(() {
      content = result.rawContent;
    });
    String url = result.rawContent;
    RegExp reg = RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+");
    if(reg.firstMatch(content) != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return WebviewScaffold(
            appBar: AppBar(
              title: Text(url),
            ),
            url: url,
          );
        }
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BarCodeScanDemo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              scan();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('识别二维码结果：$content'),
      ),
    );
  }
}