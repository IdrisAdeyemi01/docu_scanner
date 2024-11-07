import 'package:docu_scanner/src/shared_widgets/image_view.dart';
import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({super.key, required this.imageString});

  final String imageString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Display"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: ImageView(
          text: imageString,
        ),
      ),
    );
  }
}
