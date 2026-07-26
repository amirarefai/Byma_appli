import 'dart:io';
import 'package:byma_app/business_logic/customer_register/cubit/customer_register_cubit.dart';
import 'package:byma_app/business_logic/customer_register/cubit/customer_register_state.dart';
import 'package:byma_app/data/models/customer_register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  // متغيرات الصور (إجبارية)
  XFile? _profileImage;
  XFile? _idPhoto;

  // متغيرات لحفظ حالة الخطأ للصور لعرض إطار أحمر عند الخطأ
  bool _profileImageHasError = false;
  bool _idPhotoHasError = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source, bool isProfileImage) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked == null) return;

    setState(() {
      if (isProfileImage) {
        _profileImage = picked;
        _profileImageHasError = false; // إلغاء حالة الخطأ عند اختيار صورة
      } else {
        _idPhoto = picked;
        _idPhotoHasError = false; // إلغاء حالة الخطأ عند اختيار صورة
      }
    });
  }

  Future<void> _showPhotoOptions({required bool isProfileImage}) async {
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
                    _pickImage(ImageSource.gallery, isProfileImage);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text('Take a Photo'),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _pickImage(ImageSource.camera, isProfileImage);
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
    setState(() {
      _profileImageHasError = _profileImage == null;
      _idPhotoHasError = _idPhoto == null;
    });

    if (!_formKey.currentState!.validate() ||
        _profileImageHasError ||
        _idPhotoHasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields and upload images'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final model = CustomerRegisterModel(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      phone: _phoneNumberController.text.trim(),
      profileImage: File(_profileImage!.path),
      idImage: File(_idPhoto!.path),
    );

    context.read<CustomerRegisterCubit>().registerCustomer(model);
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: BlocConsumer<CustomerRegisterCubit, CustomerRegisterState>(
                      listener: (context, state) {
                        state.when(
                          initial: () {},
                          loading: () {},
                          success: (message) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                          error: (message) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          },
                        );
                      },
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );

                        return Form(
                          key: _formKey,
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
                                    // قسم صورة البروفايل الإلزامية
                                    Center(
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () => _showPhotoOptions(
                                                  isProfileImage: true,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      // تلوين الإطار بالأحمر في حال عدم رفع الصورة وضغط حفظ
                                                      color:
                                                          _profileImageHasError
                                                          ? Colors.redAccent
                                                          : teal.withOpacity(
                                                              0.3,
                                                            ),
                                                      width: 3,
                                                    ),
                                                  ),
                                                  child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundColor: teal
                                                        .withOpacity(0.1),
                                                    backgroundImage:
                                                        _profileImage != null
                                                        ? FileImage(
                                                            File(
                                                              _profileImage!
                                                                  .path,
                                                            ),
                                                          )
                                                        : null,
                                                    child: _profileImage == null
                                                        ? const Icon(
                                                            Icons
                                                                .person_outline,
                                                            size: 50,
                                                            color: teal,
                                                          )
                                                        : null,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      _showPhotoOptions(
                                                        isProfileImage: true,
                                                      ),
                                                  child: const CircleAvatar(
                                                    radius: 16,
                                                    backgroundColor: teal,
                                                    child: Icon(
                                                      Icons.camera_alt_outlined,
                                                      size: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (_profileImageHasError) ...[
                                            const SizedBox(height: 6),
                                            const Text(
                                              'Profile photo is required *',
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    // 1. First Name
                                    const _FieldLabel(
                                      label: 'FIRST NAME *',
                                      color: labelColor,
                                    ),
                                    const SizedBox(height: 8),
                                    _CustomFormField(
                                      hint: 'Enter your first name',
                                      icon: Icons.person_outline,
                                      controller: _firstNameController,
                                      validator: (val) =>
                                          val == null || val.trim().isEmpty
                                          ? 'First name is required'
                                          : null,
                                    ),

                                    const SizedBox(height: 14),

                                    // 2. Last Name
                                    const _FieldLabel(
                                      label: 'LAST NAME *',
                                      color: labelColor,
                                    ),
                                    const SizedBox(height: 8),
                                    _CustomFormField(
                                      hint: 'Enter your last name',
                                      icon: Icons.person_outline,
                                      controller: _lastNameController,
                                      validator: (val) =>
                                          val == null || val.trim().isEmpty
                                          ? 'Last name is required'
                                          : null,
                                    ),

                                    const SizedBox(height: 14),

                                    // 3. Email Address
                                    const _FieldLabel(
                                      label: 'EMAIL ADDRESS *',
                                      color: labelColor,
                                    ),
                                    const SizedBox(height: 8),
                                    _CustomFormField(
                                      hint: 'example@domain.com',
                                      icon: Icons.email_outlined,
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (val) {
                                        if (val == null || val.trim().isEmpty)
                                          return 'Email is required';
                                        final emailRegex = RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                        );
                                        if (!emailRegex.hasMatch(val.trim()))
                                          return 'Enter a valid email address';
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 14),

                                    // 4. Phone Number (تم تعديل التحقق ليصبح إجباري وصارم)
                                    const _FieldLabel(
                                      label: 'PHONE NUMBER *',
                                      color: labelColor,
                                    ),
                                    const SizedBox(height: 8),
                                    _CustomFormField(
                                      hint: '+963 xxxxxxxxx',
                                      icon: Icons.phone_outlined,
                                      controller: _phoneNumberController,
                                      keyboardType: TextInputType.phone,
                                      validator: (val) {
                                        if (val == null || val.trim().isEmpty) {
                                          return 'Phone number is required *';
                                        }
                                        if (val.trim().length < 9) {
                                          return 'Please enter a valid complete phone number';
                                        }
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 14),

                                    // 5. ID Photo (إجباري مع تغيير لون الحدود عند الخطأ)
                                    const _FieldLabel(
                                      label: 'ID PHOTO VERIFICATION *',
                                      color: labelColor,
                                    ),
                                    const SizedBox(height: 10),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(22),
                                      onTap: () => _showPhotoOptions(
                                        isProfileImage: false,
                                      ),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            22,
                                          ),
                                          border: Border.all(
                                            color: _idPhotoHasError
                                                ? Colors.redAccent
                                                : tealLine.withOpacity(0.35),
                                            width: _idPhotoHasError ? 2.5 : 2,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (_idPhoto != null)
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(14),
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
                                                  color: _idPhotoHasError
                                                      ? Colors.redAccent
                                                            .withOpacity(0.2)
                                                      : const Color(0xFF79D7F8),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 26,
                                                  color: _idPhotoHasError
                                                      ? Colors.redAccent
                                                      : Colors.white,
                                                ),
                                              ),
                                            const SizedBox(height: 10),
                                            Text(
                                              _idPhoto == null
                                                  ? (_idPhotoHasError
                                                        ? 'ID Photo is required *'
                                                        : 'Tap to upload Identification')
                                                  : 'Selected: ${_idPhoto!.name}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: _idPhotoHasError
                                                    ? Colors.redAccent
                                                    : const Color(0xFF2E3E41),
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

                                    // 6. Password
                                    const _FieldLabel(
                                      label: 'SECURE PASSWORD *',
                                      color: labelColor,
                                    ),
                                    const SizedBox(height: 8),
                                    _CustomFormField(
                                      hint: '••••••••••••',
                                      icon: Icons.lock_outline,
                                      obscureText: true,
                                      controller: _passwordController,
                                      validator: (val) {
                                        if (val == null || val.isEmpty)
                                          return 'Password is required';
                                        if (val.length < 6)
                                          return 'Password must be at least 6 characters';
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 18),

                                    // زر الحفظ والتسجيل
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
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 18,
                                              offset: const Offset(0, 10),
                                              color: teal.withOpacity(0.22),
                                            ),
                                          ],
                                        ),
                                        child: TextButton(
                                          onPressed: isLoading
                                              ? null
                                              : _submitForm,
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.zero,
                                          ),
                                          child: isLoading
                                              ? const SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2,
                                                      ),
                                                )
                                              : const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Signup',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        letterSpacing: 0.2,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Icon(
                                                      Icons.flash_on,
                                                      size: 20,
                                                    ),
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
                        );
                      },
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
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
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
          borderSide: BorderSide(
            color: borderColor.withOpacity(0.15),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: borderColor.withOpacity(0.15),
            width: 1,
          ),
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
