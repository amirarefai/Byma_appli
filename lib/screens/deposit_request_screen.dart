// import 'package:flutter/material.dart';
// import 'dart:ui';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class DepositRequestScreen extends StatefulWidget {
//   const DepositRequestScreen({super.key});

//   @override
//   State<DepositRequestScreen> createState() => _DepositRequestScreenState();
// }

// class _DepositRequestScreenState extends State<DepositRequestScreen> {
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _receiptController = TextEditingController();
//   final ImagePicker _imagePicker = ImagePicker();
//   XFile? _receiptImage;

//   Future<void> _pickReceiptImage(ImageSource source) async {
//     final image = await _imagePicker.pickImage(source: source, imageQuality: 85);
//     if (!mounted || image == null) return;

//     setState(() {
//       _receiptImage = image;
//     });
//   }

//   Future<void> _showImageSourcePicker() async {
//     final source = await showModalBottomSheet<ImageSource>(
//       context: context,
//       builder: (sheetContext) {
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.photo_library_outlined),
//                 title: const Text('Choose from gallery'),
//                 onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.camera_alt_outlined),
//                 title: const Text('Take a photo'),
//                 onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
//               ),
//             ],
//           ),
//         );
//       },
//     );

//     if (source != null) {
//       await _pickReceiptImage(source);
//     }
//   }

//   @override
//   void dispose() {
//     _amountController.dispose();
//     _receiptController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const primaryDarkTeal = Color(0xFF0F5B78);
//     const cyanLight = Color(0xFF56CCF2);
//     const bgGradientStart = Color(0xFFF7FCFE);
//     const bgGradientEnd = Color(0xFFEAF4F8);
//     const inputFillColor = Color(0xFFF1F5F7);
//     const uploadAreaBg = Color(0xFFE0F7FA);

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [bgGradientStart, bgGradientEnd],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // الشريط العلوي
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back, color: primaryDarkTeal, size: 26),
//                           onPressed: () => Navigator.of(context).pop(),
//                         ),
//                         const SizedBox(width: 8),
//                         const Text(
//                           'Deposit Request',
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: primaryDarkTeal,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Divider(color: Color(0xFFE0E0E0), height: 1, thickness: 1),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // المحتوى الرئيسي
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         // البطاقة البيضاء الرئيسية
//                         Container(
//                           padding: const EdgeInsets.all(24),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(28),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.03),
//                                 blurRadius: 15,
//                                 offset: const Offset(0, 5),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // ترويسة تفاصيل الإيصال (بدون الدائرة الزرقاء)
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: const [
//                                   Text(
//                                     'Receipt Details',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     'Provide transaction info',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 24),

//                               // حقل المبلغ (Amount)
//                               const Text(
//                                 'Amount',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: inputFillColor,
//                                   borderRadius: BorderRadius.circular(24),
//                                   border: Border.all(color: const Color(0xFFCFD8DC)),
//                                 ),
//                                 child: TextField(
//                                   controller: _amountController,
//                                   keyboardType: TextInputType.number,
//                                   style: const TextStyle(color: Colors.black87, fontSize: 15),
//                                   decoration: const InputDecoration(
//                                     hintText: 'e.g. 100',
//                                     hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
//                                     border: InputBorder.none,
//                                     contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                                     suffixIcon: Padding(
//                                       padding: EdgeInsets.only(right: 16.0),
//                                       child: Icon(
//                                         Icons.payments_outlined,
//                                         color: Color(0xFFB0BEC5),
//                                         size: 22,
//                                       ),
//                                     ),
//                                     suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 20),

//                               // حقل رقم الإيصال
//                               const Text(
//                                 'Receipt Number',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: inputFillColor,
//                                   borderRadius: BorderRadius.circular(24),
//                                   border: Border.all(color: const Color(0xFFCFD8DC)),
//                                 ),
//                                 child: TextField(
//                                   controller: _receiptController,
//                                   style: const TextStyle(color: Colors.black87, fontSize: 15),
//                                   decoration: const InputDecoration(
//                                     hintText: 'e.g. TXN-987654321',
//                                     hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
//                                     border: InputBorder.none,
//                                     contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                                     suffixIcon: Padding(
//                                       padding: EdgeInsets.only(right: 16.0),
//                                       child: Text(
//                                         '#',
//                                         style: TextStyle(
//                                           color: Color(0xFFB0BEC5),
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                     suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 20),

