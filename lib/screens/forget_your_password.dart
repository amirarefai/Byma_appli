import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // تأكد من تثبيت الحزمة في pubspec.yaml

import 'login_screen.dart' show BymaGradientButton, BymaCustomInput;
import 'main_layout_screen.dart';

// --- شاشة استعادة كلمة المرور المحدثة بالحقول الثلاثة والتحقق الإلزامي ---
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _forgetFormKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isNewPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void dispose() {
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // تعديل الدالة لتصبح async لحفظ الجلسة والانتقال الصحيح
  void _submitReset() async {
    if (_forgetFormKey.currentState!.validate()) {
      
      // 1. حفظ حالة الدخول في ذاكرة الجهاز لكي لا تعود شاشة الـ Splash لطردك
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true); // نضع القيمة true لتأكيد الدخول
      } catch (e) {
        debugPrint("خطأ في حفظ الجلسة: $e");
      }

      // 2. إظهار رسالة النجاح
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تحديث كلمة المرور بنجاح، جاري الدخول...'),
            backgroundColor: Color(0xFF0B6B5D),
          ),
        );
      }

      // 3. تصفير الـ Stack بالكامل والانتقال فوراً للـ الهوم (MainLayoutScreen)
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainLayoutScreen(),
          ),
          (route) => false, // يحذف الـ Login والـ Forget تماماً من الذاكرة
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const bgTop = Color(0xFFE5F3F4);
    const bgBottom = Color(0xFFF3FAFB);
    const teal = Color(0xFF0B6B5D);
    const cardColor = Color(0xFFEFF6F7);
    const textDarkColor = Color(0xFF35484B);

    return Scaffold(
      backgroundColor: bgBottom,
      appBar: AppBar(
        backgroundColor: bgTop,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: teal),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bgTop, bgBottom],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxW = constraints.maxWidth.clamp(320.0, 520.0);

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 26,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _forgetFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'إعادة تعيين كلمة المرور',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: textDarkColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'يرجى تعبئة الحقول الإلزامية لتحديث كلمة المرور الخاصة بك.',
                              style: TextStyle(
                                fontSize: 14,
                                color: textDarkColor.withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 30),

                            // الحقل الأول: الرمز الرقمي
                            BymaCustomInput(
                              controller: _codeController,
                              label: 'الرمز الرقمي',
                              hintText: 'أدخل الرمز المستلم',
                              icon: Icons.lock_clock_outlined,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'حقل الرمز إجباري';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),

                            // الحقل الثاني: كلمة السر الجديدة
                            BymaCustomInput(
                              controller: _newPasswordController,
                              label: 'كلمة السر الجديدة',
                              hintText: '************',
                              icon: Icons.lock_outline_rounded,
                              isPassword: true,
                              isPasswordObscured: _isNewPasswordObscured,
                              onVisibilityToggle: () {
                                setState(() {
                                  _isNewPasswordObscured = !_isNewPasswordObscured;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'حقل كلمة السر الجديدة إجباري';
                                }
                                if (value.length < 6) {
                                  return 'كلمة السر يجب أن لا تقل عن 6 أحرف';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),

                            // الحقل الثالث: تأكيد كلمة السر الجديدة
                            BymaCustomInput(
                              controller: _confirmPasswordController,
                              label: 'تأكيد كلمة السر الجديدة',
                              hintText: '************',
                              icon: Icons.gpp_good_outlined,
                              isPassword: true,
                              isPasswordObscured: _isConfirmPasswordObscured,
                              onVisibilityToggle: () {
                                setState(() {
                                  _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'حقل تأكيد كلمة السر إجباري';
                                }
                                if (value != _newPasswordController.text) {
                                  return 'كلمتا السر غير متطابقتين';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 35),

                            // زر تحديث ودخول الفوري
                            BymaGradientButton(
                              text: 'تحديث ودخول',
                              onPressed: _submitReset,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}