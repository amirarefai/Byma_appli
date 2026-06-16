import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.nextScreen,
    this.duration = const Duration(milliseconds: 3500), 
  });

  final Duration duration;
  final Widget nextScreen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late AnimationController _controller;
  late Animation<double> _textFade;
  
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    // إعداد متحكم الحركة (الأنيميشن)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 1. ظهور النص تدريجياً
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // 2. انزلاق النص من الأسفل للأعلى
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    // بدء تشغيل الحركة
    _controller.forward();

    // إعداد المؤقت للانتقال للشاشة التالية بعد انتهاء المدة المطلوبة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _timer = Timer(widget.duration, _goNext);
    });
  }

  void _goNext() {
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(builder: (_) => widget.nextScreen),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🎨 تحديث الألوان لتطابق هوية تطبيق BYMA الجديد
    final bgColor = const Color(0xFFF8FDFF);
    final primaryColor = const Color(0xFF01A7A7);
    final textColor = const Color(0xFF2E3D41);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // حركة النص بأكمله
          AnimatedBuilder(
  animation: _controller,
  builder: (context, child) {
    const text = "BYMA";

    final progress =
        ((_controller.value - 0.2) / 0.8).clamp(0.0, 1.0);

    final visibleChars =
        (progress * text.length).floor().clamp(0, text.length);

    return Text(
      text.substring(0, visibleChars),
      style: TextStyle(
        fontSize: 46,
        fontWeight: FontWeight.w900,
        color: primaryColor,
        letterSpacing: 3.0,
        shadows: const [
          Shadow(
            blurRadius: 12,
            offset: Offset(0, 4),
            color: Color(0x0F01A7A7),
          ),
        ],
      ),
    );
  },
),
                const SizedBox(height: 14),

                // الخط الفاصل المتحرك المحدث
                Container(
                  width: 45,
                  height: 2.0,
                  decoration: BoxDecoration(
                    color: textColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 18),

                Text(
                  "ACCESS THE",
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 5,
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),

                Text(
                  "EXTRAORDINARY",
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 5,
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
