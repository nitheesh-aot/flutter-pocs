import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _scanCode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Barcode Scanner 2'),
        ),
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(24.0),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 42.0, vertical: 24.0),
                    ),
                    onPressed: scanQR,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code_scanner),
                        Text(
                          'Scan QR Code',
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 42.0, vertical: 24.0),
                    ),
                    onPressed: scanBarcode,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.line_style),
                        Text(
                          'Scan Barcode',
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                child: Text(
                  'Scanned Result: $_scanCode',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanQR() async {
    String scannedQR;
    try {
      scannedQR = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel Scan', true, ScanMode.QR);
      print(scannedQR);
    } on PlatformException {
      scannedQR = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      this._scanCode = scannedQR;
    });
  }

  Future<void> scanBarcode() async {
    String scannedBarcode;
    try {
      scannedBarcode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel Scan', true, ScanMode.BARCODE);
      print(scannedBarcode);
    } on PlatformException {
      scannedBarcode = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      this._scanCode = scannedBarcode;
    });
  }
}
