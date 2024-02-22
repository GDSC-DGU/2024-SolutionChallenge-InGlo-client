import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:inglo/provider/profile/users.dart';
import 'package:provider/provider.dart';

class TranslationService {
  Future<String> getTranslation(String text, BuildContext context) async {
    // provider로 어떤 언어할지 불러오기!
    final lang = context.watch<UserProvider>().user?.language ?? "0";
    print("lang: $lang");
    print("text: $text");
    if (lang == "0") {
      return text;
    }

    try {
      var result;
      var baseUrl = 'https://translation.googleapis.com/language/translate/v2';
      var key = dotenv.get("GOOGLE_TRANSLATE_API_KEY");
      var to = lang; // 번역할 언어
      var response = await http.post(
        Uri.parse('$baseUrl?target=$to&key=$key&q=$text'),
      );

      if (response.statusCode == 200) {
        var dataJson = jsonDecode(response.body);
        result = dataJson['data']['translations'][0]['translatedText'];
        //print("translate: ${response.body}");
        return result;
      } else {
        print(response.body);
      }

    } catch (e) {
// 예외 처리
      print('Exception caught: $e');
    }
    return text;
  }


}
