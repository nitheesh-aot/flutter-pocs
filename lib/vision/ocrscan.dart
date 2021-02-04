import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:simple_ocr_plugin/simple_ocr_plugin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple OCR Plugin',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PickedFile _pickedImageFile;
  File _imageFile;
  TextEditingController _regTextCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _regTextCtrl.text = 'here would display the results recognized by OCR';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OCR Example'),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(16.0),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: _showImagePicker,
                child: Text('Get Image'),
              ),
            ),
            Container(
              child: (_imageFile != null)
                  ? SizedBox(
                      width: 200,
                      height: 200,
                      child: Container(
                        color: Colors.grey[300],
                        child: (_imageFile != null)
                            ? Image.file(
                                _imageFile,
                                fit: BoxFit.contain,
                              )
                            : null,
                      ),
                    )
                  : null,
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: _performOCR,
                child: Text('Perform OCR'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('OCR Data'),
            ),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 18.0),
              shrinkWrap: true,
              children: [
                TextField(
                  controller: _regTextCtrl,
                  enabled: false,
                  minLines: 5,
                  maxLines: 1000,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showImagePicker() async {
    this._pickedImageFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    if (this._pickedImageFile == null) {
      return;
    }

    this._imageFile = File(_pickedImageFile.path);
    setState(() {
      // update UI
    });

    var _result = await GallerySaver.saveImage(this._pickedImageFile.path);
    print("saved at ${this._pickedImageFile.path} with result: $_result");
  }

  _performOCR() async {
    if (this._pickedImageFile != null && this._pickedImageFile.path != '') {
      try {
        String _resultString =
            await SimpleOcrPlugin.performOCR(this._pickedImageFile.path);
        print('Result: $_resultString');
        setState(() {
          this._regTextCtrl.text = _resultString;
        });
      } catch (e) {
        setState(() {
          _regTextCtrl.text =
              "error in recognizing the image / photo => ${e.toString()}";
        });
      }
    }
  }
}
