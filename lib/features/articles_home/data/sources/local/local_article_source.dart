import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/posts_data_model.dart';

class LocalArticleDataSource {
  static Future<List<ArticleDataModel>> getSavedFavouriteArticles() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? savedArticles = prefs.getStringList('saved_articles') ?? [];
      List<ArticleDataModel> articles = [];
      for (String article in savedArticles) {
        articles.add(ArticleDataModel.fromJson(jsonDecode(article)));
      }
      return articles;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> saveFavouriteArticlesLocally(
      List<ArticleDataModel> articles) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> articlesToBeSaved = [];
      for (ArticleDataModel article in articles) {
        articlesToBeSaved.add(ArticleDataModel.toJson(article));
      }
      await prefs.setStringList('saved_articles', articlesToBeSaved);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
