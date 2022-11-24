import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_to_text/utils/image_cropper_page.dart';
import 'package:image_to_text/utils/image_picker_class.dart';

import 'Screen/recognition_page.dart';
import 'Widgets/model_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Fluck you Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Click below button',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          imagePickerModal(
            context,
            onCameraTap: () {
              log('Camera clicked  ');
              pickImage(source: ImageSource.camera).then((value) {
                if (value != '') {
                  imageCropperView(value, context).then(
                    (value) {
                      if (value != '') {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => RecognizePage(
                              path: value,
                            ),
                          ),
                        );
                      }
                    },
                  );
                }
              });
            },
            onGalleryTap: () {
              log('Gallery CLicked ');
              pickImage(source: ImageSource.gallery).then((value) {
                if (value != '') {
                  imageCropperView(value, context).then((value) {
                    if (value != '') {
                      imageCropperView(value, context).then(
                        (value) {
                          if (value != '') {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => RecognizePage(
                                  path: value,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                  });
                }
              });
            },
          );
        },
        tooltip: 'Increment',
        label: const Text("Scan Photo"),
      ),
    );
  }
}
