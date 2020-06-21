import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:tutorial_app_wk1/src/lib/misc.dart';
import 'package:tutorial_app_wk1/src/store/application_store.dart';

const String GALLERY_PATH = '/storage/emulated/0/DCIM';

class RequestGalleryAction {}

class RequestGalleryPermissionErrorAction {}

class SetGalleryPathsAction {
  final List<String> paths;
  SetGalleryPathsAction({@required this.paths});
}

class GalleryState {
  final FetchState galleryFetchState;
  final List<String> imagePaths;

  GalleryState({@required this.galleryFetchState, @required this.imagePaths});

  factory GalleryState.fromGalleryState(
      {@required GalleryState old,
      List<String> imagePaths,
      FetchState galleryFetchState}) {
    return GalleryState(
        imagePaths: imagePaths ?? old.imagePaths,
        galleryFetchState: galleryFetchState ?? old.galleryFetchState);
  }
}

ThunkAction<RootState> retrieveGalleryImagePaths() {
  return (Store<RootState> store) {
    final directory = Directory(GALLERY_PATH);
    final imagePaths = directory
        .listSync(recursive: true, followLinks: false)
        .map((file) => file.path)
        .toList();

    store.dispatch(SetGalleryPathsAction(paths: imagePaths));
  };
}

GalleryState galleryReducer(GalleryState state, action) {
  if (action is RequestGalleryAction) {
    return GalleryState.fromGalleryState(
        old: state, galleryFetchState: FetchState.Pending);
  }
  if (action is RequestGalleryPermissionErrorAction) {
    return GalleryState.fromGalleryState(
        old: state, galleryFetchState: FetchState.PermissionError);
  }
  if (action is SetGalleryPathsAction) {
    return GalleryState.fromGalleryState(
        old: state,
        galleryFetchState: FetchState.Success,
        imagePaths: action.paths);
  }

  return state;
}

GalleryState initialGalleryState =
    GalleryState(galleryFetchState: FetchState.None, imagePaths: []);
