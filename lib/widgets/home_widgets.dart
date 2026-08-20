import 'dart:async';
import 'package:byma_app/business_logic/add_hotel_to_collection/cubit/add_hotel_to_collection_cubit.dart';
import 'package:byma_app/business_logic/add_hotel_to_collection/cubit/add_hotel_to_collection_state.dart';
import 'package:byma_app/business_logic/collection/cubit/collection_cubit.dart';
import 'package:byma_app/business_logic/collection/cubit/collection_state.dart';
import 'package:byma_app/business_logic/create_collection/cubit/create_collection_cubit.dart';
import 'package:byma_app/business_logic/create_collection/cubit/create_collection_state.dart';
import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_cubit.dart';
import 'package:byma_app/business_logic/favorite_hotels/cubit/favorite_hotels_state.dart';
import 'package:byma_app/business_logic/toggle_favorite_hotels/cubit/toggle_favorite_hotels_cubit.dart';
import 'package:byma_app/data/models/hotel_model.dart';
import 'package:byma_app/screens/conversation_screen.dart';
import 'package:byma_app/screens/hotel_filter_screen.dart';
import 'package:byma_app/screens/soon_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';


// ==========================================
// 1. HOME HEADER WIDGET
// ==========================================
class HomeHeader extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryTextColor;
  final Color darkTextColor;
  final Color cardColor;
  final bool isDarkMode;

  const HomeHeader({
    super.key,
    required this.primaryColor,
    required this.secondaryTextColor,
    required this.darkTextColor,
    required this.cardColor,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'BYMA'.tr(),
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'find_your_next_stay'.tr(),
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.05)
                      : const Color(0xFFF4F8F8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: darkTextColor,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. CATEGORIES SECTION WIDGET
// ==========================================
class HomeCategoriesSection extends StatelessWidget {
  final Color activeColor;
  final Color inactiveIconColor;
  final Color textColor;

  const HomeCategoriesSection({
    super.key,
    required this.activeColor,
    required this.inactiveIconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SoonSplashScreen(
                title: 'CARS'.tr(),
                icon: Icons.directions_car_filled_outlined,
              ),
            ),
          ),
          child: _CategoryItem(
            icon: Icons.directions_car_filled_outlined,
            label: 'CARS'.tr(),
            bgColor: isDarkMode
                ? Colors.white.withOpacity(0.05)
                : const Color(0xFFEFF3F6),
            iconColor: inactiveIconColor.withOpacity(0.6),
            textColor: textColor,
          ),
        ),
        Column(
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(42),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: activeColor.withOpacity(0.25),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.king_bed_outlined,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'HOTELS'.tr(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: activeColor,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SoonSplashScreen(
                title: 'EATS'.tr(),
                icon: Icons.restaurant_outlined,
              ),
            ),
          ),
          child: _CategoryItem(
            icon: Icons.restaurant_outlined,
            label: 'EATS'.tr(),
            bgColor: isDarkMode
                ? Colors.white.withOpacity(0.05)
                : const Color(0xFFFFF9F2),
            iconColor: const Color(0xFFFFB057),
            textColor: textColor,
          ),
        ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color iconColor;
  final Color textColor;

  const _CategoryItem({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 26),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: textColor.withOpacity(0.6),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 3. SEARCH BAR WIDGET
// ==========================================
class HomeSearchBar extends StatelessWidget {
  final Color filterBgColor;
  final Color textColor;
  final Color cardColor;

  const HomeSearchBar({
    super.key,
    required this.filterBgColor,
    required this.textColor,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'search_hotels_hint'.tr(),
                hintStyle: TextStyle(
                  color: textColor.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  child: Icon(
                    Icons.search,
                    color: textColor.withOpacity(0.7),
                    size: 22,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HotelFilterScreen()),
            );
          },
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: filterBgColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 22),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 4. ADD TO COLLECTION BOTTOM SHEET
// ==========================================
void showAddToCollectionSheet(BuildContext context, int hotelId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CollectionCubit(
              context.read(),
            )..fetchAllCollections(),
          ),
          BlocProvider(
            create: (context) => CreateCollectionCubit(context.read()),
          ),
          BlocProvider(
            create: (context) => AddHotelToCollectionCubit(context.read()),
          ),
        ],
        child: AddToCollectionSheetBody(hotelId: hotelId),
      );
    },
  );
}

class AddToCollectionSheetBody extends StatelessWidget {
  final int hotelId;

  const AddToCollectionSheetBody({super.key, required this.hotelId});

  void _showTopSnackBar(
    BuildContext context,
    String message,
    Color backgroundColor,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topMargin = screenHeight - 150;

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(bottom: topMargin, left: 20, right: 20),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF0F4A42);

