import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_news_app_/models/article_model.dart';

class HttpServices {
  Future<List<ArticleModel>> getAllArticles() async {
    var response = await http.get(
      Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=851392b247194bccabda8d65123e348a"),
      headers: {
        'authorization': 'apikey 851392b247194bccabda8d65123e348a',
        'content-type': 'application/json',
      },
    );
    var status = jsonDecode(response.statusCode.toString());

    // ignore: avoid_print
    print("STATUS: $status");

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    List<dynamic> articlesBody = jsonData['articles'];
    List<ArticleModel> articles =
        articlesBody.map((dynamic val) => ArticleModel.fromJson(val)).toList();
    return articles;
  }
}
