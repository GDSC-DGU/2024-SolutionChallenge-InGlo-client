import 'package:flutter/material.dart';

// access_token
class PostSDGS with ChangeNotifier {
  int? _sdgs;
  int? _sketch_id;

  // token 얻기
  int? get sdgs => _sdgs; // null 값도 가능
  int? get sketch_id => _sketch_id; // null 값도 가능

  void setSDGS(int new_sdgs) {
    _sdgs = new_sdgs; // token 업데이트
    notifyListeners();
  }

  void setSketch(int new_sketch) {
    _sketch_id = new_sketch; // token 업데이트
    notifyListeners();
  }
}