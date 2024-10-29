import 'package:flutter/material.dart';
import 'package:scs/provider/user.dart';

class LoginProvider extends ChangeNotifier {
  User? _user;
  String? _token;
  String? _key;
  String? _annkey;
  String? _role;

  User? get user => _user;
  String? get token => _token;
  String? get key => _key;
  String? get annkey => _annkey;
  String? get role => _role;

  bool get isLoggedIn => _user != null;

  void setUser(User user, String token) {
    _user = user;
    _token = token;
    notifyListeners();
  }

  void passKey(String key) {
    _key = key;
    notifyListeners();
  }

  void annKey(String annkey) {
    _annkey = annkey;
    notifyListeners();
  }

  void loggedRole(String annkey) {
    _role = role;
    notifyListeners();
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}
