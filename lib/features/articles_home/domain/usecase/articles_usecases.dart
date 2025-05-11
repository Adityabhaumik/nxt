import 'package:nxt/features/articles_home/data/repository/articles_impl.dart';

import '../entities/post_data_enitity.dart';

class GetArticlesUseCase {
  static Future<List<ArticleDataEnitity>> call() async {
    try {
      final articles = await ArticlesRepositoryImpl().getAllArticles();
      return articles;
    } catch (e) {
      rethrow;
    }
  }
}

class SaveArticlesUseCase {
  static Future<bool> call(List<ArticleDataEnitity> articles) async {
    try {
      await ArticlesRepositoryImpl().saveFavouriteArticles(articles);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

class GetSavedArticlesUseCase {
  static Future<List<ArticleDataEnitity>> call() async {
    try {
      List<ArticleDataEnitity> savedData =
          await ArticlesRepositoryImpl().getFavouriteArtices();
      return savedData;
    } catch (e) {
      rethrow;
    }
  }
}
