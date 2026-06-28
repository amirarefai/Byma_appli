import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart'; // تأكدي من استيراد حزمة الترجمة المستخدمة لديكِ

class ProfileSecurityUpdated extends StatefulWidget {
  const ProfileSecurityUpdated({super.key});

  @override
  State<ProfileSecurityUpdated> createState() => _ProfileSecurityUpdatedState();
}

class _ProfileSecurityUpdatedState extends State<ProfileSecurityUpdated> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _avatarImage;

  // ديمو البيانات المحلية
  String _fullName = 'Alex Curator';
  String _email = 'alex.c@bymatravel.com';
  String _phone = '+1 (555) 0123 4567';
  DateTime _dateOfBirth = DateTime(1988, 3, 24);
  String _gender = 'Male'; 

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _passwordMasked = '••••••••••';
  final _editPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _editPasswordController.dispose();
    super.dispose();
  }

  String _formatDob(DateTime d) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${context.tr(months[d.month - 1])} ${d.day}, ${d.year}';
  }

  Future<void> _pickDob({
    required BuildContext dialogContext,
    required DateTime initialDate,
    required void Function(DateTime newDob) onPicked,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: dialogContext,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 120),
      lastDate: now,
    );
    if (picked == null) return;
    onPicked(picked);
  }

  void _openEditProfileDialog() {
    _fullNameController.text = _fullName;
    _emailController.text = _email;
    _phoneController.text = _phone;
    _editPasswordController.clear();

    String tempGender = _gender;
    DateTime tempDob = _dateOfBirth;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final theme = Theme.of(context);
            return AlertDialog(
              backgroundColor: theme.scaffoldBackgroundColor,
              title: Text(context.tr('edit_profile'), style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: 420,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _fullNameController,
                        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                        decoration: InputDecoration(
                          labelText: context.tr('full_name'),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                        decoration: InputDecoration(
                          labelText: context.tr('email_address'),
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                        decoration: InputDecoration(
                          labelText: context.tr('phone_number'),
                          prefixIcon: const Icon(Icons.phone_outlined),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        readOnly: true,
                        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                        controller: TextEditingController(text: _formatDob(tempDob)),
                        onTap: () async {
                          await _pickDob(
                            dialogContext: dialogContext,
                            initialDate: tempDob,
                            onPicked: (newDob) {
                              setDialogState(() => tempDob = newDob);
                            },
                          );
                        },
                        decoration: InputDecoration(
                          labelText: context.tr('date_of_birth'),
                          prefixIcon: const Icon(Icons.calendar_month_outlined),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _editPasswordController,
                        obscureText: true,
                        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                        decoration: InputDecoration(
                          labelText: context.tr('password'),
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        readOnly: true,
                        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                        controller: TextEditingController(text: context.tr(tempGender.toLowerCase())),
                        onTap: () async {
                          final gender = await showModalBottomSheet<String>(
                            context: dialogContext,
                            backgroundColor: theme.scaffoldBackgroundColor,
                            builder: (_) => SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text(context.tr('male'), style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                                    onTap: () => Navigator.pop(context, 'Male'),
                                  ),
                                  ListTile(
                                    title: Text(context.tr('female'), style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                                    onTap: () => Navigator.pop(context, 'Female'),
                                  ),
                                ],
                              ),
                            ),
                          );
                          if (gender != null) {
                            setDialogState(() => tempGender = gender);
                          }
                        },
                        decoration: InputDecoration(
                          labelText: context.tr('gender'),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(context.tr('cancel'), style: TextStyle(color: theme.colorScheme.primary)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF0E7E8A), // لون داكن وواضح للتباين العالي
                  ),
                  onPressed: () {
                    final newName = _fullNameController.text.trim();
                    final newEmail = _emailController.text.trim();
                    final newPhone = _phoneController.text.trim();

                    if (newName.isEmpty || newEmail.isEmpty || newPhone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(context.tr('fill_all_fields'))),
                      );
                      return;
                    }

                    setState(() {
                      _fullName = newName;
                      _email = newEmail;
                      _phone = newPhone;
                      _dateOfBirth = tempDob;
                      _gender = tempGender;
                    });

                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(context.tr('save')),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _openChangePasswordDialog() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();

    showDialog<void>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          backgroundColor: theme.scaffoldBackgroundColor,
          title: Text(context.tr('change_password'), style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _currentPasswordController,
                    obscureText: true,
                    style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                    decoration: InputDecoration(labelText: context.tr('current_password'), prefixIcon: const Icon(Icons.lock_outline)),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                    decoration: InputDecoration(labelText: context.tr('new_password'), prefixIcon: const Icon(Icons.lock_open_outlined)),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                    decoration: InputDecoration(labelText: context.tr('confirm_new_password'), prefixIcon: const Icon(Icons.lock_outline)),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.tr('cancel'), style: TextStyle(color: theme.colorScheme.primary)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0E7E8A), foregroundColor: Colors.white),
              onPressed: () {
                final current = _currentPasswordController.text.trim();
                final next = _newPasswordController.text.trim();
                final confirm = _confirmPasswordController.text.trim();

                if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr('fill_all_fields'))));
                  return;
                }
                if (next != confirm) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.tr('password_not_match'))));
                  return;
                }

                Navigator.of(context).pop();
              },
              child: Text(context.tr('update')),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickAvatar(ImageSource source) async {
    final picked = await _imagePicker.pickImage(source: source, imageQuality: 85, maxWidth: 1200);
    if (picked == null) return;
    setState(() { _avatarImage = picked; });
  }

  void _openAvatarPickerSheet() {
    final theme = Theme.of(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt_outlined, color: theme.iconTheme.color),
                title: Text(context.tr('camera'), style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _pickAvatar(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library_outlined, color: theme.iconTheme.color),
                title: Text(context.tr('gallery'), style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _pickAvatar(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color ?? const Color(0xFF072332)),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          context.tr('account_settings'),
          style: TextStyle(
            color: theme.textTheme.titleLarge?.color ?? const Color(0xFF072332),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF0E7E8A), width: 4),
                      ),
                      child: ClipOval(
                        child: _avatarImage == null
                            ? Container(color: theme.cardColor)
                            : Image.file(File(_avatarImage!.path), fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 8,
                      child: InkWell(
                        onTap: _openAvatarPickerSheet,
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0E7E8A)),
                          child: const Icon(Icons.edit, size: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  _fullName,
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: theme.textTheme.bodyLarge?.color),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: theme.dividerColor, width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(color: const Color(0xFFD7F0F6), borderRadius: BorderRadius.circular(14)),
                          child: const Icon(Icons.person_outline, color: Color(0xFF0F4B61)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            context.tr('personal_information'),
                            style: TextStyle(fontWeight: FontWeight.w900, color: theme.textTheme.bodyLarge?.color, fontSize: 22, height: 1.05),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    _Field(label: context.tr('full_name_label'), value: _fullName),
                    _Field(label: context.tr('email_address_label'), value: _email),
                    _Field(label: context.tr('phone_number_label'), value: _phone),
                    _Field(label: context.tr('date_of_birth_label'), value: _formatDob(_dateOfBirth)),
                    _Field(label: context.tr('gender_label'), value: context.tr(_gender.toLowerCase())),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _Field(label: context.tr('password_label'), value: _passwordMasked, asPassword: true)),
                        IconButton(
                          onPressed: _openChangePasswordDialog,
                          icon: const Icon(Icons.refresh, color: Color(0xFF0E7E8A)),
                        ),
                        Text(
                          context.tr('change'),
                          style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0E7E8A), fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 56,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0E7E8A), // تباين قوي للسطوع العالي
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        ),
                        onPressed: _openEditProfileDialog,
                        icon: const Icon(Icons.edit, size: 20),
                        label: Text(context.tr('edit_profile'), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String value;
  final bool asPassword;

  const _Field({required this.label, required this.value, this.asPassword = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF52AAB5), letterSpacing: 1.2, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w900, color: theme.textTheme.bodyLarge?.color ?? const Color(0xFF072332), fontSize: 18),
          ),
        ],
      ),
    );
  }
}