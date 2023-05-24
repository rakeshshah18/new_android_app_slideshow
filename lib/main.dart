import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: SlideshowWidget(),
        ),
      ),
    );
  }
}

class SlideshowWidget extends StatefulWidget {
  const SlideshowWidget({Key? key}) : super(key: key);

  @override
  SlideshowWidgetState createState() => SlideshowWidgetState();
}

class SlideshowWidgetState extends State<SlideshowWidget> {
  int currentIndex = 0;
  List<SlideshowImage> images = [
    SlideshowImage("assets/hd4.jpeg", const Duration(seconds: 5)),
    SlideshowImage("assets/hd5.jpeg", const Duration(seconds: 3)),
    SlideshowImage("assets/hd6.jpeg", const Duration(seconds: 8)),
    // Add more images as needed
  ];
  late Timer timer;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentImage = images[currentIndex];
    final currentDuration = currentImage.duration;
    timer.cancel();
    timer = Timer(currentDuration, () {
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
      startTimer();
    });

    return Image.asset(currentImage.path);
  }
}

class SlideshowImage {
  final String path;
  final Duration duration;

  SlideshowImage(this.path, this.duration);
}