// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$articlesStateHash() => r'48892d80c2a056e60acddb6461d016c1ab5c156b';

/// See also [ArticlesState].
@ProviderFor(ArticlesState)
final articlesStateProvider = AutoDisposeAsyncNotifierProvider<ArticlesState,
    List<ArticleDataEnitity>>.internal(
  ArticlesState.new,
  name: r'articlesStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$articlesStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ArticlesState = AutoDisposeAsyncNotifier<List<ArticleDataEnitity>>;
String _$favouriteArticlesStateHash() =>
    r'80d72131fcac0c0ea4875ca3b650ca0a3fada418';

/// See also [FavouriteArticlesState].
@ProviderFor(FavouriteArticlesState)
final favouriteArticlesStateProvider = AutoDisposeAsyncNotifierProvider<
    FavouriteArticlesState, List<ArticleDataEnitity>>.internal(
  FavouriteArticlesState.new,
  name: r'favouriteArticlesStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favouriteArticlesStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavouriteArticlesState
    = AutoDisposeAsyncNotifier<List<ArticleDataEnitity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
