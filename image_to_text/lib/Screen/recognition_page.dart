import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_to_text/utils/image_cropper_page.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);
    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recognized page")),
      body: _isBusy == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: 800,
              width: 400,
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: controller,
                maxLines: null,
                expands: true,
                decoration:
                    const InputDecoration(hintText: "Text goers here...."),
              ),
            ),
    );
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    setState(() {
      _isBusy = true;
    });
    log("FUCKKKKKKKKKK");
    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    controller.text = recognizedText.text;
    setState(() {
      _isBusy = false;
    });
  }
}
