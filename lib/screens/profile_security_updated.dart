// import 'dart:io';
// import 'package:byma_app/business_logic/get_profile/cubit/get_profile_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:byma_app/data/models/profile_model.dart';

// class ProfileSecurityUpdated extends StatefulWidget {
//   const ProfileSecurityUpdated({super.key});

//   @override
//   State<ProfileSecurityUpdated> createState() => _ProfileSecurityUpdatedState();
// }

// class _ProfileSecurityUpdatedState extends State<ProfileSecurityUpdated> {
//   final ImagePicker _imagePicker = ImagePicker();
//   XFile? _avatarImage;

//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _phoneController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Fetch profile data when the screen initializes
//     context.read<GetProfileCubit>().fetchProfile();
//   }

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   // Edit dialog updated to only include First Name, Last Name, and Phone
//   void _openEditProfileDialog(ProfileModel currentProfile) {
//     _firstNameController.text = currentProfile.firstName;
//     _lastNameController.text = currentProfile.lastName;
//     _phoneController.text = currentProfile.phone;

//     showDialog<void>(
//       context: context,
//       builder: (dialogContext) {
//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             final theme = Theme.of(context);
//             return AlertDialog(
//               backgroundColor: theme.scaffoldBackgroundColor,
//               title: Text(
//                 context.tr('edit_profile'),
//                 style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
//               ),
//               content: SingleChildScrollView(
//                 child: SizedBox(
//                   width: 420,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextField(
//                         controller: _firstNameController,
//                         style: TextStyle(color: theme.textTheme.bodyLarge?.color),
//                         decoration: InputDecoration(
//                           labelText: context.tr('first_name'),
//                           prefixIcon: const Icon(Icons.person_outline),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       TextField(
//                         controller: _lastNameController,
//                         style: TextStyle(color: theme.textTheme.bodyLarge?.color),
//                         decoration: InputDecoration(
//                           labelText: context.tr('last_name'),
//                           prefixIcon: const Icon(Icons.person_outline),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       TextField(
//                         controller: _phoneController,
//                         keyboardType: TextInputType.phone,
//                         style: TextStyle(color: theme.textTheme.bodyLarge?.color),
//                         decoration: InputDecoration(
//                           labelText: context.tr('phone_number'),
//                           prefixIcon: const Icon(Icons.phone_outlined),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(dialogContext).pop(),
//                   child: Text(context.tr('cancel'), style: TextStyle(color: theme.colorScheme.primary)),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: const Color(0xFF0E7E8A),
//                   ),
//                   onPressed: () {
//                     // TODO: Implement an UpdateProfileCubit call here
//                     Navigator.of(dialogContext).pop();
//                   },
//                   child: Text(context.tr('save')),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<void> _pickAvatar(ImageSource source) async {
//     final picked = await _imagePicker.pickImage(source: source, imageQuality: 85, maxWidth: 1200);
//     if (picked == null) return;
//     setState(() {
//       _avatarImage = picked;
//     });
//     // TODO: Dispatch an event to upload the newly picked avatar to the server
//   }

//   void _openAvatarPickerSheet() {
//     final theme = Theme.of(context);
//     showModalBottomSheet<void>(
//       context: context,
//       showDragHandle: true,
//       backgroundColor: theme.scaffoldBackgroundColor,
//       builder: (sheetContext) {
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.camera_alt_outlined, color: theme.iconTheme.color),
//                 title: Text(context.tr('camera'), style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
//                 onTap: () {
//                   Navigator.of(sheetContext).pop();
//                   _pickAvatar(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_library_outlined, color: theme.iconTheme.color),
//                 title: Text(context.tr('gallery'), style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
//                 onTap: () {
//                   Navigator.of(sheetContext).pop();
//                   _pickAvatar(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: false,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: theme.iconTheme.color ?? const Color(0xFF072332)),
//           onPressed: () => Navigator.of(context).maybePop(),
//         ),
//         title: Text(
//           context.tr('account_settings'),
//           style: TextStyle(
//             color: theme.textTheme.titleLarge?.color ?? const Color(0xFF072332),
//             fontWeight: FontWeight.w900,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: BlocBuilder<GetProfileCubit, GetProfileState>(
//           builder: (context, state) {
//             return state.when(
//               initial: () => const Center(child: CircularProgressIndicator(color: Color(0xFF0E7E8A))),
//               loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF0E7E8A))),
//               error: (message) => Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(message, style: TextStyle(color: theme.colorScheme.error)),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () => context.read<GetProfileCubit>().fetchProfile(),
//                       child: Text(context.tr('retry')),
//                     ),
//                   ],
//                 ),
//               ),
//               success: (profile) => _buildProfileContent(context, profile, theme),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileContent(BuildContext context, ProfileModel profile, ThemeData theme) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(height: 8),
//           Center(
//             child: Stack(
//               clipBehavior: Clip.none,
//               alignment: Alignment.bottomRight,
//               children: [
//                 Container(
//                   width: 170,
//                   height: 170,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(color: const Color(0xFF0E7E8A), width: 4),
//                   ),
//                   child: ClipOval(
//                     child: _avatarImage != null
//                         ? Image.file(File(_avatarImage!.path), fit: BoxFit.cover)
//                         : Image.network(
//                             profile.formattedProfileImageUrl,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) => Container(
//                               color: theme.cardColor,
//                               child: const Icon(Icons.person, size: 60, color: Colors.grey),
//                             ),
//                           ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 10,
//                   bottom: 8,
//                   child: InkWell(
//                     onTap: _openAvatarPickerSheet,
//                     borderRadius: BorderRadius.circular(100),
//                     child: Container(
//                       width: 46,
//                       height: 46,
//                       decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0E7E8A)),
//                       child: const Icon(Icons.edit, size: 18, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
          
