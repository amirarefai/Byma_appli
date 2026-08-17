import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('notifications_title'.tr())),
      body: const Center(child: Text('شاشة الإشعارات')),
    );
  }
}

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHighContrast = theme.colorScheme.primary == Colors.yellow;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      // تم إلغاء كافة الخصائص المسببة للتداخل السفلي
      extendBody: false, 
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'glass_pavilion_title'.tr(), 
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.primary,
                fontSize: 18,
                height: 1.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              'property_enquiry'.tr(),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.secondary,
                fontSize: 11,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_outlined, color: theme.colorScheme.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsScreen()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: const AssetImage('assets/images/property_1.jpg'),
              backgroundColor: theme.cardColor,
            ),
          ),
        ],
      ),
      // إجبار واجهة المحادثة وحقل النص على تعبئة المساحة بالكامل داخل الـ Stack
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 80), // مسافة حشو سفلية إضافية لمنع تداخل الرسائل مع شريط الشات
                    children: [
                      _ChatDateChip(text: 'today'.tr()),
                      const SizedBox(height: 18),
                      _BubbleLeft(
                        text: "chat_msg_1".tr(),
                        time: 'chat_time_1'.tr(),
                      ),
                      const SizedBox(height: 14),
                      _BubbleRight(
                        text: "chat_msg_2".tr(),
                        time: 'chat_time_2'.tr(),
                      ),
                      const SizedBox(height: 18),
                      _PropertyCard(
                        title: 'glass_pavilion_title'.tr(),
                        subtitle: 'property_subtitle_format'.tr(args: [
                          '4',
                          '2',
                          'private_deck'.tr()
                        ]),
                        tags: ['verified_tag'.tr(), 'featured_tag'.tr()],
                      ),
                      const SizedBox(height: 18),
                      _BubbleLeft(
                        text: "chat_msg_3".tr(),
                        time: 'chat_time_3'.tr(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // وضع شريط الشات داخل Positioned ثابت في القاع لكي يغطي ويحجب أي شريط مكرر يظهر من الخلفية
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: theme.scaffoldBackgroundColor, // خلفية كاملة مصمتة لمنع الشفافية
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Icon(Icons.add, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: theme.dividerColor),
                        ),
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(color: theme.colorScheme.primary),
                          decoration: InputDecoration(
                            hintText: 'type_message_hint'.tr(),
                            hintStyle: TextStyle(
                              color: theme.colorScheme.tertiary,
                              fontWeight: FontWeight.w700,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        if (_controller.text.trim().isNotEmpty) {
                          setState(() => _controller.clear());
                        }
                      },
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.send, 
                          color: isHighContrast ? Colors.black : Colors.white, 
                          size: 22
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// الكلاسات المساعدة المتبقية (تظل كما هي بدون تغيير)
class _ChatDateChip extends StatelessWidget {
  final String text;
  const _ChatDateChip({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: theme.dividerColor.withOpacity(0.5)),
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: theme.colorScheme.secondary,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class _BubbleLeft extends StatelessWidget {
  final String text;
  final String time;
  const _BubbleLeft({required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.primary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              time,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BubbleRight extends StatelessWidget {
  final String text;
  final String time;
  const _BubbleRight({required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHighContrast = theme.colorScheme.primary == Colors.yellow;

    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: isHighContrast ? Colors.black : const Color(0xFF2E97C9),
              borderRadius: BorderRadius.circular(22),
              border: isHighContrast ? Border.all(color: Colors.white, width: 1.5) : null,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.5,
                fontWeight: isHighContrast ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              time,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> tags;

  const _PropertyCard({
    required this.title,
    required this.subtitle,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHighContrast = theme.colorScheme.primary == Colors.yellow;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: tags.map((t) {
                final bool isVerified = t == 'verified_tag'.tr();
                final Color pillBg = isHighContrast 
                    ? Colors.black 
                    : (isVerified ? const Color(0xFF6EE7B7).withOpacity(0.2) : const Color(0xFF60A5FA).withOpacity(0.2));

                final Color pillText = isHighContrast 
                    ? (isVerified ? Colors.greenAccent : Colors.lightBlueAccent)
                    : (isVerified ? const Color(0xFF0F7A54) : const Color(0xFF1D4ED8));

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: pillBg,
                    borderRadius: BorderRadius.circular(999),
                    border: isHighContrast ? Border.all(color: pillText) : null,
                  ),
                  child: Text(
                    t,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: pillText,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}