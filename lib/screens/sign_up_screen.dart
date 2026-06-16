import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// قم بتغيير هذه المسارات بناءً على بنية مشروعك
// import 'package:pluto_ui/cubits/signup_cubit/signup_cubit.dart';
// import 'package:pluto_ui/cubits/signup_cubit/signup_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dobController = TextEditingController(); 
  final _passwordController = TextEditingController();

  String _gender = 'Male';
  XFile? _idPhoto;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0B6B5D),
              onPrimary: Colors.white,
              onSurface: Color(0xFF2E3E41),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF0B6B5D),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _pickIdPhoto(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked == null) return;

    setState(() {
      _idPhoto = picked;
    });
  }

  Future<void> _openIdPhotoOptions() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Pick from Gallery'),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _pickIdPhoto(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text('Take a Photo'),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _pickIdPhoto(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_idPhoto == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload your ID photo Verification')),
        );
        return;
      }

      // هنا يتم استدعاء دالة الـ Cubit لتسجيل الحساب وإرسال البيانات
      // context.read<SignUpCubit>().signUp(
      //   firstName: _firstNameController.text.trim(),
      //   lastName: _lastNameController.text.trim(),
      //   phone: _phoneNumberController.text.trim(),
      //   dob: _dobController.text.trim(),
      //   gender: _gender,
      //   idPhotoPath: _idPhoto!.path,
      //   password: _passwordController.text,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    const bgTop = Color(0xFFE5F3F4);
    const bgBottom = Color(0xFFF3FAFB);
    const teal = Color(0xFF0B6B5D);
    const tealLine = Color(0xFF0B6B5D);
    const cardColor = Color(0xFFEFF6F7);
    const labelColor = Color(0xFF0B6B5D);

    return Scaffold(
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
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: Form(
                      key: _formKey, // ربط الفورم بالمفتاح
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 12),
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Join ',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF35484B),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'BYMA',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      color: teal,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),

                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(26),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 26,
                                  offset: const Offset(0, 12),
                                  color: Colors.black.withOpacity(0.06),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 1. First Name
                                const _FieldLabel(label: 'FIRST NAME', color: labelColor),
                                const SizedBox(height: 8),
                                _CustomFormField(
                                  hint: 'Enter your first name',
                                  icon: Icons.person_outline,
                                  controller: _firstNameController,
                                  validator: (val) => val == null || val.trim().isEmpty ? 'First name is required' : null,
                                ),

                                const SizedBox(height: 14),

                                // 2. Last Name
                                const _FieldLabel(label: 'LAST NAME', color: labelColor),
                                const SizedBox(height: 8),
                                _CustomFormField(
                                  hint: 'Enter your last name',
                                  icon: Icons.person_outline,
                                  controller: _lastNameController,
                                  validator: (val) => val == null || val.trim().isEmpty ? 'Last name is required' : null,
                                ),

                                const SizedBox(height: 14),

                                // 3. Phone Number
                                const _FieldLabel(label: 'PHONE NUMBER', color: labelColor),
                                const SizedBox(height: 8),
                                _CustomFormField(
                                  hint: '+963 xxxxxxxxx',
                                  icon: Icons.phone_outlined,
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {
                                    if (val == null || val.trim().isEmpty) return 'Phone number is required';
                                    if (val.length < 7) return 'Enter a valid phone number';
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 14),

                                // 4. Date of Birth
                                const _FieldLabel(label: 'DATE OF BIRTH', color: labelColor),
                                const SizedBox(height: 8),
                                _CustomFormField(
                                  hint: 'yyyy-mm-dd',
                                  icon: Icons.calendar_today_outlined,
                                  controller: _dobController,
                                  readOnly: true,
                                  onTap: () => _selectDate(context),
                                  validator: (val) => val == null || val.isEmpty ? 'Please select your birth date' : null,
                                ),

                                const SizedBox(height: 14),

                                // 5. Gender Identity
                                const _FieldLabel(label: 'GENDER IDENTITY', color: labelColor),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 14,
                                  runSpacing: 12,
                                  children: [
                                    _GenderChip(
                                      label: 'Male',
                                      selected: _gender == 'Male',
                                      onTap: () => setState(() => _gender = 'Male'),
                                    ),
                                    _GenderChip(
                                      label: 'Female',
                                      selected: _gender == 'Female',
                                      onTap: () => setState(() => _gender = 'Female'),
                                    ),
                                    _GenderChip(
                                      label: 'Other',
                                      selected: _gender == 'Other',
                                      onTap: () => setState(() => _gender = 'Other'),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // 6. ID Photo
                                const _FieldLabel(label: 'ID PHOTO VERIFICATION', color: labelColor),
                                const SizedBox(height: 10),
                                InkWell(
                                  borderRadius: BorderRadius.circular(22),
                                  onTap: _openIdPhotoOptions,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      border: Border.all(
                                        color: tealLine.withOpacity(0.35),
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (_idPhoto != null)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(14),
                                            child: Image.file(
                                              File(_idPhoto!.path),
                                              width: 140,
                                              height: 140,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        else
                                          Container(
                                            width: 56,
                                            height: 56,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF79D7F8),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 18,
                                                  offset: const Offset(0, 10),
                                                  color: teal.withOpacity(0.12),
                                                ),
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.camera_alt_outlined,
                                              size: 26,
                                              color: Colors.white,
                                            ),
                                          ),
                                        const SizedBox(height: 10),
                                        Text(
                                          _idPhoto == null
                                              ? 'Tap to upload Identification'
                                              : 'Selected: ${_idPhoto!.name}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF2E3E41),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Choose from Gallery or Camera',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF6B7A7E),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 14),

                                // 7. Password
                                const _FieldLabel(label: 'SECURE PASSWORD', color: labelColor),
                                const SizedBox(height: 8),
                                _CustomFormField(
                                  hint: '••••••••••••',
                                  icon: Icons.lock_outline,
                                  obscureText: true,
                                  controller: _passwordController,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) return 'Password is required';
                                    if (val.length < 6) return 'Password must be at least 6 characters';
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 18),

                                // زر إنشاء الحساب (يمكن لاحقاً لفه بـ BlocBuilder لتغيير الـ Loading تلقائياً)
                                SizedBox(
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
                                      onPressed: _submitForm, // استدعاء دالة التحقق والتسليم
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Signup',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Icon(Icons.flash_on, size: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                              ],
                            ),
                          ),
                        ],
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
      ),
    );
  }
}

// تحويل الـ Widget إلى FormField يدعم الـ Validation والأخطاء بشكل مريح بصرياً
class _CustomFormField extends StatelessWidget {
  const _CustomFormField({
    required this.hint,
    required this.icon,
    this.obscureText = false,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.keyboardType,
  });

  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF0B6B5D);

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.65),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 12),
          child: Icon(icon, size: 20, color: const Color(0xFF0B6B5D)),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFFB0BEC2),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
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
          borderSide: const BoxConstraints() == null ? BorderSide.none : const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}

class _GenderChip extends StatelessWidget {
  const _GenderChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF0B6B5D);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: teal.withOpacity(selected ? 1 : 0.45),
            width: 2,
          ),
          color: selected ? teal.withOpacity(0.08) : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: teal,
            ),
          ),
        ),
      ),
    );
  }
}