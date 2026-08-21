import 'package:byma_app/data/models/hotel_filter_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/business_logic/add_recently_viewed_hotel/cubit/add_recently_viewed_hotel_cubit.dart';
import 'package:byma_app/business_logic/hotels/cubit/hotels_cubit.dart';
import 'package:byma_app/business_logic/hotels/cubit/hotels_state.dart';
import 'package:byma_app/data/models/hotel_model.dart';
import 'package:byma_app/widgets/home_widgets.dart';
import '../constance/app_colors.dart';
import '../widgets/byma_bottom_nav.dart';
import 'bookings_screen.dart';
import 'hotel_details_screen.dart';
import 'messages_final_navigation.dart';
import 'main_layout_screen.dart';
import 'settings_refined_screen.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<BymaBottomNavTab>? onTabChanged;

  const HomeScreen({super.key, this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final primaryColor = Theme.of(context).primaryColor;
    final darkGreenColor = AppColors.kPrimaryColor;
    final darkTextColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.kTextColor;
    final secondaryTextColor =
        Theme.of(context).textTheme.bodySmall?.color ?? AppColors.kSubTextColor;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: BymaBottomNav(
        activeTab: BymaBottomNavTab.home,
        onTabSelected: (tab) {
          if (tab == BymaBottomNavTab.home) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
            );
            return;
          }
          if (tab == BymaBottomNavTab.bookings) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BookingsScreen()),
            );
            return;
          }
          if (tab == BymaBottomNavTab.chat) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BymaChatScreen()),
            );
            return;
          }
          if (tab == BymaBottomNavTab.profile) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SettingsRefinedScreen()),
            );
          }
        },
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HotelCubit>().fetchAllHotels();
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: false,
                backgroundColor: backgroundColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                toolbarHeight: 92,
                title: HomeHeader(
                  primaryColor: primaryColor,
                  secondaryTextColor: secondaryTextColor,
                  darkTextColor: darkTextColor,
                  cardColor: cardColor,
                  isDarkMode: isDarkMode,
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      HomeCategoriesSection(
                        activeColor: darkGreenColor,
                        inactiveIconColor: primaryColor,
                        textColor: secondaryTextColor,
                      ),
                      const SizedBox(height: 25),
                      HomeSearchBar(
                        filterBgColor: darkGreenColor,
                        textColor: secondaryTextColor,
                        cardColor: cardColor,
                        onSearchChanged: (String query) {
                          context.read<HotelCubit>().fetchAllHotels(
                            filter: HotelFilterModel(search: query),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                sliver: BlocBuilder<HotelCubit, HotelsState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () =>
                          const SliverToBoxAdapter(child: SizedBox.shrink()),

                      loading: () => const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),

                      success: (hotels) {
                        if (hotels.isEmpty) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 40.0,
                                ),
                                child: Text(
                                  context.tr('no_hotels_found') ??
                                      'No hotels found',
                                  style: TextStyle(color: secondaryTextColor),
                                ),
                              ),
                            ),
                          );
                        }

                        return SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final hotel = hotels[index];
                            return _buildVerticalProductCard(
                              context,
                              hotel: hotel,
                              titleColor: darkTextColor,
                              subColor: secondaryTextColor,
                            );
                          }, childCount: hotels.length),
                        );
                      },

                      error: (message) => SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error_outline_rounded,
                                  color: Colors.red.shade400,
                                  size: 44,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  message,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    context.read<HotelCubit>().fetchAllHotels();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: darkGreenColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    elevation: 0,
                                  ),
                                  icon: const Icon(
                                    Icons.refresh_rounded,
                                    size: 20,
                                  ),
                                  label: Text(
                                    context.tr('retry') ?? 'Retry',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalProductCard(
    BuildContext context, {
    required HotelModel hotel,
    required Color titleColor,
    required Color subColor,
  }) {
    return HotelProductCard(
      hotel: hotel,
      titleColor: titleColor,
      subColor: subColor,
      onAddClick: () {
        showAddToCollectionSheet(context, hotel.id);
      },
      onTap: () {
        if (hotel.id != 0) {
          context.read<AddRecentlyViewedHotelsCubit>().addRecentlyViewed(
            hotel.id,
          );
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelDetailsScreen(hotelId: hotel.id),
          ),
        );
      },
    );
  }
}
