import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // استيراد حزمة الترجمة

import 'main_layout_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'BY',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: textDarkColor,
                                    letterSpacing: -1,
                                  ),
                                ),
                                TextSpan(
                                  text: 'MA',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w900,
                                    color: teal,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        Container(
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
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'welcome_back'.tr(), 
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: textDarkColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'login_subtitle'.tr(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textDarkColor.withOpacity(0.7),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 35),
                                BymaCustomInput(
                                  controller: _emailController,
                                  label: 'email_label'.tr().toUpperCase(),
                                  hintText: 'email_hint'.tr(),
                                  icon: Icons.person_outline_rounded,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'email_empty_error'.tr();
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                                      return 'email_invalid_error'.tr();
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 18),
                                BymaCustomInput(
                                  controller: _passwordController,
                                  label: 'password_label'.tr().toUpperCase(), 
                                  hintText: '************',
                                  icon: Icons.lock_outline_rounded,
                                  isPassword: true,
                                  isPasswordObscured: _isPasswordObscured,
                                  onVisibilityToggle: () {
                                    setState(() {
                                      _isPasswordObscured = !_isPasswordObscured;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'password_empty_error'.tr();
                                    }
                                    if (value.length < 6) {
                                      return 'password_length_error'.tr();
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // الانتقال إلى شاشة استعادة كلمة المرور المحدثة
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const ForgetPasswordScreen(),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'forgot_password'.tr(),
                                      style: const TextStyle(
                                        color: teal, 
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                BymaGradientButton(
                                  text: 'login_button'.tr(),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => const MainLayoutScreen(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'dont_have_account'.tr(),
                                        style: const TextStyle(
                                          color: textDarkColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => const SignUpScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'register_now'.tr(),
                                          style: const TextStyle(
                                            color: teal,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
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

  void _submitReset() {
    if (_forgetFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم تحديث كلمة المرور بنجاح ولتأكيد الدخول'),
          backgroundColor: Color(0xFF0B6B5D),
        ),
      );
      Navigator.of(context).pop(); // العودة لشاشة تسجيل الدخول بعد النجاح
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

                            // زر تحديث ودخول
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

// الحقول والأزرار المخصصة التي تستخدمها الشاشتان
class BymaCustomInput extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final bool isPasswordObscured;
  final VoidCallback? onVisibilityToggle;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const BymaCustomInput({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.isPasswordObscured = false,
    this.onVisibilityToggle,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF0B6B5D);
    
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword && isPasswordObscured,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.65),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        labelText: label,
        labelStyle: const TextStyle(
          color: borderColor,
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFB0BEC2),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 12),
          child: Icon(icon, size: 20, color: borderColor),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: borderColor.withOpacity(0.6),
                ),
                onPressed: onVisibilityToggle,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: borderColor.withOpacity(0.15), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: borderColor.withOpacity(0.15), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}

class BymaGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BymaGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF0B6B5D);

    return SizedBox(
      width: double.infinity,
      height: 62,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF075A4C),
              Color(0xFF79D7F8),
            ],
          ),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              blurRadius: 18,
              offset: const Offset(0, 10),
              color: teal.withOpacity(0.22),
            ),
          ],
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: EdgeInsets.zero,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.flash_on, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}