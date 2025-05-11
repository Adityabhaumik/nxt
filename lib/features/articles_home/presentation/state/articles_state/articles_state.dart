import 'package:nxt/features/articles_home/domain/entities/post_data_enitity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/usecase/articles_usecases.dart';

part 'articles_state.g.dart';

@riverpod
class ArticlesState extends _$ArticlesState {
  List<ArticleDataEnitity> _articles = [];
  @override
  FutureOr<List<ArticleDataEnitity>> build() {
    return get();
  }

  Future<List<ArticleDataEnitity>> get() async {
    try {
      List<ArticleDataEnitity> data = await GetArticlesUseCase.call();
      _articles = data;
      state = AsyncValue.data(_articles);
      return _articles;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refresh() async {
    await get();
  }

  void search(String title) {
    if (title.isEmpty) {
      //reset
      state = AsyncValue.data(_articles);
    } else {
      List<ArticleDataEnitity> filteredArticles = _articles
          .where((article) => article.title.toLowerCase().contains(title))
          .toList();
      state = AsyncValue.data(filteredArticles);
    }
  }
}

@riverpod
class FavouriteArticlesState extends _$FavouriteArticlesState {
  List<ArticleDataEnitity> _articles = [];

  @override
  FutureOr<List<ArticleDataEnitity>> build() async {
    if (_articles.isEmpty) {
      await retrive();
    }
    return _articles;
  }

  void add(ArticleDataEnitity article) {
    _articles.add(article);
    SaveArticlesUseCase.call(_articles);
    state = AsyncData(_articles);
  }

  void remove(ArticleDataEnitity article) {
    _articles.remove(article);
    SaveArticlesUseCase.call(_articles);
    state = AsyncData(_articles);
  }

  Future<void> retrive() async {
    try {
      _articles = await GetSavedArticlesUseCase.call();
      state = AsyncValue.data(_articles);
    } catch (e) {
      rethrow;
    }
  }
}
