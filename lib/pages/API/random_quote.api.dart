import 'package:quote_app/pages/API/models/random_quote.dart';
import 'dart:convert';
import 'package:quote_app/pages/constant/constant.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class RandomQuoteAPI {
  static Future<RandomQuote> getQuotes() async {
    var uri = Uri.https(baseUrl, '/quotes', {});
    final response = await http.get(uri);

    Map<String, dynamic> data = jsonDecode(response.body);
    return RandomQuote.dataFromSnapshot(data);
  }
}
