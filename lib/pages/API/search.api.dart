import 'dart:convert';

import 'package:quote_app/pages/API/models/search_quote.dart';
import 'package:quote_app/pages/constant/constant.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class SearchQuoteAPI {
  static Future<SearchQuote> searchQuote(String query) async {
    var uri = Uri.https(baseUrl, '/search/quotes', {
      "query": query,
    });
    final response = await http.get(uri, headers: {"useQueryString": "true"});

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    return SearchQuote.dataFromSnapshot(data);
  }

  static Future<SearchQuote> searchQuoteLimit(String query, int limit) async {
    var uri = Uri.https(baseUrl, '/search/quotes', {
      "query": query,
      "limit": limit.toString(),
    });
    final response = await http.get(uri, headers: {"useQueryString": "true"});

    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    return SearchQuote.dataFromSnapshot(data);
  }
}