//           const SizedBox(height: 32),

//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//             decoration: BoxDecoration(
//               color: theme.cardColor,
//               borderRadius: BorderRadius.circular(26),
//               border: Border.all(color: theme.dividerColor, width: 1.2),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 44,
//                       height: 44,
//                       decoration: BoxDecoration(color: const Color(0xFFD7F0F6), borderRadius: BorderRadius.circular(14)),
//                       child: const Icon(Icons.person_outline, color: Color(0xFF0F4B61)),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         context.tr('personal_information'),
//                         style: TextStyle(fontWeight: FontWeight.w900, color: theme.textTheme.bodyLarge?.color, fontSize: 22, height: 1.05),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 22),
                
//                 // First Name and Last Name instead of Full Name
//                 _Field(label: context.tr('first_name'), value: profile.firstName),
//                 _Field(label: context.tr('last_name'), value: profile.lastName),
//                 _Field(label: context.tr('phone_number'), value: profile.phone),
                
//                 // ID Image Rectangle added beneath the phone number
//                 const SizedBox(height: 8),
//                 Text(
//                   context.tr('id_image').toUpperCase(),
//                   style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF52AAB5), letterSpacing: 1.2, fontSize: 12),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   height: 180,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: theme.scaffoldBackgroundColor,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: theme.dividerColor, width: 1.2),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Image.network(
//                       profile.formattedIdImageUrl,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.badge_outlined, size: 40, color: Colors.grey),
//                           const SizedBox(height: 8),
//                           Text(context.tr('no_id_image_found'), style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
                
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   height: 56,
//                   child: ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF0E7E8A),
//                       foregroundColor: Colors.white,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//                     ),
//                     onPressed: () => _openEditProfileDialog(profile),
//                     icon: const Icon(Icons.edit, size: 20),
//                     label: Text(context.tr('edit_profile'), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }

// class _Field extends StatelessWidget {
//   final String label;
//   final String value;

//   const _Field({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label.toUpperCase(),
//             style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF52AAB5), letterSpacing: 1.2, fontSize: 12),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             value.isNotEmpty ? value : '--',
//             style: TextStyle(fontWeight: FontWeight.w900, color: theme.textTheme.bodyLarge?.color ?? const Color(0xFF072332), fontSize: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:byma_app/data/models/profile_model.dart';
import 'package:byma_app/business_logic/get_profile/cubit/get_profile_cubit.dart';
import 'package:byma_app/business_logic/update_profile/cubit/update_profile_cubit.dart'; 

class ProfileSecurityUpdated extends StatefulWidget {
  const ProfileSecurityUpdated({super.key});

  @override
  State<ProfileSecurityUpdated> createState() => _ProfileSecurityUpdatedState();
}

