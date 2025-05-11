import 'package:nxt/features/articles_home/data/models/posts_data_model.dart';

import '../../../../../core/api_services/api_services.dart';

class RemoteArticleDataSource {
  static Future<List<ArticleDataModel>> getArticlesFromRemote() async {
    try {
      final response = await ApiService.get('posts');
      if (response is List) {
        final data =
            response.map((post) => ArticleDataModel.fromJson(post)).toList();
        return data;
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      rethrow;
    }
  }
}
