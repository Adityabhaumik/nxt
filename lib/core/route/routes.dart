import 'package:go_router/go_router.dart';

import '../../features/articles_home/presentation/screens/article_screen.dart';
import '../../features/articles_home/presentation/screens/articles_list_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ArticlesHomeScreen(),
    ),
    GoRoute(
        path: '/articleDetail/:id',
        builder: (context, state) {
          final String chargerId = state.pathParameters['id']!.substring(1);
          final int id = int.tryParse(chargerId) ?? 0;
          return ArticleScreen(
            id: id,
          );
        }),
  ],
);
