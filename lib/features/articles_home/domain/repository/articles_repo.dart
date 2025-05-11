import 'package:nxt/features/articles_home/domain/entities/post_data_enitity.dart';

abstract class ArticlesRepository {
  Future<List<ArticleDataEnitity>> getAllArticles();
  Future<List<ArticleDataEnitity>> getFavouriteArtices();
  Future<bool> saveFavouriteArticles(List<ArticleDataEnitity> articles);
}
