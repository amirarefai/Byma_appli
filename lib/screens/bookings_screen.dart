// import 'package:byma_app/business_logic/reports/cubit/reports_cubit.dart';
// import 'package:byma_app/business_logic/reviews/cubit/reviews_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../widgets/byma_bottom_nav.dart';

// class BookingsScreen extends StatefulWidget {
//   const BookingsScreen({super.key});

//   @override
//   State<BookingsScreen> createState() => _BookingsScreenState();
// }

// class _BookingsScreenState extends State<BookingsScreen> {
//   String _selectedTab = 'All Stays';

//   // 1️⃣ واجهة إدارة الحجز (تعديل التاريخ أو الإلغاء) - للحجوزات القادمة
//   void _showManageBookingSheet(BuildContext context, String title, ThemeData theme, bool isYellowTheme) {
//     final messenger = ScaffoldMessenger.of(context);

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
//       builder: (sheetContext) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: theme.dividerColor, borderRadius: BorderRadius.circular(2)))),
//               const SizedBox(height: 20),
//               Text('manage_booking_label'.tr(), style: TextStyle(fontSize: 12, color: theme.colorScheme.tertiary)),
//               Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.secondary)),
//               const SizedBox(height: 24),

//               // خيار تعديل التاريخ
//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: Icon(Icons.calendar_month, color: theme.colorScheme.primary),
//                 title: Text('edit_date_label'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 14),
//                 onTap: () async {
//                   final picked = await showDateRangePicker(
//                     context: sheetContext,
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime.now().add(const Duration(days: 365)),
//                   );
//                   if (picked != null) {
//                     Navigator.pop(sheetContext); // إغلاق آمن
//                     messenger.showSnackBar(SnackBar(content: Text('date_updated_success'.tr())));
//                   }
//                 },
//               ),
//               Divider(color: theme.dividerColor),
//               // خيار إلغاء الحجز
//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: const Icon(Icons.cancel_outlined, color: Colors.redAccent),
//                 title: Text('cancel_booking_label'.tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.redAccent),
//                 onTap: () {
//                   Navigator.pop(sheetContext);
//                   messenger.showSnackBar(SnackBar(content: Text('cancel_request_sent'.tr())));
//                 },
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // 2️⃣ واجهة التقييم والبلاغات - للحجوزات المكتملة ومربوطة بالـ Cubits مباشرة
//   void _showReviewAndReportSheet(
//     BuildContext context,
//     String title,
//     ThemeData theme,
//     bool isYellowTheme,
//     int hotelId,
//   ) {
//     int currentRating = 5;
//     bool isReporting = false;
//     final reportController = TextEditingController();
//     final messenger = ScaffoldMessenger.of(context);

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
//       builder: (sheetContext) {
//         return StatefulBuilder(
//           builder: (builderContext, setSheetState) {
//             return Padding(
//               padding: EdgeInsets.only(
//                 left: 24, right: 24, top: 24,
//                 bottom: MediaQuery.of(builderContext).viewInsets.bottom + 24,
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: theme.dividerColor, borderRadius: BorderRadius.circular(2)))),
//                     const SizedBox(height: 20),
//                     Text('rate_stay_title'.tr(), style: TextStyle(fontSize: 12, color: theme.colorScheme.tertiary)),
//                     Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.secondary)),
//                     const SizedBox(height: 24),

