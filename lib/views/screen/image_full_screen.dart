import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageFullScreen extends StatefulWidget {
  String imgPath;
  ImageFullScreen({super.key, required this.imgPath});

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.network(widget.imgPath),
      ),
    );
  }
}
