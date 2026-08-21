// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ConvertPointsScreen(),
//     );
//   }
// }

// class ConvertPointsScreen extends StatefulWidget {
//   const ConvertPointsScreen({super.key});

//   @override
//   State<ConvertPointsScreen> createState() => _ConvertPointsScreenState();
// }

// class _ConvertPointsScreenState extends State<ConvertPointsScreen> {
//   final TextEditingController _pointsController = TextEditingController(text: "5400");

//   @override
//   Widget build(BuildContext context) {
//     // الألوان المستخرجة من التصميم
//     const primaryDarkTeal = Color(0xFF0A5870);       // لون العنوان والأزرار الداكن
//     const buttonCyanLight = Color(0xFF67CEF5);       // الدرجة الفاتحة المتدرجة بالزر
//     const inputBgColor = Color(0xFFEFF2F5);           // خلفية حقل الإدخال
//     const textColorDark = Color(0xFF1E282C);          // لون الرقم المكتوب
//     const textSubTitleColor = Color(0xFF4F5E68);      // لون النص الوصفي

//     // درجات خلفية الشاشة الهادئة المتدرجة
//     const bgGradientStart = Color(0xFFF7FCFE);
//     const bgGradientEnd = Color(0xFFEAF4F8);

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
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//             child: Column(
//               children: [
//                 // الشريط العلوي (App Bar)
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back, color: primaryDarkTeal, size: 24),
//                       onPressed: () {
//                         if (Navigator.canPop(context)) {
//                           Navigator.of(context).pop();
//                         }
//                       },
//                     ),
//                     const Expanded(
//                       child: Text(
//                         'Convert Points',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: primaryDarkTeal,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 48), // لموازنة زر الرجوع
//                   ],
//                 ),
//                 const SizedBox(height: 36),

//                 // النص الوصفي العلوي
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     'Convert your points earned from\nbookings into cash',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: textSubTitleColor,
//                       height: 1.4,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 36),

//                 // بطاقة أدخل النقاط (Points Card)
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(28),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.02),
//                         blurRadius: 15,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Points to Convert',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF334149),
//                         ),
//                       ),
//                       const SizedBox(height: 14),
//                       // حقل الإدخال بالخلفية الرمادية الفاتحة والزوايا الدائرية
//                       Container(
//                         decoration: BoxDecoration(
//                           color: inputBgColor,
//                           borderRadius: BorderRadius.circular(24),
//                         ),
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//                         child: TextField(
//                           controller: _pointsController,
//                           keyboardType: TextInputType.number,
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: textColorDark,
//                           ),
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                             isDense: true,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Spacer(),

//                 // زر التحويل إلى كاش (Convert To Cash Button)
//                 Container(
//                   width: double.infinity,
//                   height: 56,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(28),
//                     gradient: const LinearGradient(
//                       colors: [primaryDarkTeal, buttonCyanLight],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: buttonCyanLight.withOpacity(0.35),
//                         blurRadius: 12,
//                         offset: const Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // إضافة حدث التحويل هنا
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       shadowColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(28),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Text(
//                           'CONVERT TO CASH',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             letterSpacing: 0.8,
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         Icon(Icons.arrow_forward, color: Colors.white, size: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:byma_app/business_logic/points_transactions/cubit/points_transactions_cubit.dart';
import 'package:byma_app/business_logic/points_transactions/cubit/points_transactions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertPointsScreen extends StatefulWidget {
  const ConvertPointsScreen({super.key});

  @override
  State<ConvertPointsScreen> createState() => _ConvertPointsScreenState();
}

class _ConvertPointsScreenState extends State<ConvertPointsScreen> {
  final TextEditingController _pointsController = TextEditingController(text: "5400");

  @override
  void dispose() {
    _pointsController.dispose(); // Always dispose controllers to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryDarkTeal = Color(0xFF0A5870);
    const buttonCyanLight = Color(0xFF67CEF5);
    const inputBgColor = Color(0xFFEFF2F5);
    const textColorDark = Color(0xFF1E282C);
    const textSubTitleColor = Color(0xFF4F5E68);

    const bgGradientStart = Color(0xFFF7FCFE);
    const bgGradientEnd = Color(0xFFEAF4F8);

    return Scaffold(
      // 1. Wrap the body in a BlocConsumer
      body: BlocConsumer<PointsTransactionsCubit, PointsTransactionsState>(
        listener: (context, state) {
          // 2. Handle Navigation and Snackbars here (Side effects)
          state.whenOrNull(
            success: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Points converted successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              // Optional: Navigator.of(context).pop(); if you want to close the screen
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
          // 3. Check if the state is currently loading
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Column(
                  children: [
                    // --- App Bar ---
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: primaryDarkTeal, size: 24),
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'Convert Points',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryDarkTeal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 36),

                    // --- Subtitle ---
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Convert your points earned from\nbookings into cash',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: textSubTitleColor,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // --- Points Input Card ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Points to Convert',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF334149),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            decoration: BoxDecoration(
                              color: inputBgColor,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                            child: TextField(
                              controller: _pointsController,
                              keyboardType: TextInputType.number,
                              // Disable input while loading
                              enabled: !isLoading, 
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: textColorDark,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // --- Convert Button ---
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: const LinearGradient(
                          colors: [primaryDarkTeal, buttonCyanLight],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: buttonCyanLight.withOpacity(0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        // 4. Disable button to prevent spam clicks while loading
                        onPressed: isLoading
                            ? null
                            : () {
                                // 5. Parse and Validate input before calling API
                                final inputText = _pointsController.text.trim();
                                final pointsAmount = int.tryParse(inputText);

                                if (pointsAmount != null && pointsAmount > 0) {
                                  // Trigger the API Call
                                  context
                                      .read<PointsTransactionsCubit>()
                                      .createPointsTransactions(pointsAmount);
                                } else {
                                  // Show validation error
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please enter a valid amount of points.'),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        // 6. Swap UI depending on the Loading State
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
                                    'CONVERT TO CASH',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}