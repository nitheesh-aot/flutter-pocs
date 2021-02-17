import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ML QR Scan',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String qr;
  bool camState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Scan ML')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: camState
                ? Container(
                    padding: EdgeInsets.all(42.0),
                    child: QrCamera(
                      onError: (context, error) => Text(
                        error.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      qrCodeCallback: qrCode,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: Colors.orange,
                              width: 8.0,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'Camera Inactive',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(21.0),
            child: Text(
              'CODE: $qr',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          'Press Me',
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          setState(() {
            camState = !camState;
          });
        },
      ),
    );
  }

  Future<void> qrCode(code) {
    setState(() {
      this.qr = code;
    });
  }
}