//                               // قسم تحميل صورة الإيصال
//                               const Text(
//                                 'Receipt Image',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               InkWell(
//                                 onTap: _showImageSourcePicker,
//                                 borderRadius: BorderRadius.circular(24),
//                                 child: CustomPaint(
//                                   painter: DashedRectPainter(
//                                     color: cyanLight,
//                                     strokeWidth: 1.5,
//                                     gap: 6.0,
//                                   ),
//                                   child: Container(
//                                     width: double.infinity,
//                                     padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(24),
//                                     ),
//                                     child: _receiptImage == null
//                                         ? Column(
//                                             children: [
//                                               Container(
//                                                 width: 52,
//                                                 height: 52,
//                                                 decoration: const BoxDecoration(
//                                                   color: uploadAreaBg,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                                 child: const Icon(
//                                                   Icons.cloud_upload_outlined,
//                                                   color: primaryDarkTeal,
//                                                   size: 26,
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 12),
//                                               const Text(
//                                                 'Upload Receipt Photo',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: primaryDarkTeal,
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 4),
//                                               const Text(
//                                                 'Tap to select or take photo',
//                                                 style: TextStyle(
//                                                   fontSize: 13,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                         : ClipRRect(
//                                             borderRadius: BorderRadius.circular(16),
//                                             child: Image.file(
//                                               File(_receiptImage!.path),
//                                               height: 150,
//                                               width: double.infinity,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 28),

//                         // زر تقديم الإيداع السفلي
//                         Container(
//                           width: double.infinity,
//                           height: 56,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(28),
//                             gradient: const LinearGradient(
//                               colors: [primaryDarkTeal, cyanLight],
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: cyanLight.withOpacity(0.3),
//                                 blurRadius: 12,
//                                 offset: const Offset(0, 6),
//                               ),
//                             ],
//                           ),
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.transparent,
//                               shadowColor: Colors.transparent,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(28),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                                 Text(
//                                   'SUBMIT DEPOSIT',
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                     letterSpacing: 1.1,
//                                   ),
//                                 ),
//                                 SizedBox(width: 8),
//                                 Icon(Icons.arrow_forward, color: Colors.white, size: 20),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DashedRectPainter extends CustomPainter {
//   final Color color;
//   final double strokeWidth;
//   final double gap;

//   DashedRectPainter({
//     required this.color,
//     this.strokeWidth = 1.0,
//     this.gap = 5.0,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = color
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke;

//     final RRect rrect = RRect.fromRectAndRadius(
//       Rect.fromLTWH(0, 0, size.width, size.height),
//       const Radius.circular(24),
//     );

//     final Path path = Path()..addRRect(rrect);
//     final Path dashPath = Path();

//     double distance = 0.0;
//     for (final PathMetric pathMetric in path.computeMetrics()) {
//       while (distance < pathMetric.length) {
//         dashPath.addPath(
//           pathMetric.extractPath(distance, distance + gap),
//           Offset.zero,
//         );
//         distance += gap * 2;
//       }
//     }

//     canvas.drawPath(dashPath, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

import 'package:byma_app/business_logic/create_deposit/cubit/create_deposit_cubit.dart';
import 'package:byma_app/business_logic/create_deposit/cubit/create_deposit_state.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:byma_app/data/models/deposit_request_model.dart';

class DepositRequestScreen extends StatefulWidget {
  const DepositRequestScreen({super.key});

  @override
  State<DepositRequestScreen> createState() => _DepositRequestScreenState();
}

