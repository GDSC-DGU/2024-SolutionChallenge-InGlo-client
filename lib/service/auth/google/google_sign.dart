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

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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

  // 스프링 api post 코드!!!!!!!!! // test용 주석
  Future<void> _handlePostWithToken(String _token) async {
    setState(() {
      _contactText = 'Sending data...';
    });

    final String token = _token;

    final http.Response response = await http.post(
      Uri.parse('baseurl/api/accounts/google/login/'), // end point
      body: json.encode(<String, String>{
        'access_token': token,
      }),
    );
    // error
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'error code :  ${response.statusCode}';
      });
      print('api code :  ${response.statusCode}, response: ${response.body}');
      return;
    }
    // 성공
    setState(() {
      _contactText = 'success code : ${response.statusCode}';
    });
    print('api code :  ${response.statusCode}, response: ${response.body}');
    return;
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

  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  // #docregion SignIn
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((result){
        result?.authentication.then((googleKey){
          print(googleKey.accessToken); // 토큰
          print(googleKey.idToken); // null값 출력
          print(_googleSignIn.currentUser?.displayName); // 유저 이름
        }).catchError((err){
          print('inner error');
        });
      }).catchError((err){
        print('error occured');
      });
    } catch (error) {
      print(error);
    }
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
      return Container(
        // 배경 이미지를 넣기 위해 Scaffold를 Container로 감싸준다.
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              repeat: ImageRepeat.noRepeat,
              image: Svg(
                'assets/image/background/background.svg',
                // size: Size(10, 10), // size 지정 하던 안 하던 동일하다.
              ),
            )),
        child: Scaffold(
          // 배경 이미지를 위해 Scaffold의 배경색을 투명으로 한다.
          backgroundColor: Colors.transparent,
          // 수직 스크롤이 된다고 한다.
          // 나중에 빼도 될 것 같다!
          body: SingleChildScrollView(
            child: Padding(
              // 전체 padding
              padding: const EdgeInsets.fromLTRB(60, 300, 60, 0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 160.0),
                    OutlinedButton(
                      onPressed: _handleSignIn,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white), // 버튼 배경색
                        minimumSize: MaterialStateProperty.all(Size(400, 40)), // 버튼 사이즈
                        // 테두리 색상 설정
                        side: MaterialStateProperty.all(BorderSide(color: Color(0xFFDADCE0), width: 1)),
                      ),
                      child: Text(
                        "SIGNIN WITH GOOGLE",
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.black,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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