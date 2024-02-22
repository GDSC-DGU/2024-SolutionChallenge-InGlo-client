import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TranslationService {
  Future<String> getTranslation(String lang, String text) async {
    print("text: $text");
    if (lang == "0") {
      return text;
    }

    try {
      var result;
      var baseUrl = 'https://translation.googleapis.com/language/translate/v2';
      var key = dotenv.get("GOOGLE_TRANSLATE_API_KEY");
      var to = "ko"; //(ex: en, ko, etc..)
      var response = await http.post(
        Uri.parse('$baseUrl?target=$to&key=$key&q=$text'),
      );

      if (response.statusCode == 200) {
        var dataJson = jsonDecode(response.body);
        result = dataJson['data']['translations'][0]['translatedText'];
        print("translate: ${response.body}");
        return result;
      } else {
        print(response.body);
      }

    } catch (e) {
// 예외 처리
      print('Exception caught: $e');
    }

    return "Failed to translate";
  }


}
