import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:nxt/core/route/routes.dart';
import 'package:nxt/features/articles_home/domain/entities/post_data_enitity.dart';
import 'package:nxt/features/articles_home/presentation/state/articles_state/articles_state.dart';

const String _keyAll = 'All';
const String _keyFavourites = 'Favourites';

class ArticlesHomeScreen extends ConsumerStatefulWidget {
  const ArticlesHomeScreen({super.key});

  @override
  ConsumerState<ArticlesHomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<ArticlesHomeScreen> {
  FocusNode focusNode = FocusNode(canRequestFocus: true);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    //final articlesState = ref.watch(articlesStateProvider);
    return RefreshIndicator(
      onRefresh: () async {
        try {
          await ref.read(articlesStateProvider.notifier).refresh();
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error ! Check your internet connection'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Bharat NXT Assignment"),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: _keyAll),
                      Tab(text: _keyFavourites),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        allArticlesView(ref),
                        favouritesView(ref),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget favouritesView(WidgetRef ref) {
    final articlesState = ref.watch(favouriteArticlesStateProvider);

    if (articlesState.hasValue == false) {
      return const SizedBox();
    }
    if (articlesState.value!.isEmpty) {
      return const Center(
        child: Text("No Favourites"),
      );
    }
    List<ArticleDataEnitity> articles = articlesState.value!;
    return Scrollbar(
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          ArticleDataEnitity article = articles[index];
          Color isFavourite = Colors.red;
          return GestureDetector(
            onTap: () {
              router.push('/articleDetail/:${article.id}');
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text("Title : ${article.title}"),
                subtitle: Text('This is the data for item ${article.userId}'),
                trailing: IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: isFavourite,
                  ),
                  onPressed: () {
                    ref.read(favouriteArticlesStateProvider.notifier).remove(
                          article,
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Atricle Removed')),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget allArticlesView(WidgetRef ref) {
    final articlesState = ref.watch(articlesStateProvider);
    final favouriteArticlesState = ref.watch(favouriteArticlesStateProvider);
    return articlesState.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) => const Center(
              child: Text(
                "Error ! Check your internet connection",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
        data: (data) {
          List<ArticleDataEnitity> searchArticles = [];

          List<ArticleDataEnitity> articles = articlesState.value!;
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  focusNode: focusNode,
                  controller: controller,
                  onSubmitted: (val) {
                    searchArticles.clear();
                    controller.text = val;
                    if (controller.text.isNotEmpty == true) {
                      ref.read(articlesStateProvider.notifier).search(
                            controller.text,
                          );
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search articles...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: focusNode.hasFocus == true
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              focusNode.unfocus();
                              controller.clear();
                              ref
                                  .read(articlesStateProvider.notifier)
                                  .search("");
                            },
                          )
                        : const SizedBox(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      ArticleDataEnitity article = articles[index];

                      Color isFavourite = Colors.grey;

                      if (favouriteArticlesState.hasValue) {
                        if (favouriteArticlesState.value!.where((art) {
                          return art.id == article.id;
                        }).isNotEmpty) {
                          isFavourite = Colors.red;
                        }
                      }

                      return GestureDetector(
                        onTap: () {
                          router.push('/articleDetail/:${article.id}');
                        },
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text("Title : ${article.title}"),
                            subtitle: Text("Body : ${article.body}",
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: isFavourite,
                              ),
                              onPressed: () {
                                ref
                                    .read(
                                        favouriteArticlesStateProvider.notifier)
                                    .add(
                                      article,
                                    );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Article added to Favourite')),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }
}