class _ProfileSecurityUpdatedState extends State<ProfileSecurityUpdated> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _avatarImage;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  // final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetProfileCubit>().fetchProfile();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    // _phoneController.dispose();
    super.dispose();
  }

  void _openEditProfileDialog(ProfileModel currentProfile) {
    _firstNameController.text = currentProfile.firstName;
    _lastNameController.text = currentProfile.lastName;
    // _phoneController.text = currentProfile.phone;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final theme = Theme.of(context);
            return AlertDialog(
              backgroundColor: theme.scaffoldBackgroundColor,
              title: Text(
                context.tr('edit_profile'),
                style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: 420,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _firstNameController,
                        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                        decoration: InputDecoration(
                          labelText: context.tr('first_name'),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _lastNameController,
                        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                        decoration: InputDecoration(
                          labelText: context.tr('last_name'),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // TextField(
                      //   controller: _phoneController,
                      //   keyboardType: TextInputType.phone,
                      //   style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                      //   decoration: InputDecoration(
                      //     labelText: context.tr('phone_number'),
                      //     prefixIcon: const Icon(Icons.phone_outlined),
                      //   ),
                      // ),
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
                    backgroundColor: const Color(0xFF0E7E8A),
                  ),
                  onPressed: () {
                    // 1. Close the dialog first
                    Navigator.of(dialogContext).pop();
                    
                    // 2. Dispatch the text update event
                    // Note: If you add 'phone' to your API and Cubit later, you can pass it here too.
                    context.read<UpdateProfileCubit>().updateProfile(
                      firstName: _firstNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                    );
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

  Future<void> _pickAvatar(ImageSource source) async {
    final picked = await _imagePicker.pickImage(source: source, imageQuality: 85, maxWidth: 1200);
    if (picked == null) return;
    
    setState(() {
      _avatarImage = picked;
    });

    // Dispatch the image upload event immediately after picking
    if (mounted) {
      context.read<UpdateProfileCubit>().updateProfile(
        profileImagePath: picked.path,
      );
    }
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
      // Use BlocListener to handle the side-effects of UpdateProfileCubit
      body: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {
              // Show an un-dismissible loading dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(color: Color(0xFF0E7E8A)),
                ),
              );
            },
            success: (updatedProfile) {
              // 1. Pop the loading dialog
              Navigator.of(context, rootNavigator: true).pop();
              
              // 2. Show a success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.tr('profile_updated_successfully') ?? 'Profile updated!'),
                  backgroundColor: Colors.green,
                ),
              );

              // 3. Refresh the profile data to reflect changes server-side
              context.read<GetProfileCubit>().fetchProfile();
            },
            error: (message) {
              // 1. Pop the loading dialog
              Navigator.of(context, rootNavigator: true).pop();
              
              // 2. Show the error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: theme.colorScheme.error,
                ),
              );
            },
          );
        },
        child: SafeArea(
          child: BlocBuilder<GetProfileCubit, GetProfileState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: CircularProgressIndicator(color: Color(0xFF0E7E8A))),
                loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF0E7E8A))),
                error: (message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(message, style: TextStyle(color: theme.colorScheme.error)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.read<GetProfileCubit>().fetchProfile(),
                        child: Text(context.tr('retry')),
                      ),
                    ],
                  ),
                ),
                success: (profile) => _buildProfileContent(context, profile, theme),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileModel profile, ThemeData theme) {
    return SingleChildScrollView(
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
                    child: _avatarImage != null
                        ? Image.file(File(_avatarImage!.path), fit: BoxFit.cover)
                        : Image.network(
                            profile.formattedProfileImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: theme.cardColor,
                              child: const Icon(Icons.person, size: 60, color: Colors.grey),
                            ),
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
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0E7E8A)),
                      child: const Icon(Icons.edit, size: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),

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
                
                _Field(label: context.tr('first_name'), value: profile.firstName),
                _Field(label: context.tr('last_name'), value: profile.lastName),
                _Field(label: context.tr('phone_number'), value: profile.phone),
                
                const SizedBox(height: 8),
                Text(
                  context.tr('id_image').toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF52AAB5), letterSpacing: 1.2, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.dividerColor, width: 1.2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      profile.formattedIdImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.badge_outlined, size: 40, color: Colors.grey),
                          const SizedBox(height: 8),
                          Text(context.tr('no_id_image_found'), style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                SizedBox(
                  height: 56,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E7E8A),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                    onPressed: () => _openEditProfileDialog(profile),
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
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String value;

  const _Field({required this.label, required this.value});

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
            value.isNotEmpty ? value : '--',
            style: TextStyle(fontWeight: FontWeight.w900, color: theme.textTheme.bodyLarge?.color ?? const Color(0xFF072332), fontSize: 18),
          ),
        ],
      ),
    );
  }
}