    return MultiBlocListener(
      listeners: [
        BlocListener<AddHotelToCollectionCubit, AddHotelToCollectionState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                Navigator.pop(context);
                _showTopSnackBar(context, 'Saved to collection!', Colors.green);
              },
              error: (message) {
                _showTopSnackBar(context, message, Colors.red);
              },
            );
          },
        ),
        BlocListener<CreateCollectionCubit, CreateCollectionState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                context.read<CollectionCubit>().fetchAllCollections();
                _showTopSnackBar(
                  context,
                  'Collection created successfully!',
                  Colors.green,
                );
              },
              error: (message) {
                _showTopSnackBar(context, message, Colors.red);
              },
            );
          },
        ),
      ],
      child: Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Save to collection',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _showCreateCollectionDialog(context),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text(
                    'Create Collection',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Expanded(
              child: BlocBuilder<CollectionCubit, CollectionState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (message) => Center(
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    success: (collections) {
                      if (collections.isEmpty) {
                        return Center(
                          child: Text(
                            'No collections yet. Create one now!',
                            style: TextStyle(
                              color: textColor.withOpacity(0.6),
                              fontSize: 14,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: collections.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final collectionItem = collections[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: textColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.bookmark_border_rounded,
                                color: textColor,
                              ),
                            ),
                            title: Text(
                              collectionItem.name,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            trailing: BlocBuilder<
                                AddHotelToCollectionCubit,
                                AddHotelToCollectionState>(
                              builder: (context, addState) {
                                final isLoading = addState.maybeWhen(
                                  loading: () => true,
                                  orElse: () => false,
                                );
                                return isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Icon(
                                        Icons.chevron_right_rounded,
                                        color: textColor.withOpacity(0.5),
                                      );
                              },
                            ),
                            onTap: () {
                              context
                                  .read<AddHotelToCollectionCubit>()
                                  .addHotelToCollection(
                                    collectionItem.id,
                                    hotelId,
                                  );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateCollectionDialog(BuildContext parentContext) {
    final textController = TextEditingController();

    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('New Collection'),
          content: TextField(
            controller: textController,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = textController.text.trim();
                if (name.isNotEmpty) {
                  parentContext
                      .read<CreateCollectionCubit>()
                      .createCollection(name);
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}

// ==========================================
// 5. HOTEL PRODUCT CARD CLASS
// ==========================================

class HotelProductCard extends StatefulWidget {
  final HotelModel hotel;
  final Color titleColor;
  final Color subColor;
  final VoidCallback onTap;
  final VoidCallback onAddClick;

  const HotelProductCard({
    super.key,
    required this.hotel,
    required this.titleColor,
    required this.subColor,
    required this.onTap,
    required this.onAddClick,
  });

  @override
  State<HotelProductCard> createState() => _HotelProductCardState();
}

class _HotelProductCardState extends State<HotelProductCard> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    if (widget.hotel.imageUrls.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        if (_currentPage < widget.hotel.imageUrls.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.hotel.imageUrls.length,
                      onPageChanged: (index) {
                        _currentPage = index;
                      },
                      itemBuilder: (context, index) {
                        final imageUrl = widget.hotel.imageUrls[index];
                        final isAsset = imageUrl.startsWith('assets/');

                        return Container(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.05)
                              : const Color(0xFFE2E8F0),
                          child: isAsset
                              ? Image.asset(imageUrl, fit: BoxFit.cover)
                              : Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/hotel-placeholder.jpg',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                        );
                      },
                    ),
                  ),
                ),

                Positioned(
                  top: 15,
                  right: 15,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: widget.onAddClick,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              isDarkMode ? 0.2 : 0.75,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.bookmark_border_rounded,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF0F4A42),
                            size: 20,
                          ),
                        ),
                      ),

                      BlocBuilder<FavoriteHotelsCubit, FavoriteHotelsState>(
                        builder: (context, state) {
                          bool isFav = false;
                          int? favoriteRecordId;

                          state.when(
                            initial: () {},
                            loading: () {},
                            error: (message) {},
                            success: (favoriteHotels) {
                              for (var fav in favoriteHotels) {
                                // Compare directly against integer IDs
                                if (fav.hotel.id == widget.hotel.id) {
                                  isFav = true;
                                  favoriteRecordId = fav.id;
                                  break;
                                }
                              }
                            },
                          );

                          return InkWell(
                            onTap: () async {
                              final hotelIdInt = widget.hotel.id;

                              if (isFav && favoriteRecordId != null) {
                                context
                                    .read<FavoriteHotelsCubit>()
                                    .removeHotelOptimistically(
                                      favoriteRecordId!,
                                    );

                                context
                                    .read<ToggleFavoriteHotelsCubit>()
                                    .removeFavorite(favoriteRecordId!);
                              } else {
                                await context
                                    .read<ToggleFavoriteHotelsCubit>()
                                    .addFavorite(hotelIdInt);

                                context
                                    .read<FavoriteHotelsCubit>()
                                    .getFavoriteHotels();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                  isDarkMode ? 0.2 : 0.75,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isFav
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border,
                                color: isFav
                                    ? const Color(0xFF0FA37A)
                                    : (isDarkMode
                                          ? Colors.white
                                          : const Color(0xFF0F4A42)),
                                size: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.hotel.name,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: widget.titleColor,
                    letterSpacing: -0.2,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      widget.hotel.rating.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: widget.titleColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.hotel.address,
              style: TextStyle(
                fontSize: 13,
                color: widget.subColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


