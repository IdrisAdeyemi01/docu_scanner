import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const myImageView = "myImageView";

class ImageView extends StatefulWidget {
  const ImageView({super.key, required this.text});
  final String text;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final Map<String, dynamic> creationParams = {};
  late Key _key;

  @override
  void initState() {
    _key = UniqueKey();
    creationParams["text"] = widget.text;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ImageView oldWidget) {
    if (oldWidget.text != widget.text) {
      creationParams["text"] = widget.text;
      _key = UniqueKey();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AndroidView(
            viewType: myImageView,
            key: _key,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          )
        : UiKitView(
            viewType: myImageView,
            key: _key,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          );
  }
}
