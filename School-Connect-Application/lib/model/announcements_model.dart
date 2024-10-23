import 'package:flutter/material.dart';

class AnnouncementsModel extends ChangeNotifier {
  String _content = '', _title = '';

  get getContent => _content;
  set setContent(String contentBody) {
    _content = contentBody;
    notifyListeners();
  }

  get getTitle => _title;
  set setTitle(String title) {
    _title = title;
    notifyListeners();
  }
}
