import 'package:flutter/material.dart';

class MiProvider extends ChangeNotifier {
  bool _myState = false;

  bool get myState => _myState;

  void refreshWidgetState(bool newState) {
    _myState = newState;
    notifyListeners();
  }
}
