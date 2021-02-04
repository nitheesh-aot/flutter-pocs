import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'scan.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Scanner',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: ScanScreen(),
    );
  }
}
