import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tutorial_app_wk1/src/lib/misc.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';
import 'package:tutorial_app_wk1/src/store/modules/gallery.dart';

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
        return Center(child: Text('${imagePaths.length}'));
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
