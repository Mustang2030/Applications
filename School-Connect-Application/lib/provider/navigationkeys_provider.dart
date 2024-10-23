import 'package:flutter/material.dart';

class NavigationkeysProvider extends ChangeNotifier {
  String? _key;

  String? get key => _key;

  void setKey(String key) {
    _key = key;
    notifyListeners();
  }
}
