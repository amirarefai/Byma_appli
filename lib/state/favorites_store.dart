import 'package:flutter/foundation.dart';

class FavoriteItem {
  final String id; // used as unique key
  final String title;
  final String subtitle;
  final String rating;
  final String fromText;
  final String price;
  final String ctaText;
  final String imageAsset; // can be empty
  final String? compactBadge;

  const FavoriteItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.fromText,
    required this.price,
    required this.ctaText,
    required this.imageAsset,
    this.compactBadge,
  });
}

class FavoritesStore extends ChangeNotifier {
  final Map<String, FavoriteItem> _favorites = <String, FavoriteItem>{};

  bool isFavorite(String id) => _favorites.containsKey(id);

  FavoriteItem? getFavorite(String id) => _favorites[id];

  List<FavoriteItem> get favorites => _favorites.values.toList(growable: false);

  void toggleFavorite(FavoriteItem item) {
    if (_favorites.containsKey(item.id)) {
      _favorites.remove(item.id);
    } else {
      _favorites[item.id] = item;
    }
    notifyListeners();
  }
}
