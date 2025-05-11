import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nxt/features/articles_home/domain/entities/post_data_enitity.dart';

import '../state/articles_state/articles_state.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  final int id;

  const ArticleScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  late ArticleDataEnitity? article;
  @override
  void initState() {
    try {
      article = ref
          .read(articlesStateProvider)
          .value!
          .firstWhere((element) => element.id == widget.id);
    } catch (e) {
      try {
        article = ref
            .read(favouriteArticlesStateProvider)
            .value!
            .firstWhere((element) => element.id == widget.id);
      } catch (e) {
        article = null;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (article == null) {
      return const Scaffold(
        body: Center(
          child: Text("Error"),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Article Id : ${article!.id}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title : \n${article!.title}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Body : \n${article!.body}",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
