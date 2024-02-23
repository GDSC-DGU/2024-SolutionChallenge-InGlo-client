import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // 로그인
  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      return account;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // 로그아웃
  static Future<void> disconnect() async {
    await _googleSignIn.disconnect();
  }
}
