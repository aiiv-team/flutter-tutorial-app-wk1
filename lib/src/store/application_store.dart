import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:tutorial_app_wk1/src/store/modules/gallery.dart';
import 'package:tutorial_app_wk1/src/store/modules/profile.dart';

class RootState {
  final ProfileState profile;
  final GalleryState gallery;

  RootState({@required this.profile, @required this.gallery});
}

RootState _combinedReducer(RootState state, action) => new RootState(
    profile: contactReducer(state.profile, action),
    gallery: galleryReducer(state.gallery, action));

Store<RootState> getStore() => new Store<RootState>(_combinedReducer,
    initialState:
        RootState(profile: initialProfileState, gallery: initialGalleryState),
    middleware: [thunkMiddleware]);
