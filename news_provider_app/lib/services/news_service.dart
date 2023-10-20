import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:news_provider_app/models/models.dart';

class NewsService with ChangeNotifier {
  final _baseUrl = 'https://newsapi.org/v2';
  final _apiKey = '39f96ca675ab4bda83800913ebe52d8a';
  final _country = 'us';

  String _selectedCategory = 'business';
  List<Article> articles = [];
  Map<String, List<Article>> articlesByCategory = {};
  List<Category> categories = [
    Category(icon: FontAwesomeIcons.building, name: 'business'),
    Category(icon: FontAwesomeIcons.tv, name: 'entertaiment'),
    Category(icon: FontAwesomeIcons.addressCard, name: 'general'),
    Category(icon: FontAwesomeIcons.headSideVirus, name: 'health'),
    Category(icon: FontAwesomeIcons.vials, name: 'science'),
    Category(icon: FontAwesomeIcons.volleyball, name: 'sports'),
    Category(icon: FontAwesomeIcons.memory, name: 'technology'),
  ];

  NewsService() {
    getTopArticles();
    for (var category in categories) {
      articlesByCategory[category.name] = [];
    }
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    getArticlesBy(category: value);
    notifyListeners();
  }

  List<Article>? get selectedArticlesByCategory => articlesByCategory[selectedCategory];

  getTopArticles() async {
    final url = '$_baseUrl/top-headlines?country=$_country&apiKey=$_apiKey';
    final response = await http.get(Uri.parse(url));
    articles.addAll(NewsResponse.fromRawJson(response.body).articles);
    notifyListeners();
  }

  getArticlesBy({required String category}) async {
    if (articlesByCategory[category]!.isNotEmpty) {
      return articlesByCategory[category];
    }
    final url = '$_baseUrl/top-headlines?country=$_country&apiKey=$_apiKey&category=$category';
    final response = await http.get(Uri.parse(url));
    articlesByCategory[category]!.addAll(NewsResponse.fromRawJson(response.body).articles);
    notifyListeners();
  }
}