//                     // اختيار النجوم
//                     Text('how_was_stay'.tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: List.generate(5, (index) {
//                         return IconButton(
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                           icon: Icon(
//                             index < currentRating ? Icons.star_rounded : Icons.star_border_rounded,
//                             color: Colors.amber, size: 38,
//                           ),
//                           onPressed: () => setSheetState(() => currentRating = index + 1),
//                         );
//                       }),
//                     ),
//                     const SizedBox(height: 20),

//                     // زر التبديل للإبلاغ
//                     if (!isReporting)
//                       TextButton.icon(
//                         onPressed: () => setSheetState(() => isReporting = true),
//                         icon: const Icon(Icons.report_problem_outlined, color: Colors.redAccent, size: 20),
//                         label: Text('report_issue_btn'.tr(), style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
//                       ),

//                     // حقل النص للتقرير أو للـ Comment الاختياري
//                     const SizedBox(height: 10),
//                     Text(
//                       isReporting ? 'report_hint'.tr() : 'add_comment_optional'.tr(),
//                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                     ),
//                     const SizedBox(height: 10),
//                     TextField(
//                       controller: reportController,
//                       maxLines: 3,
//                       style: TextStyle(color: theme.colorScheme.secondary),
//                       decoration: InputDecoration(
//                         hintText: isReporting ? 'report_field_hint'.tr() : 'comment_field_hint'.tr(),
//                         hintStyle: TextStyle(color: theme.colorScheme.tertiary.withOpacity(0.5), fontSize: 13),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
//                         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(16)),
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     // زر الإرسال المربوط بالـ Cubit
//                     Container(
//                       width: double.infinity,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: isYellowTheme ? Colors.yellow : theme.colorScheme.primary,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           final inputText = reportController.text.trim();
//                           Navigator.pop(sheetContext);

//                           if (isReporting) {
//                             // إرسال بلاغ عبر ReportsCubit
//                             if (inputText.isNotEmpty) {
//                               context.read<ReportsCubit>().createReport(
//                                 hotelId: hotelId,
//                                 reason: inputText,
//                               );
//                               messenger.showSnackBar(SnackBar(content: Text('report_sent_success'.tr())));
//                             }
//                           } else {
//                             // إرسال تقييم عبر ReviewsCubit
//                             context.read<ReviewsCubit>().createReview(
//                               rate: currentRating,
//                               hotelId: hotelId,
//                               comment: inputText.isNotEmpty ? inputText : null,
//                             );
//                             messenger.showSnackBar(SnackBar(content: Text('thanks_for_rating'.tr(args: [currentRating.toString()]))));
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           shadowColor: Colors.transparent,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                         ),
//                         child: Text(
//                           isReporting ? 'submit_report'.tr() : 'submit_rating'.tr(),
//                           style: TextStyle(fontWeight: FontWeight.bold, color: isYellowTheme ? Colors.black : Colors.white, fontSize: 15),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         bottom: false,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // الهيدر العلوي
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.arrow_back_ios_new, size: 20, color: theme.iconTheme.color),
//                     onPressed: () => Navigator.maybePop(context)
//                   ),
//                   Text(
//                     'BYMA',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: theme.colorScheme.primary, letterSpacing: 1.2)
//                   ),
//                   const SizedBox(width: 48),
//                 ],
//               ),
//             ),

//             // العناوين الترحيبية
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('journey_history'.tr(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: theme.colorScheme.secondary, letterSpacing: 1.1)),
//                   const SizedBox(height: 4),
//                   Text('your_stays'.tr(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: theme.colorScheme.primary)),
//                   const SizedBox(height: 6),
//                   Text('stays_subtitle'.tr(), style: TextStyle(fontSize: 14, color: theme.colorScheme.tertiary, height: 1.4)),
//                 ],
//               ),
//             ),

