import 'dart:convert';

import 'package:nxt/features/articles_home/data/models/posts_data_model.dart';
import 'package:nxt/features/articles_home/domain/entities/post_data_enitity.dart';
import 'package:nxt/features/articles_home/domain/repository/articles_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sources/remote/remote_article_source.dart';

class ArticlesRepositoryImpl extends ArticlesRepository {
  @override
  Future<List<ArticleDataEnitity>> getAllArticles() async {
    List<ArticleDataEnitity> articles = [];
    try {
      List<ArticleDataModel> response =
          await RemoteArticleDataSource.getArticlesFromRemote();
      for (ArticleDataModel article in response) {
        ArticleDataEnitity enitity = ArticleDataModel.toEntity(article);
        articles.add(enitity);
      }
      return articles;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ArticleDataEnitity>> getFavouriteArtices() async {
    try {
      final SharedPreferences prev = await SharedPreferences.getInstance();
      final List<String>? articles = prev.getStringList('favouriteArticles');
      List<ArticleDataEnitity> articlesList = [];
      if (articles == null) {
        return [];
      }
      for (String article in articles) {
        articlesList.add(ArticleDataModel.toEntity(
            ArticleDataModel.fromJson(json.decode(article))));
      }
      return articlesList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> saveFavouriteArticles(List<ArticleDataEnitity> articles) async {
    try {
      final SharedPreferences prev = await SharedPreferences.getInstance();
      List<String> articlesToBeSaved = [];
      for (ArticleDataEnitity article in articles) {
        articlesToBeSaved
            .add(ArticleDataModel.toJson(ArticleDataModel.fromEntity(article)));
      }
      final res = prev.setStringList('favouriteArticles', articlesToBeSaved);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
