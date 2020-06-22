import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tutorial_app_wk1/src/lib/image.dart';
import 'package:tutorial_app_wk1/src/lib/misc.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';
import 'package:tutorial_app_wk1/src/store/modules/gallery.dart';

class _ImageGridItem extends StatefulWidget {
  final String imagePath;
  _ImageGridItem({@required this.imagePath});

  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

enum _ImageLoadProgress { None, Pending, Success }

class _ImageGridItemState extends State<_ImageGridItem> {
  _ImageLoadProgress progress;
  Uint8List imageByteData;

  static final _progressAnimationColor =
      AlwaysStoppedAnimation<Color>(Colors.black.withAlpha(0x20));
  static final _backgroundColor = Colors.black.withAlpha((0x08));
  static const _thumbnailWidth = 256;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    switch (progress) {
      case _ImageLoadProgress.Success:
        return FittedBox(fit: BoxFit.cover, child: Image.memory(imageByteData));
      case _ImageLoadProgress.None:
      case _ImageLoadProgress.Pending:
      default:
        return Container(
            decoration: BoxDecoration(color: _backgroundColor),
            child: Center(
                child: SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: _progressAnimationColor,
                    ))));
    }
  }

  void _setProgress(_ImageLoadProgress _progress) {
    setState(() {
      progress = _progress;
    });
  }

  void _setByteData(Uint8List byteData) {
    setState(() {
      imageByteData = byteData;
    });
  }

  Future<void> _load() async {
    _setProgress(_ImageLoadProgress.Pending);
    await loadThumbnail(widget.imagePath, _thumbnailWidth).then((thumbnail) {
      _setByteData(thumbnail);
      _setProgress(_ImageLoadProgress.Success);
    });
  }
}

class _ImageGrid extends StatelessWidget {
  final FetchState imagePathsFetchState;
  final List<String> imagePaths;
  final Function retireveImagePaths;
  _ImageGrid(
      {@required this.imagePathsFetchState,
      @required this.imagePaths,
      @required this.retireveImagePaths});

  @override
  Widget build(BuildContext context) {
    switch (imagePathsFetchState) {
      case FetchState.Pending:
        return Center(child: CircularProgressIndicator());
      case FetchState.Success:
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(slivers: <Widget>[
              SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120.0,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                      (context, idx) =>
                          _ImageGridItem(imagePath: imagePaths[idx]),
                      childCount: imagePaths.length))
            ]));
      case FetchState.None:
      default:
        return Center(
            child: FlatButton(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.sync,
                size: 64,
                color: Colors.black26,
              ),
              Text('갤러리 불러오기', style: const TextStyle(color: Colors.black26))
            ],
          ),
          splashColor: Colors.transparent,
          onPressed: retireveImagePaths,
        ));
    }
  }
}

class _GalleryProps {
  final FetchState imagePathsFetchState;
  final List<String> imagePaths;
  final Function retrieveImagePaths;
  _GalleryProps(
      {@required this.imagePathsFetchState,
      @required this.imagePaths,
      @required this.retrieveImagePaths});
}

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      StoreConnector<RootState, _GalleryProps>(
          converter: (store) => _GalleryProps(
              imagePathsFetchState: store.state.gallery.galleryFetchState,
              imagePaths: store.state.gallery.imagePaths,
              retrieveImagePaths: () =>
                  store.dispatch(retrieveGalleryImagePaths())),
          builder: (context, props) => _ImageGrid(
              imagePathsFetchState: props.imagePathsFetchState,
              imagePaths: props.imagePaths,
              retireveImagePaths: props.retrieveImagePaths));
}
