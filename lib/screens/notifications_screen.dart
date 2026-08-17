import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;

    // قائمة تجريبية للإشعارات (يمكنك استبدالها ببيانات من السيرفر لاحقاً)
    final List<Map<String, String>> notifications = [
      {
        "title": "booking_confirmed_title".tr(),
        "body": "booking_confirmed_body".tr(),
        "time": "now".tr(),
        "type": "booking"
      },
      {
        "title": "special_offer_title".tr(),
        "body": "special_offer_body".tr(),
        "time": "2h_ago".tr(),
        "type": "offer"
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: isDarkMode ? Colors.white : Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'notifications_title'.tr(),
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey.withOpacity(0.4)),
                  const SizedBox(height: 16),
                  Text('no_notifications'.tr(), style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                IconData iconData = Icons.notifications_outlined;
                Color iconBgColor = const Color(0xFF62CDFF).withOpacity(0.15);
                Color iconColor = const Color(0xFF62CDFF);

                if (item['type'] == 'booking') {
                  iconData = Icons.bookmark_added_outlined;
                  iconBgColor = const Color(0xFF0FA37A).withOpacity(0.15);
                  iconColor = const Color(0xFF0FA37A);
                } else if (item['type'] == 'offer') {
                  iconData = Icons.local_offer_outlined;
                  iconBgColor = Colors.amber.withOpacity(0.15);
                  iconColor = Colors.amber;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDarkMode ? 0.1 : 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
                        child: Icon(iconData, color: iconColor, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'] ?? '',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: isDarkMode ? Colors.white : Colors.black87),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['body'] ?? '',
                              style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.4, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['time'] ?? '',
                              style: TextStyle(fontSize: 11, color: isDarkMode ? Colors.white38 : Colors.black38, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}