//             // أزرار الفلترة الأفقية
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Row(
//                   children: [
//                     _buildTabButton('All Stays', 'all_stays'.tr(), theme),
//                     const SizedBox(width: 10),
//                     _buildTabButton('Upcoming', 'upcoming_tab'.tr(), theme),
//                     const SizedBox(width: 10),
//                     _buildTabButton('Completed', 'completed_tab'.tr(), theme),
//                   ],
//                 ),
//               ),
//             ),

//             // قائمة البطاقات
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//                 children: [
//                   if (_selectedTab == 'All Stays' || _selectedTab == 'Upcoming') ...[
//                     _buildBookingCard(
//                       context: context,
//                       hotelId: 101, // تم تعيين ID الفندق
//                       imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
//                       tag: 'upcoming_tag'.tr(),
//                       location: 'santorini_greece'.tr(),
//                       title: 'azure_horizon'.tr(),
//                       checkIn: 'Oct 12, 2024',
//                       nights: '5_nights'.tr(),
//                       isUpcoming: true,
//                       theme: theme,
//                     ),
//                   ],
//                   if (_selectedTab == 'All Stays' || _selectedTab == 'Completed') ...[
//                     _buildBookingCard(
//                       context: context,
//                       hotelId: 102, // تم تعيين ID الفندق
//                       imageUrl: 'https://images.unsplash.com/photo-1510798831971-661eb04b3739?auto=format&fit=crop&w=800&q=80',
//                       tag: 'completed_tag'.tr(),
//                       location: 'oslo_norway'.tr(),
//                       title: 'nordic_pine'.tr(),
//                       checkIn: '',
//                       nights: '',
//                       isUpcoming: false,
//                       theme: theme,
//                     ),
//                   ],
//                   const SizedBox(height: 120),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BymaBottomNav(
//         activeTab: BymaBottomNavTab.bookings,
//         onTabSelected: (tab) {},
//       ),
//     );
//   }

//   Widget _buildTabButton(String key, String label, ThemeData theme) {
//     final isActive = _selectedTab == key;
//     return GestureDetector(
//       onTap: () => setState(() => _selectedTab = key),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         decoration: BoxDecoration(
//           color: isActive ? theme.colorScheme.primary : theme.cardColor,
//           borderRadius: BorderRadius.circular(30),
//           border: Border.all(color: isActive ? Colors.transparent : theme.dividerColor),
//         ),
//         child: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isActive ? Colors.white : theme.colorScheme.secondary)),
//       ),
//     );
//   }

//   Widget _buildBookingCard({
//     required BuildContext context,
//     required int hotelId,
//     required String imageUrl,
//     required String tag,
//     required String location,
//     required String title,
//     required String checkIn,
//     required String nights,
//     required bool isUpcoming,
//     required ThemeData theme,
//   }) {
//     final isYellowTheme = theme.colorScheme.primary == Colors.yellow;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)]),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
//             child: Image.network(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(location.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: theme.colorScheme.primary)),
//                 const SizedBox(height: 6),
//                 Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: theme.colorScheme.secondary)),
//                 if (isUpcoming) ...[
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: () => _showManageBookingSheet(context, title, theme, isYellowTheme),
//                       style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
//                       child: Text('manage_booking'.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ] else ...[
//                   const SizedBox(height: 14),
//                   GestureDetector(
//                     onTap: () => _showReviewAndReportSheet(context, title, theme, isYellowTheme, hotelId),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('rate_now'.tr(), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: theme.colorScheme.primary)),
//                         const Icon(Icons.arrow_forward_ios, size: 12),
//                       ],
//                     ),
//                   ),
//                 ]
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:byma_app/business_logic/booking_history/cubit/booking_history_cubit.dart';
import 'package:byma_app/business_logic/booking_history/cubit/booking_history_state.dart';
import 'package:byma_app/business_logic/cancel_booking/cubit/cancel_booking_cubit.dart';
import 'package:byma_app/business_logic/cancel_booking/cubit/cancel_booking_state.dart';
import 'package:byma_app/business_logic/reports/cubit/reports_cubit.dart';
import 'package:byma_app/business_logic/reviews/cubit/reviews_cubit.dart';
import 'package:byma_app/data/models/booking_history_model.dart';
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
    int bookingId
  ) {
    final messenger = ScaffoldMessenger.of(context);

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
                    Navigator.pop(sheetContext); // إغلاق آمن
                    messenger.showSnackBar(
                      SnackBar(content: Text('date_updated_success'.tr())),
                    );
                  }
                },
              ),
              Divider(color: theme.dividerColor),
              // خيار إلغاء الحجز
             ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.cancel_outlined, color: Colors.redAccent),
                title: Text('cancel_booking_label'.tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.redAccent),
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
  void _showReviewAndReportSheet(
    BuildContext context,
    String title,
    ThemeData theme,
    bool isYellowTheme,
    int hotelId,
  ) {
    int currentRating = 5;
    bool isReporting = false;
    final reportController = TextEditingController();
    final messenger = ScaffoldMessenger.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (builderContext, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(builderContext).viewInsets.bottom + 24,
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
                      'rate_stay_title'.tr(),
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

                    // اختيار النجوم
                    Text(
                      'how_was_stay'.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            index < currentRating
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            color: Colors.amber,
                            size: 38,
                          ),
                          onPressed: () =>
                              setSheetState(() => currentRating = index + 1),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),

                    // زر التبديل للإبلاغ
                    if (!isReporting)
                      TextButton.icon(
                        onPressed: () =>
                            setSheetState(() => isReporting = true),
                        icon: const Icon(
                          Icons.report_problem_outlined,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        label: Text(
                          'report_issue_btn'.tr(),
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    // حقل النص للتقرير أو للـ Comment الاختياري
                    const SizedBox(height: 10),
                    Text(
                      isReporting
                          ? 'report_hint'.tr()
                          : 'add_comment_optional'.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: reportController,
                      maxLines: 3,
                      style: TextStyle(color: theme.colorScheme.secondary),
                      decoration: InputDecoration(
                        hintText: isReporting
                            ? 'report_field_hint'.tr()
                            : 'comment_field_hint'.tr(),
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
                    const SizedBox(height: 24),

                    // زر الإرسال المربوط بالـ Cubit
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isYellowTheme
                            ? Colors.yellow
                            : theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          final inputText = reportController.text.trim();
                          Navigator.pop(sheetContext);

                          if (isReporting) {
                            if (inputText.isNotEmpty) {
                              context.read<ReportsCubit>().createReport(
                                hotelId: hotelId,
                                reason: inputText,
                              );
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text('report_sent_success'.tr()),
                                ),
                              );
                            }
                          } else {
                            context.read<ReviewsCubit>().createReview(
                              rate: currentRating,
                              hotelId: hotelId,
                              comment: inputText.isNotEmpty ? inputText : null,
                            );
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'thanks_for_rating'.tr(
                                    args: [currentRating.toString()],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          isReporting
                              ? 'submit_report'.tr()
                              : 'submit_rating'.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isYellowTheme ? Colors.black : Colors.white,
                            fontSize: 15,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 1. ADD BLOC LISTENER HERE
    return BlocListener<CancelBookingCubit, CancelBookingState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {
            // Show a non-dismissible loading dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(child: CircularProgressIndicator()),
            );
          },
          success: () {
            // Close the loading dialog
            Navigator.of(context, rootNavigator: true).pop(); 
            
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('cancel_request_sent'.tr()), backgroundColor: Colors.green),
            );
            
            // Refresh the current bookings list so the cancelled booking disappears
            context.read<BookingHistoryCubit>().fetchBookingHistory(_selectedTabStatus);
          },
          error: (message) {
            // Close the loading dialog
            Navigator.of(context, rootNavigator: true).pop();
            
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
            );
          },
        );
      },
      child: Scaffold(
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
                      _buildTabButton('confirmed', 'confirmed_tab'.tr(), theme),
                      const SizedBox(width: 10),
                      _buildTabButton('active', 'active_tab'.tr(), theme),
                      const SizedBox(width: 10),
                      _buildTabButton('completed', 'completed_tab'.tr(), theme),
                      const SizedBox(width: 10),
                      _buildTabButton('cancelled', 'cancelled_tab'.tr(), theme),
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

    // Only fetch the first image as requested
    final imageUrl = booking.imageUrls.isNotEmpty
        ? booking.imageUrls.first
        : 'assets/images/room-placeholder.jpg';

    // Manageability check depending on backend status
    final canManageBooking =
        booking.status == 'confirmed' || booking.status == 'active';

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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            // Verify if local fallback or network image
            child: imageUrl.startsWith('http')
                ? Image.network(
                    imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
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
                        booking.id

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
                  // Only allow rating for completed bookings
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: () => _showReviewAndReportSheet(
                      context,
                      booking.hotelName,
                      theme,
                      isYellowTheme,
                      booking.hotelId,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'rate_now'.tr(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 12),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
