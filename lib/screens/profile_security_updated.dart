import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSecurityUpdated extends StatefulWidget {
  const ProfileSecurityUpdated({super.key});

  @override
  State<ProfileSecurityUpdated> createState() =>
      _ProfileSecurityUpdatedState();
}

class _ProfileSecurityUpdatedState extends State<ProfileSecurityUpdated> {
  bool _themeOn = false;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _avatarImage;

  // Demo/local state (بدون backend)
  String _fullName = 'Alex Curator';
  String _email = 'alex.c@bymatravel.com';
  String _phone = '+1 (555) 0123 4567';

  DateTime _dateOfBirth = DateTime(1988, 3, 24);
  String _gender = 'Male'; // Male / Female

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // UI-only masked password to reflect that update happened (بدون backend)
  String _passwordMasked = '••••••••••';

  // Edit Profile dialog password (simplified)
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
    // Keep similar look to: March 24, 1988
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
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

    // keep blank by default; user types if he wants to change
    _editPasswordController.clear();

    String tempGender = _gender;
    DateTime tempDob = _dateOfBirth;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Profile'),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: 420,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: _formatDob(tempDob),
                        ),
                        onTap: () async {
                          await _pickDob(
                            dialogContext: dialogContext,
                            initialDate: tempDob,
                            onPicked: (newDob) {
                              setDialogState(() => tempDob = newDob);
                            },
                          );
                        },
                        decoration: const InputDecoration(
                          labelText: 'Date of Birth',
                          prefixIcon: Icon(Icons.calendar_month_outlined),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _editPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: tempGender,
                        ),
                        onTap: () async {
                          final gender =
                              await showModalBottomSheet<String>(
                            context: dialogContext,
                            builder: (_) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text('Male'),
                                  onTap: () =>
                                      Navigator.pop(context, 'Male'),
                                ),
                                ListTile(
                                  title: const Text('Female'),
                                  onTap: () => Navigator.pop(
                                      context, 'Female'),
                                ),
                              ],
                            ),
                          );

                          if (gender != null) {
                            setDialogState(() => tempGender = gender);
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 12),


                     
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFF66D0FF),
                  ),
                  onPressed: () {
                    final newName = _fullNameController.text.trim();
                    final newEmail = _emailController.text.trim();
                    final newPhone = _phoneController.text.trim();

                    if (newName.isEmpty ||
                        newEmail.isEmpty ||
                        newPhone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields.')),
                      );
                      return;
                    }

                    final typedPassword =
                        _editPasswordController.text.trim();

                    setState(() {
                      _fullName = newName;
                      _email = newEmail;
                      _phone = newPhone;
                      _dateOfBirth = tempDob;
                      _gender = tempGender;

                      // If user typed password in Edit Profile -> reflect in UI (demo)
                      if (typedPassword.isNotEmpty) {
                        _passwordMasked = '••••••••••';
                      }
                    });

                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Save'),
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
        return AlertDialog(
          title: const Text('Change Password'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _currentPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Current Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      prefixIcon: Icon(Icons.lock_open_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm New Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final current = _currentPasswordController.text.trim();
                final next = _newPasswordController.text.trim();
                final confirm = _confirmPasswordController.text.trim();

                if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields.')),
                  );
                  return;
                }
                if (next != confirm) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('New passwords do not match.')),
                  );
                  return;
                }

                // TODO: replace with API call
                setState(() {
                  // reflect update in UI (demo)
                  _passwordMasked = '••••••••••';
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password updated (demo).')),
                );

                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }


  Future<void> _pickAvatar(ImageSource source) async {
    final picked = await _imagePicker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1200,
    );

    if (picked == null) return;

    setState(() {
      _avatarImage = picked;
    });
  }

  void _openAvatarPickerSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _pickAvatar(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Gallery'),
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
    const bg = Color(0xFFF2F6F7);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF072332)),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Account Settings',
          style: TextStyle(
            color: Color(0xFF072332),
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

              // Account / avatar header (approx. matching the provided design)
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
                        border: Border.all(
                          color: const Color(0xFF0E7E8A),
                          width: 4,
                        ),
                      ),
                      child: ClipOval(
                        child: _avatarImage == null
                            ? Container(
                                color: const Color(0xFFF2F6F7),
                              )
                            : Image.file(
                                File(_avatarImage!.path),
                                fit: BoxFit.cover,
                              ),
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
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF0E7E8A),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF0E7E8A).withOpacity(0.28),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.white,
                          ),
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
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF000000),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Profile card
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: const Color(0xFFE5EEF1),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Section header row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD7F0F6),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            color: Color(0xFF0F4B61),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Personal\nInformation',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF072332),
                              fontSize: 22,
                              height: 1.05,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFD0E3E7),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: Color(0xFF94A3B8),
                            size: 22,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // Fields
                    _Field(
                      label: 'FULL NAME',
                      value: _fullName,
                    ),
                    _Field(
                      label: 'EMAIL ADDRESS',
                      value: _email,
                    ),
                    _Field(
                      label: 'PHONE NUMBER',
                      value: _phone,
                    ),
                    _Field(
                      label: 'DATE OF BIRTH',
                      value: _formatDob(_dateOfBirth),
                    ),
                    _Field(
                      label: 'GENDER',
                      value: _gender == 'Male' ? 'Male' : 'Female',
                    ),

                    const SizedBox(height: 10),

                    // Password row with "Change"
                    Row(
                      children: [
                        Expanded(
                          child: _Field(
                            label: 'PASSWORD',
                            value: _passwordMasked,
                            asPassword: true,
                          ),
                        ),
                        IconButton(
                          onPressed: _openChangePasswordDialog,
                          icon: const Icon(
                            Icons.refresh,
                            color: Color(0xFF0E7E8A),
                          ),
                        ),
                        const Text(
                          'Change',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0E7E8A),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Edit profile button
                    SizedBox(
                      height: 56,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF66D0FF),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: _openEditProfileDialog,
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                        ),
                        label: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
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

  const _Field({
    required this.label,
    required this.value,
    this.asPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF52AAB5),
              letterSpacing: 1.2,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF072332),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
