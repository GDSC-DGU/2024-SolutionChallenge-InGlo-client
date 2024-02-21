import 'package:flutter/material.dart';
import 'package:inglo/models/profile/user.dart';

class UserProvider with ChangeNotifier {
  User? _user; // User 객체를 nullable로 선언

  UserProvider([this._user]); // 선택적 위치 매개변수를 사용하여 초기값을 null로 허용

  User? get user => _user;

  int get user_id => _user!.id;
  String get user_profile_img => _user!.profile_img;

  // 전부 업데이트 하는 메서드
  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  // 개별적으로 전부 업데이트 하는 메서드2
  void updateUserPersonal({int? id, String? email, String? profile_img, int? country, String? language, int? liked_total, int? sketch_num, int? feedback_total, int? post_total, double? global_impact}) {
    if (_user != null) {
      _user = User(
        id: id ?? _user!.id,
        email: email ?? _user!.email,
        name: _user!.name,
        profile_img: profile_img ?? _user!.profile_img,
        country: country ?? _user!.country,
        language: language ?? _user!.language,
        liked_total: liked_total ?? _user!.liked_total,
        sketch_num: sketch_num ?? _user!.sketch_num,
        feedback_total: feedback_total ?? _user!.feedback_total,
        post_total: post_total ?? _user!.post_total,
        global_impact: global_impact ?? _user!.global_impact,
      );
      notifyListeners();
    }
  }

  // 특정 필드만 업데이트하는 메서드
  void updateUserFields({String? name, int? country, String? language}) {
    if (_user != null) {
      _user = User(
        id: _user!.id,
        email: _user!.email,
        name: name ?? _user!.name,
        profile_img: _user!.profile_img,
        country: country ?? _user!.country,
        language: language ?? _user!.language,
        liked_total: _user!.liked_total,
        sketch_num: _user!.sketch_num,
        feedback_total: _user!.feedback_total,
        post_total: _user!.post_total,
        global_impact: _user!.global_impact,
      );
      notifyListeners();
    }
  }
}
