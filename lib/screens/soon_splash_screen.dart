import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SoonSplashScreen extends StatefulWidget {
  final String title;
  final IconData icon;

  const SoonSplashScreen({super.key, required this.title, required this.icon});

  @override
  State<SoonSplashScreen> createState() => _SoonSplashScreenState();
}

class _SoonSplashScreenState extends State<SoonSplashScreen> with SingleTickerProviderStateMixin {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    // بدء الحركة مباشرة بعد بناء الواجهة وتكرارها بشكل مستمر
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimation();
    });
  }

  void _startAnimation() async {
    while (mounted) {
      setState(() {
        _animate = !_animate;
      });
      // دقة وقت الحركة (ثانية ونصف لكل نبضة)
      await Future.delayed(const Duration(milliseconds: 1500));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode 
              ? [const Color(0xFF1E1E1E), const Color(0xFF000000)]
              : [const Color(0xFFFDFDFD), const Color(0xFFF1F5F9)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // زر العودة
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          if(!isDarkMode)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded, 
                        size: 18,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              
              const Spacer(),

              // منطقة الأيقونة
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(widget.icon, size: 55, color: primaryColor),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // اسم القسم
              Text(
                widget.title.toUpperCase(),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: isDarkMode ? Colors.white : const Color(0xFF0F172A),
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 20),

              // 🌟 كبسولة "قريباً" المتحركة (تأثير النبض والتلاشي) 🌟
              AnimatedScale(
                scale: _animate ? 1.08 : 0.95,
                duration: const Duration(milliseconds: 1400),
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  opacity: _animate ? 1.0 : 0.6,
                  duration: const Duration(milliseconds: 1400),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF62CDFF),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF62CDFF).withOpacity(_animate ? 0.4 : 0.15),
                          blurRadius: _animate ? 20 : 10,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: Text(
                      'coming_soon'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // نص توضيحي
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'we_are_working_hard'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white54 : Colors.black54,
                    fontSize: 14,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}