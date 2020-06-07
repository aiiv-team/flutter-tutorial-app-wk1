import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:tutorial_app_wk1/src/store/modules/profile.dart';

class RootState {
  final ProfileState profile;

  RootState({@required this.profile});
}

RootState _combinedReducer(RootState state, action) =>
    new RootState(profile: contactReducer(state.profile, action));

Store<RootState> getStore() => new Store<RootState>(_combinedReducer,
    initialState: RootState(profile: initialProfileState), middleware: []);
