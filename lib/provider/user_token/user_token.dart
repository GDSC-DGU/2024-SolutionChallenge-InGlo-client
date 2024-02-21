import 'package:flutter/material.dart';

// access_token
class UserToken with ChangeNotifier {
  String? _token = null; // null일수도

  // token 얻기
  String? get token => _token; // null 값도 가능

  void setToken(String new_token) {
    _token = new_token; // token 업데이트
    notifyListeners();
  }
}