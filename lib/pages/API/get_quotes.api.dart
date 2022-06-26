import 'dart:convert';
import 'package:quote_app/pages/API/models/author_quote.dart';
import 'package:quote_app/pages/constant/constant.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class AuthorQuoteAPI {
  static Future<AuthorQuote> authorQuote(String author) async {
    var uri = Uri.https(baseUrl, '/search/authors', {
      "query": author,
    });
    final response = await http.get(uri, headers: {"useQueryString": "true"});

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    return AuthorQuote.dataFromSnapshot(data);
  }
}
