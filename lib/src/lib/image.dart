import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';

Future<Uint8List> loadThumbnail(String imagePath, int thumbnailWidth) =>
    File(imagePath)
        .readAsBytes()
        .then((imageByteData) => decodeImage(imageByteData))
        .then((rawImage) => encodePng(copyResize(rawImage,
            width: thumbnailWidth, interpolation: Interpolation.linear)))
        .then((pngIntData) => Uint8List.fromList(pngIntData));
