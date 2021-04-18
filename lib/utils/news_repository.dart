import 'dart:convert';
import 'dart:io';

import 'package:google_login/models/new.dart';
import 'package:google_login/utils/secrets.dart';
import 'package:http/http.dart';

class NewsRepository {
  List<New> _noticiasList;

  static final NewsRepository _newsRepository = NewsRepository._internal();
  factory NewsRepository() {
    return _newsRepository;
  }

  NewsRepository._internal();
  Future<List<New>> getAvailableNoticias(String query) async {
    // https://newsapi.org/v2/top-headlines?country=mx&q=futbol&category=sports&apiKey&apiKey=laAPIkey
    // crear modelos antes

    final _uri = Uri(
      scheme: 'https',
      host: 'newsapi.org',
      path: 'v2/everything',
      queryParameters: {
        "q": query??"sports",
        "apiKey": API_KEY
      },
    );
    try {
      final response = await get(_uri);
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = jsonDecode(response.body)["articles"];
        _noticiasList =
            ((data).map((element) => New.fromJson(element))).toList();
        return _noticiasList;
      }
      return [];
    } catch (e) {
      //arroje un error
      
      throw "Ha ocurrido un error: $e";
    }
  }
}
