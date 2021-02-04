import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan the Code'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white.withOpacity(.9),
                  padding:
                      EdgeInsets.symmetric(horizontal: 36.0, vertical: 24.0),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: scanBarcode,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.qr_code_scanner_outlined,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Scan Here',
                      )
                    ]),
              ),
            ],
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
          //   child:
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text(
              'CODE: $barcode',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Future scanBarcode() async {
    try {
      String barcodeScanned = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcodeScanned;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'Camera Permission Denied';
        });
      } else {
        setState(() {
          this.barcode = 'Unknown error: $e';
        });
      }
    } on FormatException {
      setState(() {
        this.barcode =
            'null (User returned using the "back" - button before scaning anything, Result)';
      });
    } catch (e) {
      setState(() {
        this.barcode = 'Unknown error: $e';
      });
    }
  }
}
