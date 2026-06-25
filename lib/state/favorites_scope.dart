import 'package:flutter/widgets.dart';

import 'favorites_store.dart';

class FavoritesScope extends InheritedWidget {
  final FavoritesStore store;

  const FavoritesScope({
    required this.store,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant FavoritesScope oldWidget) => false;

  static FavoritesStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<FavoritesScope>();
    if (scope == null) {
      throw StateError('FavoritesStore not found in widget tree.');
    }
    return scope.store;
  }
}
