import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

class Action {
  final String type;

  Action({
    @required this.type,
  });
}

class RootState {
  RootState();
}

RootState _combinedReducer(RootState state, action) => new RootState();

Store<RootState> getStore() => new Store<RootState>(_combinedReducer,
    initialState: RootState(), middleware: []);
