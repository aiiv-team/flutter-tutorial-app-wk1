import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';

Future<Uint8List> loadImage(String path) => File(path).readAsBytes();

Future<Uint8List> loadThumbnail(Map<String, dynamic> args) =>
    File(args['imagePath'])
        .readAsBytes()
        .then((imageByteData) => decodeImage(imageByteData))
        .then((rawImage) => encodePng(copyResize(rawImage,
            width: args['thumbnailWidth'],
            interpolation: Interpolation.linear)))
        .then((pngIntData) => Uint8List.fromList(pngIntData));
