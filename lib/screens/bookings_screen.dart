import 'package:byma_app/business_logic/booking_history/cubit/booking_history_cubit.dart';
import 'package:byma_app/business_logic/booking_history/cubit/booking_history_state.dart';
import 'package:byma_app/business_logic/cancel_booking/cubit/cancel_booking_cubit.dart';
import 'package:byma_app/business_logic/cancel_booking/cubit/cancel_booking_state.dart';
import 'package:byma_app/business_logic/reports/cubit/reports_cubit.dart';
import 'package:byma_app/business_logic/reports/cubit/reports_state.dart';
import 'package:byma_app/business_logic/reviews/cubit/reviews_cubit.dart';
import 'package:byma_app/business_logic/reviews/cubit/reviews_state.dart';
import 'package:byma_app/business_logic/update_booking/cubit/update_booking_cubit.dart';
import 'package:byma_app/business_logic/update_review/cubit/update_review_cubit.dart';
import 'package:byma_app/data/models/booking_history_model.dart';
import 'package:byma_app/data/models/update_booking_model.dart';
import 'package:byma_app/data/models/update_review_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/byma_bottom_nav.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  // Default status mapping to your backend API expected values
  String _selectedTabStatus = 'confirmed';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 1. Initial Fetch
    context.read<BookingHistoryCubit>().fetchBookingHistory(_selectedTabStatus);

    // 2. Attach Pagination Listener
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Fetch more when the user scrolls near the bottom of the list
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<BookingHistoryCubit>().fetchMoreBookings();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 1️⃣ واجهة إدارة الحجز (تعديل التاريخ أو الإلغاء)
  void _showManageBookingSheet(
    BuildContext context,
    String title,
    ThemeData theme,
    bool isYellowTheme,
    int bookingId,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'manage_booking_label'.tr(),
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.tertiary,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 24),

              // خيار تعديل التاريخ
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.calendar_month,
                  color: theme.colorScheme.primary,
                ),
                title: Text(
                  'edit_date_label'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () async {
                  final picked = await showDateRangePicker(
                    context: sheetContext,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );

                  if (picked != null) {
                    // 1. Close the bottom sheet safely
                    if (sheetContext.mounted) {
                      Navigator.pop(sheetContext);
                    }

                    // 2. Format the dates to match your backend expectations (e.g., yyyy-MM-dd)
                    final DateFormat formatter = DateFormat('yyyy-MM-dd');
                    final updateModel = UpdateBookingModel(
                      startDate: formatter.format(picked.start),
                      endDate: formatter.format(picked.end),
                    );

                    // 3. Trigger the Update API Call via Cubit
                    if (context.mounted) {
                      context.read<UpdateBookingCubit>().updateBooking(
                        bookingId,
                        updateModel,
                      );
                    }
                  }
                },
              ),
              Divider(color: theme.dividerColor),
              // خيار إلغاء الحجز
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.redAccent,
                ),
                title: Text(
                  'cancel_booking_label'.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.redAccent,
                ),
                onTap: () {
                  // 1. Close the Bottom Sheet
                  Navigator.pop(sheetContext);

                  // 2. Trigger the API call via Cubit
                  context.read<CancelBookingCubit>().cancelBooking(bookingId);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // 2️⃣ واجهة التقييم والبلاغات
  void _showReportSheet(
    BuildContext context,
    ThemeData theme,
    bool isYellowTheme,
    int hotelId,
  ) {
    final reportController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.dividerColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'What went wrong?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: reportController,
                  maxLines: 5,
                  autofocus: true,
                  style: TextStyle(color: theme.colorScheme.secondary),
                  decoration: InputDecoration(
                    hintText: 'Tell us what went wrong...',
                    hintStyle: TextStyle(
                      color: theme.colorScheme.tertiary.withOpacity(0.5),
                      fontSize: 13,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final reason = reportController.text.trim();
                      if (reason.isEmpty) return;

                      Navigator.pop(sheetContext);
                      context.read<ReportsCubit>().createReport(
                        hotelId: hotelId,
                        reason: reason,
                      );
                    },
                    icon: const Icon(Icons.send_rounded),
                    label: Text(
                      'submit_report'.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isYellowTheme ? Colors.black : Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isYellowTheme
                          ? Colors.yellow
                          : theme.colorScheme.primary,
                      foregroundColor: isYellowTheme
                          ? Colors.black
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showReviewSheet(
    BuildContext context,
    ThemeData theme,
    bool isYellowTheme,
    int hotelId,
  ) {
    int rating = 0;
    final commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: theme.dividerColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Rate your stay',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'How was your experience?',
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          tooltip: '${index + 1} stars',
                          onPressed: () => setSheetState(() => rating = index + 1),
                          icon: Icon(
                            index < rating
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            color: Colors.amber,
                            size: 38,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: commentController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Share a comment (optional)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.colorScheme.primary),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: rating == 0
                            ? null
                            : () {
                                Navigator.pop(sheetContext);
                                context.read<ReviewsCubit>().createReview(
                                  rate: rating,
                                  hotelId: hotelId,
                                  comment: commentController.text.trim().isEmpty
                                      ? null
                                      : commentController.text.trim(),
                                );
                              },
                        icon: const Icon(Icons.star_rounded),
                        label: const Text('Submit Review'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isYellowTheme
                              ? Colors.yellow
                              : theme.colorScheme.primary,
                          foregroundColor: isYellowTheme
                              ? Colors.black
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(commentController.dispose);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<ReviewsCubit, ReviewsState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () => _showLoadingDialog(context),
              success: () {
                _hideLoadingDialog(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('thanks_for_rating'.tr()),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              error: (message) {
                _hideLoadingDialog(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
            );
          },
        ),
        BlocListener<ReportsCubit, ReportsState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () => _showLoadingDialog(context),
              success: () {
                _hideLoadingDialog(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('report_sent_success'.tr()),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              error: (message) {
                _hideLoadingDialog(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
            );
          },
        ),
        // 1. Existing Cancel Booking Listener
        BlocListener<CancelBookingCubit, CancelBookingState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () => _showLoadingDialog(context),
              success: () {
                _hideLoadingDialog(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('cancellation sent successfully'.tr()),
                    backgroundColor: Colors.green,
                  ),
                );
                context.read<BookingHistoryCubit>().fetchBookingHistory(
                  _selectedTabStatus,
                );
              },
              error: (message) {
                _hideLoadingDialog(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
            );
          },
        ),

        // 2. NEW Update Booking Listener
        BlocListener<UpdateBookingCubit, UpdateBookingState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () => _showLoadingDialog(context),
              success: () {
                _hideLoadingDialog(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('date_updated_success'.tr()),
                    backgroundColor: Colors.green,
                  ),
                );
                // Refresh the list to reflect the new dates globally
                context.read<BookingHistoryCubit>().fetchBookingHistory(
                  _selectedTabStatus,
                );
              },
              error: (message) {
                _hideLoadingDialog(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
            );
          },
        ),
      ],
      child: Scaffold(
        // ... Keep the rest of your Scaffold code exactly the same ...
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الهيدر العلوي
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: theme.iconTheme.color,
                      ),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                    Text(
                      'BYMA',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.primary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // العناوين الترحيبية
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'journey_history'.tr(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.secondary,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'your_stays'.tr(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'stays_subtitle'.tr(),
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.tertiary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // أزرار الفلترة الأفقية - Updated Statuses
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      _buildTabButton('confirmed', 'confirmed'.tr(), theme),
                      const SizedBox(width: 10),
                      _buildTabButton('active', 'active'.tr(), theme),
                      const SizedBox(width: 10),
                      _buildTabButton('completed', 'completed'.tr(), theme),
                      const SizedBox(width: 10),
                      _buildTabButton('cancelled', 'cancelled'.tr(), theme),
                    ],
                  ),
                ),
              ),

              // قائمة البطاقات عبر BlocBuilder
              Expanded(
                child: BlocBuilder<BookingHistoryCubit, BookingHistoryState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () =>
                          const Center(child: CircularProgressIndicator()),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (message) => Center(
                        child: Text(
                          message,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                      success:
                          (
                            bookings,
                            hasReachedMax,
                            isFetchingMore,
                            paginationError,
                          ) {
                            if (bookings.isEmpty) {
                              return Center(
                                child: Text('no_bookings_found'.tr()),
                              );
                            }

                            return ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 10,
                              ),
                              itemCount:
                                  bookings.length + (isFetchingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                // Bottom loader while paginating
                                if (index >= bookings.length) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                return _buildBookingCard(
                                  context: context,
                                  booking: bookings[index],
                                  theme: theme,
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
        bottomNavigationBar: BymaBottomNav(
          activeTab: BymaBottomNavTab.bookings,
          onTabSelected: (tab) {},
        ),
      ),
    );
  }

  // Refactored to map backend status cleanly
  Widget _buildTabButton(String status, String label, ThemeData theme) {
    final isActive = _selectedTabStatus == status;
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          setState(() => _selectedTabStatus = status);
          context.read<BookingHistoryCubit>().fetchBookingHistory(status);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? theme.colorScheme.primary : theme.cardColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isActive ? Colors.transparent : theme.dividerColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  // Uses BookingHistoryModel Directly & handles Dynamic Image URLs safely
  Widget _buildBookingCard({
    required BuildContext context,
    required BookingHistoryModel booking,
    required ThemeData theme,
  }) {
    final isYellowTheme = theme.colorScheme.primary == Colors.yellow;

    // Manageability check depending on backend status
    final canManageBooking = booking.status == 'confirmed';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              child: PageView.builder(
                itemCount: booking.imageUrls.length,
                itemBuilder: (context, index) {
                  final imageUrl = booking.imageUrls[index];
                  return imageUrl.startsWith('http')
                      ? Image.network(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildImageFallback(),
                        )
                      : Image.asset(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildImageFallback(),
                        );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${booking.cityName}, ${booking.countryName}'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  booking.hotelName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _buildBookingDetail(
                        theme,
                        Icons.meeting_room_outlined,
                        'Room',
                        booking.roomNumber.isNotEmpty
                            ? booking.roomNumber
                            : 'TBD',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildBookingDetail(
                        theme,
                        Icons.payments_outlined,
                        'Total Price',
                        '\$${booking.totalPrice.toStringAsFixed(2)}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildBookingDetail(
                        theme,
                        Icons.login_rounded,
                        'Start Date',
                        _formatBookingDate(booking.startDate),
                        valueFontSize: 10,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildBookingDetail(
                        theme,
                        Icons.logout_rounded,
                        'End Date',
                        _formatBookingDate(booking.endDate),
                        valueFontSize: 10,
                      ),
                    ),
                  ],
                ),

                if (canManageBooking) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => _showManageBookingSheet(
                        context,
                        booking.hotelName,
                        theme,
                        isYellowTheme,
                        booking.id,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'manage_booking'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ] else if (booking.status == 'completed') ...[
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        tooltip: 'rate_now'.tr(),
                        onPressed: () => _showReviewSheet(
                          context,
                          theme,
                          isYellowTheme,
                          booking.hotelId,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.orange.withOpacity(0.12),
                          foregroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.star_rounded, size: 22),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        tooltip: 'report_issue_btn'.tr(),
                        onPressed: () => _showReportSheet(
                          context,
                          theme,
                          isYellowTheme,
                          booking.hotelId,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.12),
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.flag_outlined, size: 22),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetail(
    ThemeData theme,
    IconData icon,
    String label,
    String value,
    {double valueFontSize = 12}
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: valueFontSize,
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatBookingDate(String value) {
    final date = DateTime.tryParse(value);
    if (date == null) return value.isNotEmpty ? value : 'N/A';
    return DateFormat('MMM d, yyyy', 'en').format(date);
  }

  Widget _buildImageFallback() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(child: Icon(Icons.image_not_supported_outlined)),
    );
  }
}
