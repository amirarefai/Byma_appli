import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';  
import '../widgets/byma_bottom_nav.dart';
import 'main_layout_screen.dart';
import 'messages_final_navigation.dart'; 
import 'settings_refined_screen.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  String _selectedTab = 'All Stays';

  // 1️⃣ واجهة إدارة الحجز (تعديل التاريخ أو الإلغاء) - للحجوزات القادمة
  void _showManageBookingSheet(BuildContext context, String title, ThemeData theme, bool isYellowTheme) {
    final messenger = ScaffoldMessenger.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: theme.dividerColor, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              Text('manage_booking_label'.tr(), style: TextStyle(fontSize: 12, color: theme.colorScheme.tertiary)),
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.secondary)),
              const SizedBox(height: 24),
              
              // خيار تعديل التاريخ
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.calendar_month, color: theme.colorScheme.primary),
                title: Text('edit_date_label'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    Navigator.pop(context); // إغلاق آمن
                    messenger.showSnackBar(SnackBar(content: Text('date_updated_success'.tr())));
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
                  Navigator.pop(context);
                  messenger.showSnackBar(SnackBar(content: Text('cancel_request_sent'.tr())));
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // 2️⃣ واجهة التقييم والبلاغات المارنة - للحجوزات المكتملة
  void _showReviewAndReportSheet(BuildContext context, String title, ThemeData theme, bool isYellowTheme) {
    int currentRating = 5;
    bool isReporting = false; // التحكم في ظهور حقل الوصف
    final reportController = TextEditingController();
    final messenger = ScaffoldMessenger.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24, right: 24, top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: theme.dividerColor, borderRadius: BorderRadius.circular(2)))),
                    const SizedBox(height: 20),
                    Text('rate_stay_title'.tr(), style: TextStyle(fontSize: 12, color: theme.colorScheme.tertiary)),
                    Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.colorScheme.secondary)),
                    const SizedBox(height: 24),
                    
                    // اختيار النجوم
                    Text('how_was_stay'.tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            index < currentRating ? Icons.star_rounded : Icons.star_border_rounded,
                            color: Colors.amber, size: 38,
                          ),
                          onPressed: () => setSheetState(() => currentRating = index + 1),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    
                    // زر التبديل للإبلاغ
                    if (!isReporting) 
                      TextButton.icon(
                        onPressed: () => setSheetState(() => isReporting = true),
                        icon: const Icon(Icons.report_problem_outlined, color: Colors.redAccent, size: 20),
                        label: Text('report_issue_btn'.tr(), style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                      ),

                    // حقل الديسكربشن (يظهر فقط إذا كبس إبلاغ)
                    if (isReporting) ...[
                      const SizedBox(height: 10),
                      Text('report_hint'.tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 10),
                      TextField(
                        controller: reportController,
                        maxLines: 3,
                        style: TextStyle(color: theme.colorScheme.secondary),
                        decoration: InputDecoration(
                          hintText: 'report_field_hint'.tr(),
                          hintStyle: TextStyle(color: theme.colorScheme.tertiary.withOpacity(0.5), fontSize: 13),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    
                    // زر الإرسال الديناميكي
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isYellowTheme ? Colors.yellow : theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          final rText = reportController.text;
                          Navigator.pop(context);
                          if (isReporting && rText.isNotEmpty) {
                            messenger.showSnackBar(SnackBar(content: Text('report_sent_success'.tr())));
                          } else {
                            messenger.showSnackBar(SnackBar(content: Text('thanks_for_rating'.tr(args: [currentRating.toString()]))));
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                        child: Text(
                          isReporting ? 'submit_report'.tr() : 'submit_rating'.tr(),
                          style: TextStyle(fontWeight: FontWeight.bold, color: isYellowTheme ? Colors.black : Colors.white, fontSize: 15),
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
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, 
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الهيدر العلوي (تمت إزالة زر الجرس وإبقاء مساحة فارغة للتوازن)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, size: 20, color: theme.iconTheme.color), 
                    onPressed: () => Navigator.maybePop(context)
                  ),
                  Text(
                    'BYMA', 
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: theme.colorScheme.primary, letterSpacing: 1.2)
                  ),
                  const SizedBox(width: 48), // مساحة بديلة لزر الجرس الملغي للحفاظ على توسط كلمة BYMA
                ],
              ),
            ),

            // العناوين الترحيبية
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('journey_history'.tr(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: theme.colorScheme.secondary, letterSpacing: 1.1)),
                  const SizedBox(height: 4),
                  Text('your_stays'.tr(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: theme.colorScheme.primary)),
                  const SizedBox(height: 6),
                  Text('stays_subtitle'.tr(), style: TextStyle(fontSize: 14, color: theme.colorScheme.tertiary, height: 1.4)),
                ],
              ),
            ),

            // أزرار الفلترة الأفقية
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    _buildTabButton('All Stays', 'all_stays'.tr(), theme),
                    const SizedBox(width: 10),
                    _buildTabButton('Upcoming', 'upcoming_tab'.tr(), theme),
                    const SizedBox(width: 10),
                    _buildTabButton('Completed', 'completed_tab'.tr(), theme),
                  ],
                ),
              ),
            ),

            // قائمة البطاقات
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                children: [
                  if (_selectedTab == 'All Stays' || _selectedTab == 'Upcoming') ...[
                    _buildBookingCard(
                      context: context,
                      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
                      tag: 'upcoming_tag'.tr(),
                      location: 'santorini_greece'.tr(),
                      title: 'azure_horizon'.tr(),
                      checkIn: 'Oct 12, 2024', 
                      nights: '5_nights'.tr(),
                      isUpcoming: true,
                      theme: theme,
                    ),
                  ],
                  if (_selectedTab == 'All Stays' || _selectedTab == 'Completed') ...[
                    _buildBookingCard(
                      context: context,
                      imageUrl: 'https://images.unsplash.com/photo-1510798831971-661eb04b3739?auto=format&fit=crop&w=800&q=80',
                      tag: 'completed_tag'.tr(),
                      location: 'oslo_norway'.tr(),
                      title: 'nordic_pine'.tr(),
                      checkIn: '',
                      nights: '',
                      isUpcoming: false,
                      theme: theme,
                    ),
                  ],
                  const SizedBox(height: 120), 
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BymaBottomNav(
        activeTab: BymaBottomNavTab.bookings,
        onTabSelected: (tab) {
          // أضف منطق التنقل هنا عند الحاجة
        },
      ),
    );
  }

  Widget _buildTabButton(String key, String label, ThemeData theme) {
    final isActive = _selectedTab == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? theme.colorScheme.primary : theme.cardColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isActive ? Colors.transparent : theme.dividerColor),
        ),
        child: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isActive ? Colors.white : theme.colorScheme.secondary)),
      ),
    );
  }

  Widget _buildBookingCard({
    required BuildContext context,
    required String imageUrl,
    required String tag,
    required String location,
    required String title,
    required String checkIn,
    required String nights,
    required bool isUpcoming,
    required ThemeData theme,
  }) {
    final isYellowTheme = theme.colorScheme.primary == Colors.yellow;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            child: Image.network(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(location.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: theme.colorScheme.primary)),
                const SizedBox(height: 6),
                Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: theme.colorScheme.secondary)),
                if (isUpcoming) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => _showManageBookingSheet(context, title, theme, isYellowTheme),
                      style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: Text('manage_booking'.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: () => _showReviewAndReportSheet(context, title, theme, isYellowTheme),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('rate_now'.tr(), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: theme.colorScheme.primary)),
                        const Icon(Icons.arrow_forward_ios, size: 12),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}