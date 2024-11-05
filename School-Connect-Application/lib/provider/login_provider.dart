import 'package:flutter/material.dart';
import 'package:scs/provider/user.dart';

// Keys passes and set onto other pages when needed
class LoginProvider extends ChangeNotifier {
  User? _user;
  String? _token;
  String? _key;
  String? _annkey;
  String? _role;
  String? _tgO;
  String? _lerId;
  String? _maintId;
  String? _classes;

  User? get user => _user;
  String? get token => _token;
  String? get key => _key;
  String? get annkey => _annkey;
  String? get role => _role;
  String? get tgo => _tgO;
  String? get lerId => _lerId;
  String? get maintId => _maintId;
  String? get classes => _classes;

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

  void loggedRole(String role) {
    _role = role;
    notifyListeners();
  }

  void principalGradeOverview(String tgO) {
    _tgO = tgO;
    notifyListeners();
  }

  void leanr(String lerId) {
    _lerId = lerId;
    notifyListeners();
  }

  void mainTid(String maintId) {
    _maintId = maintId;
    notifyListeners();
  }

  void classeslist(String classes) {
    _classes = classes;
    notifyListeners();
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}
