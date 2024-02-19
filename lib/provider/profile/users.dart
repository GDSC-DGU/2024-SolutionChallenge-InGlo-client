import 'package:flutter/material.dart';
import 'package:inglo/models/profile/user.dart';

class UserProvider with ChangeNotifier {
  User? _user; // User 객체를 nullable로 선언

  UserProvider([this._user]); // 선택적 위치 매개변수를 사용하여 초기값을 null로 허용

  User? get user => _user;

  // 전부 업데이트 하는 메서드
  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners();
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
        percent: _user!.percent,
        created_at: _user!.created_at,
      );
      notifyListeners();
    }
  }
}
