import 'package:flutter/material.dart';

import '../constance/app_colors.dart';
import 'main_layout_screen.dart';
import 'sign_up_screen.dart';

// ألوان Login حسب AppTheme
const Color bymaPrimaryColor = AppTheme.kPrimaryColor;
const Color bymaSecondaryColor = AppTheme.kBackgroundColor;
const Color bymaTextColor = AppTheme.kTextColor;
const Color bymaHintTextColor = AppTheme.kSubTextColor;
const Color bymaAccentColor = AppTheme.kSecondaryColor;


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // للتحقق من الأخطاء في حقول الإدخال
  final _formKey = GlobalKey<FormState>();
  
  // وحدات التحكم لاستخراج النصوص عند الحاجة
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // لإخفاء/إظهار كلمة المرور
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF1FBFF)], 
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
                  
                  // شعار BYMA في الأعلى
                  const Text(
                    'BYMA',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF01A7A7), 
                      letterSpacing: -1,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // بطاقة تسجيل الدخول المركزية بظل
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
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
                          // عنوان البطاقة
                          const Text(
                            'Welcome back',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: bymaTextColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Access your curated dashboard',
                            style: TextStyle(
                              fontSize: 14,
                              color: bymaTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          
                          const SizedBox(height: 45),
                          
                          // حقل الإيميل بحدود مخصصة وعلامة مدمجة
                          BymaCustomInput(
                            controller: _emailController,
                            label: 'EMAIL',
                            hintText: 'email',
                            icon: Icons.person_outline_rounded,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 25),
                          
                          // حقل كلمة المرور 
                          BymaCustomInput(
                            controller: _passwordController,
                            label: 'PASSWORD', 
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
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
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
                                // إضافة منطق استعادة كلمة المرور
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Forgotten your key?',
                                style: TextStyle(
                                  color: bymaAccentColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // زر تسجيل الدخول الأساسي
                          BymaButton(
  text: 'LOGIN',
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
                                const Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: bymaTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                               GestureDetector(
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(), // تأكدي من إزالة const إذا استمر الخطأ
      ),
    );
  },
                                  child: const Text(
                                    'Register Now',
                                    style: TextStyle(
                                      color: bymaPrimaryColor,
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

// عنصر إدخال مخصص مُعدل لدعم الـ Validation والـ Controllers
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
    return Stack(
      clipBehavior: Clip.none, 
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: isPassword && isPasswordObscured,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: bymaTextColor,
            fontSize: 16,
            height: 1.2,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: bymaHintTextColor,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
            prefixIcon: Container(
              padding: const EdgeInsets.only(left: 14, right: 10),
              child: Icon(
                icon,
                color: bymaTextColor.withOpacity(0.8),
                size: 22, 
              ),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: bymaTextColor.withOpacity(0.5),
                    ),
                    onPressed: onVisibilityToggle,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.5), 
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: bymaPrimaryColor, width: 2.2), 
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.8), 
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2.2),
            ),
          ),
        ),
        
        // التسمية العلوية (Label)
        Positioned(
          left: 14,
          top: -9, 
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Text(
              label,
              style: const TextStyle(
                color: bymaHintTextColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// زر BYMA الأساسي
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
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bymaPrimaryColor,
          elevation: 5,
          shadowColor: bymaPrimaryColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}