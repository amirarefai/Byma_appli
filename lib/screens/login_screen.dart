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
    // جلب ألوان وبيانات الثيم الحالي (فاتح أو داكن)
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode 
                ? [theme.scaffoldBackgroundColor, theme.scaffoldBackgroundColor.withOpacity(0.85)]
                : [Colors.white, const Color(0xFFF1FBFF)], 
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  
                  // شعار التطبيق (BYMA)
                  Text(
                    'BYMA',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor, 
                      letterSpacing: -1,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // بطاقة تسجيل الدخول المركزية
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                    decoration: BoxDecoration(
                      color: theme.cardColor, 
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode ? Colors.black26 : Colors.black.withOpacity(0.06),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // عنوان البطاقة مترجم
                          Text(
                            'welcome_back'.tr(), 
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: theme.textTheme.titleLarge?.color,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'login_subtitle'.tr(),
                            style: TextStyle(
                              fontSize: 14,
                              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          
                          const SizedBox(height: 45),
                          
                          // حقل الإيميل
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
                          
                          const SizedBox(height: 25),
                          
                          // حقل كلمة المرور 
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
                          
                          // رابط كلمة المرور المنسية
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // منطق استعادة كلمة المرور
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'forgot_password'.tr(),
                                style: TextStyle(
                                  color: theme.colorScheme.secondary, 
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // زر تسجيل الدخول الأساسي
                          BymaButton(
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
                          
                          const SizedBox(height: 25),
                          
                          // رابط إنشاء حساب جديد
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'dont_have_account'.tr(),
                                  style: TextStyle(
                                    color: theme.textTheme.bodyMedium?.color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
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
                                    style: TextStyle(
                                      color: theme.primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}

// عنصر إدخال مخصص يدعم اللغات والثيم تلقائياً
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
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword && isPasswordObscured,
      keyboardType: keyboardType,
      style: TextStyle(
        color: theme.textTheme.bodyLarge?.color,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label, // يدعم الـ RTL والـ LTR تلقائياً حسب لغة الجهاز
        labelStyle: TextStyle(
          color: theme.hintColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: TextStyle(
          color: theme.hintColor.withOpacity(0.6),
          fontSize: 15,
        ),
        prefixIcon: Icon(
          icon,
          color: theme.iconTheme.color?.withOpacity(0.7) ?? theme.primaryColor,
          size: 22, 
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: theme.hintColor,
                ),
                onPressed: onVisibilityToggle,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.dividerColor, width: 1.5), 
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primaryColor, width: 2.2), 
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 1.8), 
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2.2),
        ),
      ),
    );
  }
}

// زر مخصص متناسق مع الثيم
class BymaButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BymaButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: theme.colorScheme.onPrimary, 
          elevation: 4,
          shadowColor: theme.primaryColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(width: 8),
            // قمنا بإزالة السهم الثابت أو يمكنك تركه، لكن يفضل بالترجمة البرمجية تركه يتجه مع اتجاه النص
            const Icon(
              Icons.arrow_forward_rounded,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}