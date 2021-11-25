// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:atyrau_hub_hackaton/features/info/auto.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class DetailScreen extends StatefulWidget {
  final String imagePath;

  const DetailScreen({required this.imagePath});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final String _imagePath;
  late final TextDetector _textDetector;
  Size? _imageSize;
  List<TextElement> _elements = [];

  List<String>? _listEmailStrings;

  // Fetching the image size from the image file
  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    final Image image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  // To detect the email addresses present in an image
  void _recognizeEmails() async {
    _getImageSize(File(_imagePath));

    // Creating an InputImage object using the image path
    final inputImage = InputImage.fromFilePath(_imagePath);
    // Retrieving the RecognisedText from the InputImage
    final text = await _textDetector.processImage(inputImage);

    // Pattern of RegExp for matching a general email address
    // String pattern =
    //     r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    // RegExp regEx = RegExp(pattern);

    List<String> carStrings = [];

    // Finding and storing the text String(s) and the TextElement(s)
    for (TextBlock block in text.blocks) {
      for (TextLine line in block.lines) {
        print('text: ${line.text}');
        // if (regEx.hasMatch(line.lineText)) {
        //   carStrings.add(line.lineText);
        //   for (TextElement element in line.textElements) {
        //     _elements.add(element);
        //   }
        // }
          carStrings.add(line.text);
          for(TextElement element in line.elements){
            _elements.add(element);
          }

      }
    }

    setState(() {
      _listEmailStrings = carStrings;
    });
  }

  @override
  void initState() {
    _imagePath = widget.imagePath;
    // Initializing the text detector
    _textDetector = GoogleMlKit.vision.textDetector();
    try {
      _recognizeEmails();
    } catch(e) {
      print('Errors: $e');
    }
    super.initState();
  }

  @override
  void dispose() {
    // Disposing the text detector when not used anymore
    _textDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Распознавание'),
      ),
      body: _imageSize != null
          ? Stack(
        children: [
          Container(
            width: double.maxFinite,
            color: Colors.black,
            child: CustomPaint(
              foregroundPainter: TextDetectorPainter(
                _imageSize!,
                _elements,
              ),
              child: AspectRatio(
                aspectRatio: _imageSize!.aspectRatio,
                child: Image.file(
                  File(_imagePath),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 80.0,
            child: Card(
              elevation: 16,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Информация о машине',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _listEmailStrings != null
                                ? ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: _listEmailStrings!.length,
                              itemBuilder: (context, index) =>
                                  Text(_listEmailStrings![index], style: TextStyle(fontSize: 20.0,),),
                            )
                                : Container(),
                            SizedBox(height: 8.0,),
                            Forms(context: context,name: 'Заявитель',data: 'Валерий Большаков'),
                            Forms(context: context,name: 'Государственный номер',data: '999AAA02'),
                            Forms(context: context,name: 'Марка транспорта',data: 'AVC MARK'),
                            Forms(context: context,name: 'Компания заявитель',data: 'My company'),
                            Forms(context: context,name: 'Зарегистрированный владелец',data: 'Арман Аманжолов'),
                            Forms(context: context,name: 'Ранее регистрирован',data: 'Нет'),
                            Forms(context: context,name: 'Дата подачи',data: '11/22/2021'),
                            Forms(context: context,name: 'Дата въезда',data: '11/24/2021'),
                            Forms(context: context,name: 'Категория транспорта',data: 'Социальный автомобиль'),
                            Forms(context: context,name: 'Модель транспорта',data: 'Модель 1'),
                            Forms(context: context,name: 'Год выпуска',data: '2000'),
                            Forms(context: context,name: 'Страна изготовитель',data: 'Россия'),
                            Forms(context: context,name: 'Сборочный завод',data: 'Водный завод'),
                            Forms(context: context,name: 'Сторона движения',data: 'Left'),
                          ],
                        ),


                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
          : Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

// Helps in painting the bounding boxes around the recognized
// email addresses in the picture
class TextDetectorPainter extends CustomPainter {
  TextDetectorPainter(this.absoluteImageSize, this.elements);

  final Size absoluteImageSize;
  final List<TextElement> elements;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(TextElement container) {
      return Rect.fromLTRB(
        container.rect.left * scaleX,
        container.rect.top * scaleY,
        container.rect.right * scaleX,
        container.rect.bottom * scaleY,
      );
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 2.0;

    for (TextElement element in elements) {
      canvas.drawRect(scaleRect(element), paint);
    }
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return true;
  }
}
