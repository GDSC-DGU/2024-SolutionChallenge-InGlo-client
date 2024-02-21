// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';


/// The scopes required by this application.
// #docregion Initialize
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);
// #enddocregion Initialize

/// The SignInDemo app.
class SignInDemo extends StatefulWidget {
  ///
  const SignInDemo({super.key});

  @override
  State createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  final String access_token = 'ya29.a0AfB_byBkrYs7r3xZat1rrbTqFn-shoMhm6Sta9McvJFRS1hbjRKP3XdMf9Ox1OBpJw-VGufHkGrKdJGv3YHukAndD0zz7ybVH6CByYUsj4haXJZSxy8MmZTwFetpoAoRwGtj5eIJWKSbDWi0-yABw1exQEUBOhzk2AaCgYKAaESARASFQHGX2Mifxjj_1DqUnqQ01FJSTUMAg0169';

  final dio = Dio(); // dio instance 생성

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
// #docregion CanAccessScopes
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }
// #enddocregion CanAccessScopes

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      print('isAuthoried : $isAuthorized');

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    _googleSignIn.signInSilently();
  }

  // Calls the People API REST endpoint for the signed-in user to retrieve information.
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    print('user : ${user}');
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
            (dynamic name) =>
        (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  // google token 전송 api(500 출력 중)
  Future<void> PostApi(String _token) async {
    print('전송 토큰 $_token');

    final url = "https://dongkyeom.com/api/v1/accounts/loginsuccess/";
    Map<String, String> data = {
      "access_token": _token,
    };

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
    );

    try {
      final response = await dio.post(url, data: data, options: options);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 성공
        print(
            'Success code: ${response.statusCode}, response: ${response.data}');

        /*
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GetProfilePage()), // 다음 페이지로 이동
        );
*/
      } else {
        // 비-200 상태 코드
        print('Error api code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      // 예외 처리
      print('Exception caught: $e');
    }
  }

  /*
  Future<String?> PostApi(String _token) async {
    print('token :::: $_token');

    Dio dio = Dio();
    try {
      final response = await dio.post(
        'https://dongkyeom.com/api/v1/accounts/login-success/',
        data: {
          'access_token': _token,
        },
      );
      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print('Failed to get access token with status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('DioError: $e');
      return null;
    }
  }
*/
/*
  void IsCorrectToken(String _token) async {
    print('token : $_token');

    var dio = Dio();
    // access_token을 URL 쿼리 파라미터로 포함
    var url = 'https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=$_token';

    try {
      Response response = await dio.get(url);
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
    } on DioException catch (e) {
      if (e.response != null) {
        print('DioError:');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // 요청 관련 오류 처리
        print('Error sending request!');
        print(e.message);
      }
    }
  }
  */
  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  // #docregion SignIn
  /*
  Future<void> _handleSignIn() async {
    // _googleSignIn.currentUser?.clearAuthCache();
    // _googleSignIn.signInSilently();

    try {
      await _googleSignIn.signIn().then((result) {
        result?.authentication.then((googleKey) {
          print(googleKey.accessToken); // 토큰 출력
          print(_googleSignIn.currentUser?.displayName); // 유저 이름

          if (googleKey.accessToken != null) {
            print('token : ${googleKey.accessToken}');
            // _handlePostGoogle(googleKey.accessToken!);
            IsCorrectToken(googleKey.accessToken!);
          } else {
            print('Access token is null');
          }
        }).catchError((err) {
          print('inner error');
        });
      }).catchError((err) {
        print('error occured');
      });
    } catch (error) {
      print(error);
    }
  }
  */

  // id token 발급
  Future<String?> _handleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication googleAuth = await account.authentication;
        print('id : ${googleAuth.idToken}'); // Google 로부터 받은 idToken
        PostApi(googleAuth.accessToken!);
      }
    } catch (error) {
      print(error);
      return null;
    }
    return null;
  }

  // #enddocregion SignIn

  // Prompts the user to authorize `scopes`.
  //
  // This action is **required** in platforms that don't perform Authentication
  // and Authorization at the same time (like the web).
  //
  // On the web, this must be called from an user interaction (button click).
  // #docregion RequestScopes
  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    // #enddocregion RequestScopes
    setState(() {
      _isAuthorized = isAuthorized;
    });

    // #docregion RequestScopes
    if (isAuthorized) {
      unawaited(_handleGetContact(_currentUser!));
    }
    // #enddocregion RequestScopes
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      // The user is Authenticated
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          if (_isAuthorized) ...<Widget>[
            // The user has Authorized all required scopes
            Text(_contactText),
            ElevatedButton(
              child: const Text('REFRESH'),
              onPressed: () => _handleGetContact(user),
            ),
          ],
          if (!_isAuthorized) ...<Widget>[
            // The user has NOT Authorized all required scopes.
            // (Mobile users may never see this button!)
            const Text('Additional permissions needed to read your contacts.'),
            ElevatedButton(
              onPressed: _handleAuthorizeScopes,
              child: const Text('REQUEST PERMISSIONS'),
            ),
          ],
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
        ],
      );
    } else {
      // The user is NOT Authenticated
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          // This method is used to separate mobile from web code with conditional exports.
          // See: src/sign_in_button.dart
          ElevatedButton(
            onPressed: () {
             PostApi(access_token);
            },
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}