class _DepositRequestScreenState extends State<DepositRequestScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _receiptController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _receiptImage;

  Future<void> _pickReceiptImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(source: source, imageQuality: 85);
    if (!mounted || image == null) return;

    setState(() {
      _receiptImage = image;
    });
  }

  Future<void> _showImageSourcePicker(bool isLoading) async {
    if (isLoading) return; // Prevent opening picker while loading

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from gallery'),
                onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Take a photo'),
                onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );

    if (source != null) {
      await _pickReceiptImage(source);
    }
  }

  void _submitDeposit() {
    final amountText = _amountController.text.trim();
    final receiptText = _receiptController.text.trim();
    final amount = num.tryParse(amountText);

    // 1. Validate inputs
    if (amount == null || amount <= 0) {
      _showSnackBar('Please enter a valid amount.', Colors.orange);
      return;
    }
    if (receiptText.isEmpty) {
      _showSnackBar('Please enter the receipt number.', Colors.orange);
      return;
    }
    if (_receiptImage == null) {
      _showSnackBar('Please upload a receipt image.', Colors.orange);
      return;
    }

    // 2. Create the model
    final requestModel = DepositRequestModel(
      amount: amount,
      receiptNumber: receiptText,
      receiptImage: File(_receiptImage!.path),
    );

    // 3. Trigger the API call
    context.read<CreateDepositCubit>().createDeposit(requestModel);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _receiptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryDarkTeal = Color(0xFF0F5B78);
    const cyanLight = Color(0xFF56CCF2);
    const bgGradientStart = Color(0xFFF7FCFE);
    const bgGradientEnd = Color(0xFFEAF4F8);
    const inputFillColor = Color(0xFFF1F5F7);
    const uploadAreaBg = Color(0xFFE0F7FA);

    return Scaffold(
      body: BlocConsumer<CreateDepositCubit, CreateDepositState>(
        listener: (context, state) {
          state.whenOrNull(
            success: () {
              _showSnackBar('Deposit request submitted successfully!', Colors.green);
              Navigator.of(context).pop();
            },
            error: (message) {
              _showSnackBar(message, Colors.redAccent);
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [bgGradientStart, bgGradientEnd],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Top Bar
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, color: primaryDarkTeal, size: 26),
                              onPressed: () {
                                if (!isLoading && Navigator.canPop(context)) {
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Deposit Request',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: primaryDarkTeal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Color(0xFFE0E0E0), height: 1, thickness: 1),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Main Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // White Card
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Receipt Details',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Provide transaction info',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),

                                  // Amount Field
                                  const Text(
                                    'Amount',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: inputFillColor,
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(color: const Color(0xFFCFD8DC)),
                                    ),
                                    child: TextField(
                                      controller: _amountController,
                                      enabled: !isLoading,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      style: const TextStyle(color: Colors.black87, fontSize: 15),
                                      decoration: const InputDecoration(
                                        hintText: 'e.g. 100',
                                        hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(right: 16.0),
                                          child: Icon(
                                            Icons.payments_outlined,
                                            color: Color(0xFFB0BEC5),
                                            size: 22,
                                          ),
                                        ),
                                        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Receipt Number Field
                                  const Text(
                                    'Receipt Number',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: inputFillColor,
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(color: const Color(0xFFCFD8DC)),
                                    ),
                                    child: TextField(
                                      controller: _receiptController,
                                      enabled: !isLoading,
                                      style: const TextStyle(color: Colors.black87, fontSize: 15),
                                      decoration: const InputDecoration(
                                        hintText: 'e.g. TXN-987654321',
                                        hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(right: 16.0),
                                          child: Text(
                                            '#',
                                            style: TextStyle(
                                              color: Color(0xFFB0BEC5),
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Receipt Image Upload Section
                                  const Text(
                                    'Receipt Image',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  InkWell(
                                    onTap: () => _showImageSourcePicker(isLoading),
                                    borderRadius: BorderRadius.circular(24),
                                    child: CustomPaint(
                                      painter: DashedRectPainter(
                                        color: cyanLight,
                                        strokeWidth: 1.5,
                                        gap: 6.0,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: _receiptImage == null
                                            ? Column(
                                                children: [
                                                  Container(
                                                    width: 52,
                                                    height: 52,
                                                    decoration: const BoxDecoration(
                                                      color: uploadAreaBg,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.cloud_upload_outlined,
                                                      color: primaryDarkTeal,
                                                      size: 26,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  const Text(
                                                    'Upload Receipt Photo',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: primaryDarkTeal,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  const Text(
                                                    'Tap to select or take photo',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : ClipRRect(
                                                borderRadius: BorderRadius.circular(16),
                                                child: Image.file(
                                                  File(_receiptImage!.path),
                                                  height: 150,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 28),

                            // Submit Button
                            Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                gradient: const LinearGradient(
                                  colors: [primaryDarkTeal, cyanLight],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: cyanLight.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: isLoading ? null : _submitDeposit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'SUBMIT DEPOSIT',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              letterSpacing: 1.1,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                                        ],
                                      ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Keep your existing DashedRectPainter exactly as it is:
class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(24),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashPath = Path();

    double distance = 0.0;
    for (final PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + gap),
          Offset.zero,
        );
        distance += gap * 2;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}