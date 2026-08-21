// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'room_details_screen.dart';

// class ReserveYourStayScreen extends StatefulWidget {
//   const ReserveYourStayScreen({super.key});

//   @override
//   State<ReserveYourStayScreen> createState() => _ReserveYourStayScreenState();
// }

// class _ReserveYourStayScreenState extends State<ReserveYourStayScreen> {
//   int _adults = 2;
//   int _children = 0;
//   int _infants = 0;

//   bool _pets = false;
//   bool _nearElevator = true;
//   bool _quietZone = false;

//   String _preferredFloor = 'low';

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
    
//     // التحقق من وضع التباين العالي (High Contrast)
//     final isHighContrast = MediaQuery.highContrastOf(context) || 
//         (theme.colorScheme.primary == Colors.black && !isDark);

//     // لوحة الألوان الديناميكية المستجيبة للثيمات الثلاثة
//     final bg = isHighContrast 
//         ? Colors.white 
//         : (isDark ? const Color(0xFF121212) : const Color(0xFFF3F7F8));
        
//     final cardColor = isHighContrast 
//         ? Colors.white 
//         : (isDark ? const Color(0xFF1E1E1E) : Colors.white);
        
//     final cardBorder = isHighContrast 
//         ? Colors.black 
//         : (isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE0E8E9));

//     final mainTeal = isHighContrast 
//         ? Colors.black 
//         : (isDark ? const Color(0xFF14B8A6) : const Color(0xFF0E6F63));

//     final secondaryTeal = isHighContrast 
//         ? Colors.black 
//         : (isDark ? const Color(0xFF06B6D4) : const Color(0xFF0FA37A));

//     final textColor = isHighContrast 
//         ? Colors.black 
//         : (isDark ? Colors.white : Colors.black);

//     final textMuted = isHighContrast 
//         ? Colors.black.withOpacity(0.75) 
//         : (isDark ? Colors.white60 : Colors.black54);

//     return Scaffold(
//       backgroundColor: bg,
//       appBar: AppBar(
//         backgroundColor: cardColor,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new, color: textColor),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'reserve_title'.tr(),
//           style: TextStyle(fontWeight: FontWeight.w900, color: textColor),
//         ),
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
//           children: [
//             const SizedBox(height: 2),

//             // Booking process label
//             Text(
//               'booking_process_label'.tr(),
//               style: TextStyle(
//                 fontWeight: FontWeight.w800,
//                 letterSpacing: 0.5,
//                 fontSize: 12,
//                 color: textMuted,
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Title
//             Text(
//               'preference_booking_title'.tr(),
//               style: TextStyle(
//                 fontSize: 32,
//                 height: 1.05,
//                 fontWeight: FontWeight.w900,
//                 color: mainTeal,
//               ),
//             ),
//             const SizedBox(height: 16),

//             _GuestsCard(
//               adults: _adults,
//               children: _children,
//               infants: _infants,
//               cardColor: cardColor,
//               cardBorder: cardBorder,
//               mainTeal: mainTeal,
//               textColor: textColor,
//               textMuted: textMuted,
//               isHighContrast: isHighContrast,
//               onAdultsChanged: (v) => setState(() => _adults = v),
//               onChildrenChanged: (v) => setState(() => _children = v),
//               onInfantsChanged: (v) => setState(() => _infants = v),
//             ),
//             const SizedBox(height: 12),

//             _ToggleCard(
//               icon: Icons.pets_outlined,
//               title: 'pets_title'.tr(),
//               subtitle: 'pets_subtitle'.tr(),
//               value: _pets,
//               color: secondaryTeal,
//               cardColor: cardColor,
//               cardBorder: cardBorder,
//               textColor: textColor,
//               textMuted: textMuted,
//               onChanged: (v) => setState(() => _pets = v),
//             ),
//             const SizedBox(height: 10),
//             _ToggleCard(
//               icon: Icons.accessible_outlined,
//               title: 'elevator_title'.tr(),
//               subtitle: 'elevator_subtitle'.tr(),
//               value: _nearElevator,
//               color: mainTeal,
//               cardColor: cardColor,
//               cardBorder: cardBorder,
//               textColor: textColor,
//               textMuted: textMuted,
//               onChanged: (v) => setState(() => _nearElevator = v),
//             ),
//             const SizedBox(height: 10),
//             _ToggleCard(
//               icon: Icons.speaker_notes_outlined,
//               title: 'quiet_title'.tr(),
//               subtitle: 'quiet_subtitle'.tr(),
//               value: _quietZone,
//               color: secondaryTeal,
//               cardColor: cardColor,
//               cardBorder: cardBorder,
//               textColor: textColor,
//               textMuted: textMuted,
//               onChanged: (v) => setState(() => _quietZone = v),
//             ),
//             const SizedBox(height: 14),

//             // Preferred floor
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: cardColor,
//                 border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
//                 borderRadius: BorderRadius.circular(22),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'preferred_floor_label'.tr(),
//                     style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       fontSize: 12,
//                       letterSpacing: 0.6,
//                       color: textColor,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Column(
//                     children: [
//                       _FloorOption(
//                         label: 'floor_low'.tr(),
//                         selected: _preferredFloor == 'low',
//                         onTap: () => setState(() => _preferredFloor = 'low'),
//                         activeColor: secondaryTeal,
//                         textColor: textColor,
//                         mainTeal: mainTeal,
//                         cardBorder: cardBorder,
//                         cardColor: cardColor,
//                         isHighContrast: isHighContrast,
//                       ),
//                       const SizedBox(height: 10),
//                       _FloorOption(
//                         label: 'floor_high'.tr(),
//                         selected: _preferredFloor == 'high',
//                         onTap: () => setState(() => _preferredFloor = 'high'),
//                         activeColor: mainTeal,
//                         textColor: textColor,
//                         mainTeal: mainTeal,
//                         cardBorder: cardBorder,
//                         cardColor: cardColor,
//                         isHighContrast: isHighContrast,
//                       ),
//                       const SizedBox(height: 10),
//                       _FloorOption(
//                         label: 'floor_any'.tr(),
//                         selected: _preferredFloor == 'any',
//                         onTap: () => setState(() => _preferredFloor = 'any'),
//                         activeColor: secondaryTeal,
//                         textColor: textColor,
//                         mainTeal: mainTeal,
//                         cardBorder: cardBorder,
//                         cardColor: cardColor,
//                         isHighContrast: isHighContrast,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Available windows
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: cardColor,
//                 border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
//                 borderRadius: BorderRadius.circular(22),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'available_windows_title'.tr(),
//                           style: TextStyle(
//                             fontWeight: FontWeight.w900,
//                             fontSize: 18,
//                             color: mainTeal,
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           'view_calendar_btn'.tr(),
//                           style: TextStyle(
//                             fontWeight: FontWeight.w800,
//                             fontSize: 12.5,
//                             color: mainTeal,
//                             decoration: isHighContrast ? TextDecoration.underline : null,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _DateWindow(
//                           month: 'august_short'.tr(),
//                           day: '12',
//                           selected: false,
//                           mainTeal: mainTeal,
//                           cardBorder: cardBorder,
//                           cardColor: cardColor,
//                           textColor: textColor,
//                           textMuted: textMuted,
//                           isHighContrast: isHighContrast,
//                         ),
//                       ),
//                       const SizedBox(width: 14),
//                       Expanded(
//                         child: _DateWindow(
//                           month: 'august_short'.tr(),
//                           day: '15',
//                           selected: true,
//                           mainTeal: mainTeal,
//                           cardBorder: cardBorder,
//                           cardColor: cardColor,
//                           textColor: textColor,
//                           textMuted: textMuted,
//                           isHighContrast: isHighContrast,
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Total stay price bubble
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//               decoration: BoxDecoration(
//                 color: cardColor,
//                 border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.attach_money_outlined, color: mainTeal),
//                   const SizedBox(width: 10),
//                   Text(
//                     '\$1,450',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       color: mainTeal,
//                       fontSize: 18,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     'total_stay_label'.tr(),
//                     style: TextStyle(fontWeight: FontWeight.w800, color: textMuted),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 18),

//             // Perfect match header
//             Text(
//               'perfect_match_title'.tr(),
//               style: TextStyle(
//                 fontWeight: FontWeight.w900,
//                 fontSize: 20,
//                 color: mainTeal,
//               ),
//             ),
//             const SizedBox(height: 12),

//             // Recommended card
//             _PerfectMatchCard(
//               title: 'recommended_room_title'.tr(),
//               subtitle: 'recommended_room_subtitle'.tr(),
//               priceLabel: 'price_per_night_label'.tr(),
//               btnLabel: 'view_book_btn'.tr(),
//               tagLabel: 'recommended_tag'.tr(),
//               mainTeal: mainTeal,
//               cardBorder: cardBorder,
//               isHighContrast: isHighContrast,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _GuestsCard extends StatelessWidget {
//   final int adults;
//   final int children;
//   final int infants;
//   final Color cardColor;
//   final Color cardBorder;
//   final Color mainTeal;
//   final Color textColor;
//   final Color textMuted;
//   final bool isHighContrast;
//   final ValueChanged<int> onAdultsChanged;
//   final ValueChanged<int> onChildrenChanged;
//   final ValueChanged<int> onInfantsChanged;

//   const _GuestsCard({
//     required this.adults,
//     required this.children,
//     required this.infants,
//     required this.cardColor,
//     required this.cardBorder,
//     required this.mainTeal,
//     required this.textColor,
//     required this.textMuted,
//     required this.isHighContrast,
//     required this.onAdultsChanged,
//     required this.onChildrenChanged,
//     required this.onInfantsChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: cardColor,
//         border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Icon(Icons.people_outline, color: mainTeal),
//               const SizedBox(width: 10),
//               Text(
//                 'guests_families_label'.tr(),
//                 style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 14,
//                   color: mainTeal,
//                   letterSpacing: 0.2,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),
//           _CounterRow(
//             label: 'adults_label'.tr(),
//             value: adults,
//             textColor: textColor,
//             textMuted: textMuted,
//             mainTeal: mainTeal,
//             cardColor: cardColor,
//             isHighContrast: isHighContrast,
//             onChanged: onAdultsChanged,
//           ),
//           const SizedBox(height: 12),
//           _CounterRow(
//             label: 'children_label'.tr(),
//             value: children,
//             hint: 'children_hint'.tr(),
//             textColor: textColor,
//             textMuted: textMuted,
//             mainTeal: mainTeal,
//             cardColor: cardColor,
//             isHighContrast: isHighContrast,
//             onChanged: onChildrenChanged,
//           ),
//           const SizedBox(height: 12),
//           _CounterRow(
//             label: 'infants_label'.tr(),
//             value: infants,
//             hint: 'infants_hint'.tr(),
//             textColor: textColor,
//             textMuted: textMuted,
//             mainTeal: mainTeal,
//             cardColor: cardColor,
//             isHighContrast: isHighContrast,
//             onChanged: onInfantsChanged,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _CounterRow extends StatelessWidget {
//   final String label;
//   final int value;
//   final String? hint;
//   final Color textColor;
//   final Color textMuted;
//   final Color mainTeal;
//   final Color cardColor;
//   final bool isHighContrast;
//   final ValueChanged<int> onChanged;

//   const _CounterRow({
//     required this.label,
//     required this.value,
//     this.hint,
//     required this.textColor,
//     required this.textMuted,
//     required this.mainTeal,
//     required this.cardColor,
//     required this.isHighContrast,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(fontWeight: FontWeight.w900, color: textColor, fontSize: 13.5),
//               ),
//               if (hint != null)
//                 Text(
//                   hint!,
//                   style: TextStyle(color: textMuted, fontSize: 11.5),
//                 ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 8),
//         _PlusMinus(
//           value: value,
//           onIncrement: () => onChanged(value + 1),
//           onDecrement: () {
//             if (value <= 0) return;
//             onChanged(value - 1);
//           },
//           activeColor: mainTeal,
//           cardColor: cardColor,
//           textColor: textColor,
//           isHighContrast: isHighContrast,
//         ),
//       ],
//     );
//   }
// }

// class _PlusMinus extends StatelessWidget {
//   final int value;
//   final VoidCallback onIncrement;
//   final VoidCallback onDecrement;
//   final Color activeColor;
//   final Color cardColor;
//   final Color textColor;
//   final bool isHighContrast;

//   const _PlusMinus({
//     required this.value,
//     required this.onIncrement,
//     required this.onDecrement,
//     required this.activeColor,
//     required this.cardColor,
//     required this.textColor,
//     required this.isHighContrast,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isZero = value == 0;
//     final disabledBg = isHighContrast ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? const Color(0xFF2D3748) : const Color(0xFFE9EEF0));
//     final disabledIcon = isHighContrast ? Colors.grey : const Color(0xFF99A8AE);

//     return Row(
//       children: [
//         Container(
//           height: 44,
//           width: 44,
//           decoration: BoxDecoration(
//             color: isZero ? disabledBg : (isHighContrast ? Colors.white : activeColor.withOpacity(0.1)),
//             shape: BoxShape.circle,
//             border: isHighContrast ? Border.all(color: Colors.black, width: 2) : null,
//           ),
//           child: IconButton(
//             padding: EdgeInsets.zero,
//             onPressed: onDecrement,
//             icon: Icon(Icons.remove, color: isZero ? disabledIcon : (isHighContrast ? Colors.black : activeColor), size: 18),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Text(
//           value.toString().padLeft(2, '0'),
//           style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: textColor),
//         ),
//         const SizedBox(width: 10),
//         Container(
//           height: 44,
//           width: 44,
//           decoration: BoxDecoration(
//             color: activeColor,
//             shape: BoxShape.circle,
//             border: isHighContrast ? Border.all(color: Colors.black, width: 2) : null,
//           ),
//           child: IconButton(
//             padding: EdgeInsets.zero,
//             onPressed: onIncrement,
//             icon: Icon(Icons.add, color: isHighContrast ? Colors.black : Colors.white, size: 18),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _ToggleCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final bool value;
//   final Color color;
//   final Color cardColor;
//   final Color cardBorder;
//   final Color textColor;
//   final Color textMuted;
//   final ValueChanged<bool> onChanged;

//   const _ToggleCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.value,
//     required this.color,
//     required this.cardColor,
//     required this.cardBorder,
//     required this.textColor,
//     required this.textMuted,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       decoration: BoxDecoration(
//         color: cardColor,
//         border: Border.all(color: cardBorder),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: color.withOpacity(0.12),
//             radius: 20,
//             child: Icon(icon, color: color),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13.5, color: textColor)),
//                 const SizedBox(height: 2),
//                 Text(subtitle, style: TextStyle(color: textMuted, fontSize: 11.5)),
//               ],
//             ),
//           ),
//           Switch(
//             value: value,
//             onChanged: onChanged,
//             activeColor: color,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _FloorOption extends StatelessWidget {
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;
//   final Color activeColor;
//   final Color textColor;
//   final Color mainTeal;
//   final Color cardBorder;
//   final Color cardColor;
//   final bool isHighContrast;

//   const _FloorOption({
//     required this.label,
//     required this.selected,
//     required this.onTap,
//     required this.activeColor,
//     required this.textColor,
//     required this.mainTeal,
//     required this.cardBorder,
//     required this.cardColor,
//     required this.isHighContrast,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: selected ? activeColor : cardColor,
//           borderRadius: BorderRadius.circular(999),
//           boxShadow: selected && !isHighContrast
//               ? [
//                   BoxShadow(
//                     color: activeColor.withOpacity(0.25),
//                     blurRadius: 10,
//                     offset: const Offset(0, 6),
//                   )
//                 ]
//               : null,
//           border: Border.all(
//             color: selected ? (isHighContrast ? Colors.black : Colors.transparent) : cardBorder,
//             width: isHighContrast ? 2 : 1,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.w900,
//               color: selected ? (isHighContrast ? Colors.black : Colors.white) : mainTeal,
//               fontSize: 13.5,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DateWindow extends StatelessWidget {
//   final String month;
//   final String day;
//   final bool selected;
//   final Color mainTeal;
//   final Color cardBorder;
//   final Color cardColor;
//   final Color textColor;
//   final Color textMuted;
//   final bool isHighContrast;

//   const _DateWindow({
//     required this.month,
//     required this.day,
//     required this.selected,
//     required this.mainTeal,
//     required this.cardBorder,
//     required this.cardColor,
//     required this.textColor,
//     required this.textMuted,
//     required this.isHighContrast,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70,
//       decoration: BoxDecoration(
//         color: cardColor,
//         border: Border.all(
//           color: selected ? mainTeal : cardBorder,
//           width: selected ? (isHighContrast ? 3 : 2) : 1,
//         ),
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             month,
//             style: TextStyle(
//               color: selected ? mainTeal : textMuted,
//               fontWeight: FontWeight.w900,
//               fontSize: 12,
//               letterSpacing: 0.4,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             day,
//             style: TextStyle(
//               color: selected ? mainTeal : textColor,
//               fontWeight: FontWeight.w900,
//               fontSize: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _PerfectMatchCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String priceLabel;
//   final String btnLabel;
//   final String tagLabel;
//   final Color mainTeal;
//   final Color cardBorder;
//   final bool isHighContrast;

//   const _PerfectMatchCard({
//     required this.title,
//     required this.subtitle,
//     required this.priceLabel,
//     required this.btnLabel,
//     required this.tagLabel,
//     required this.mainTeal,
//     required this.cardBorder,
//     required this.isHighContrast,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 240,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(26),
//         border: Border.all(color: cardBorder, width: isHighContrast ? 3 : 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 18,
//             offset: const Offset(0, 10),
//           ),
//         ],
//         gradient: isHighContrast 
//             ? null 
//             : const LinearGradient(
//                 colors: [Color(0xFF0A4F47), Color(0xFF0E6F63)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//         color: isHighContrast ? Colors.white : null,
//       ),
//       child: Stack(
//         children: [
//           if (!isHighContrast)
//             ClipRRect(
//               borderRadius: BorderRadius.circular(26),
//               child: Container(
//                 color: Colors.black.withOpacity(0.12),
//                 child: const Center(
//                   child: Icon(Icons.hotel, color: Colors.white54, size: 80),
//                 ),
//               ),
//             ),
//           Positioned(
//             left: 16,
//             top: 16,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
//               decoration: BoxDecoration(
//                 color: isHighContrast ? Colors.black : Colors.white.withOpacity(0.18),
//                 borderRadius: BorderRadius.circular(999),
//               ),
//               child: Text(
//                 tagLabel,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w900,
//                   fontSize: 10.5,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             right: 14,
//             top: 14,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//               decoration: BoxDecoration(
//                 color: isHighContrast ? Colors.black : Colors.white,
//                 borderRadius: BorderRadius.circular(999),
//               ),
//               child: Text(
//                 priceLabel,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 14,
//                   color: isHighContrast ? Colors.white : const Color(0xFF0E6F63),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: 16,
//             right: 16,
//             bottom: 18,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: isHighContrast ? Colors.black : Colors.white,
//                     fontWeight: FontWeight.w900,
//                     fontSize: 22,
//                     height: 1.05,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   subtitle,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: isHighContrast ? Colors.black54 : Colors.white70,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12.5,
//                     height: 1.2,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 InkWell(
//                   borderRadius: BorderRadius.circular(999),
//                   onTap: () {
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (_) => RoomDetailsScreen(
//                     //       roomTitle: title.replaceAll('\n', ' '),
//                     //       pricePerNight: '\$450', id: '',
//                     //     ),
//                     //   ),
//                     // );
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: isHighContrast ? Colors.black : Colors.white.withOpacity(0.14),
//                       borderRadius: BorderRadius.circular(999),
//                     ),
//                     child: Text(
//                       btnLabel,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w900,
//                         fontSize: 12,
//                         letterSpacing: 0.2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:byma_app/business_logic/room_category/cubit/room_category_cubit.dart';
import 'package:byma_app/business_logic/room_category/cubit/room_category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:byma_app/data/models/room_filter_model.dart';
import 'package:byma_app/data/models/room_category_model.dart';

class RoomFilterScreen extends StatefulWidget {
  final RoomFilterModel? initialFilter;

  const RoomFilterScreen({super.key, this.initialFilter});

  @override
  State<RoomFilterScreen> createState() => _RoomFilterScreenState();
}

class _RoomFilterScreenState extends State<RoomFilterScreen> {
  // Matches FilterRoomDto expectations
  int? _floor;
  int _bedNumber = 1; // Default to 1 to satisfy @Min(1) backend validator
  RangeValues _priceRange = const RangeValues(0, 1000); // Adjust max based on your business logic
  String? _status; 
  RoomCategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    
    // Load initial values if passing an existing filter model
    if (widget.initialFilter != null) {
      _floor = widget.initialFilter!.floor;
      _bedNumber = widget.initialFilter!.bedNumber ?? 1;
      _status = widget.initialFilter!.status;
      if (widget.initialFilter!.minPrice != null && widget.initialFilter!.maxPrice != null) {
        _priceRange = RangeValues(
          widget.initialFilter!.minPrice!.toDouble(),
          widget.initialFilter!.maxPrice!.toDouble(),
        );
      }
    }

    // Trigger category fetch if not already loaded
    final categoryCubit = context.read<RoomCategoryCubit>();
    if (categoryCubit.state.maybeMap(
      success: (_) => false,
      orElse: () => true,
    )) {
      categoryCubit.fetchAllRoomCategories();
    }
  }

  void _applyFilters() {
    final filter = RoomFilterModel(
      floor: _floor,
      bedNumber: _bedNumber,
      minPrice: _priceRange.start.round(),
      maxPrice: _priceRange.end.round(),
      status: _status,
      roomCategoryId: _selectedCategory?.id ?? widget.initialFilter?.roomCategoryId,
    );
    
    // Return the filter model to the parent screen to trigger HotelRoomsFilterCubit
    Navigator.pop(context, filter);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final isHighContrast = MediaQuery.highContrastOf(context) || 
        (theme.colorScheme.primary == Colors.black && !isDark);

    final bg = isHighContrast 
        ? Colors.white 
        : (isDark ? const Color(0xFF121212) : const Color(0xFFF3F7F8));
        
    final cardColor = isHighContrast 
        ? Colors.white 
        : (isDark ? const Color(0xFF1E1E1E) : Colors.white);
        
    final cardBorder = isHighContrast 
        ? Colors.black 
        : (isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE0E8E9));

    final mainTeal = isHighContrast 
        ? Colors.black 
        : (isDark ? const Color(0xFF14B8A6) : const Color(0xFF0E6F63));

    final textColor = isHighContrast 
        ? Colors.black 
        : (isDark ? Colors.white : Colors.black);

    final textMuted = isHighContrast 
        ? Colors.black.withOpacity(0.75) 
        : (isDark ? Colors.white60 : Colors.black54);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'filter_rooms_title'.tr(), // Make sure to add this to translations
          style: TextStyle(fontWeight: FontWeight.w900, color: textColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
                children: [
                  Text(
                    'customize_search_title'.tr(),
                    style: TextStyle(
                      fontSize: 28,
                      height: 1.1,
                      fontWeight: FontWeight.w900,
                      color: mainTeal,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 1. ROOM CATEGORY DROPDOWN
                  _CategorySelectionCard(
                    selectedCategory: _selectedCategory,
                    onChanged: (cat) => setState(() => _selectedCategory = cat),
                    cardColor: cardColor,
                    cardBorder: cardBorder,
                    mainTeal: mainTeal,
                    textColor: textColor,
                    isHighContrast: isHighContrast,
                  ),
                  const SizedBox(height: 12),

                  // 2. ROOM STATUS (AVAILABLE / BOOKED)
                  _StatusSelectionCard(
                    currentStatus: _status,
                    onStatusChanged: (status) => setState(() => _status = status),
                    cardColor: cardColor,
                    cardBorder: cardBorder,
                    mainTeal: mainTeal,
                    textColor: textColor,
                    textMuted: textMuted,
                    isHighContrast: isHighContrast,
                  ),
                  const SizedBox(height: 12),

                  // 3. PRICE RANGE
                  _PriceRangeCard(
                    priceRange: _priceRange,
                    onChanged: (range) => setState(() => _priceRange = range),
                    cardColor: cardColor,
                    cardBorder: cardBorder,
                    mainTeal: mainTeal,
                    textColor: textColor,
                    textMuted: textMuted,
                    isHighContrast: isHighContrast,
                  ),
                  const SizedBox(height: 12),

                  // 4. FLOOR AND BEDS
                  _RoomDetailsCard(
                    floor: _floor,
                    bedNumber: _bedNumber,
                    onFloorChanged: (f) => setState(() => _floor = f),
                    onBedsChanged: (b) => setState(() => _bedNumber = b),
                    cardColor: cardColor,
                    cardBorder: cardBorder,
                    mainTeal: mainTeal,
                    textColor: textColor,
                    textMuted: textMuted,
                    isHighContrast: isHighContrast,
                  ),
                ],
              ),
            ),
            
            // APPLY BUTTON
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                border: Border(top: BorderSide(color: cardBorder, width: isHighContrast ? 2 : 1)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainTeal,
                    foregroundColor: isHighContrast ? Colors.white : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: isHighContrast ? const BorderSide(color: Colors.black, width: 2) : BorderSide.none,
                    ),
                    elevation: 0,
                  ),
                  onPressed: _applyFilters,
                  child: Text(
                    'apply_filters_btn'.tr(),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ---------------------- SUB-WIDGETS ----------------------

class _CategorySelectionCard extends StatelessWidget {
  final RoomCategoryModel? selectedCategory;
  final ValueChanged<RoomCategoryModel?> onChanged;
  final Color cardColor;
  final Color cardBorder;
  final Color mainTeal;
  final Color textColor;
  final bool isHighContrast;

  const _CategorySelectionCard({
    required this.selectedCategory,
    required this.onChanged,
    required this.cardColor,
    required this.cardBorder,
    required this.mainTeal,
    required this.textColor,
    required this.isHighContrast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.category_outlined, color: mainTeal, size: 20),
              const SizedBox(width: 8),
              Text(
                'room_category_label'.tr(),
                style: TextStyle(fontWeight: FontWeight.w900, color: textColor, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          BlocBuilder<RoomCategoryCubit, RoomCategoryState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox(),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (categories) {
                  return DropdownButtonFormField<RoomCategoryModel>(
                    value: selectedCategory,
                    hint: Text('select_category_hint'.tr()),
                    isExpanded: true,
                    dropdownColor: cardColor,
                    style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: cardBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: mainTeal, width: 2),
                      ),
                    ),
                    items: [
                      DropdownMenuItem<RoomCategoryModel>(
                        value: null,
                        child: Text('all_categories'.tr()),
                      ),
                      ...categories.map((cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat.name),
                      ))
                    ],
                    onChanged: onChanged,
                  );
                },
                error: (msg) => Text(msg, style: const TextStyle(color: Colors.red)),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatusSelectionCard extends StatelessWidget {
  final String? currentStatus;
  final ValueChanged<String?> onStatusChanged;
  final Color cardColor;
  final Color cardBorder;
  final Color mainTeal;
  final Color textColor;
  final Color textMuted;
  final bool isHighContrast;

  const _StatusSelectionCard({
    required this.currentStatus,
    required this.onStatusChanged,
    required this.cardColor,
    required this.cardBorder,
    required this.mainTeal,
    required this.textColor,
    required this.textMuted,
    required this.isHighContrast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'room_status_label'.tr(),
            style: TextStyle(fontWeight: FontWeight.w900, color: textColor, fontSize: 12, letterSpacing: 0.6),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _FilterOption(
                  label: 'any_status'.tr(),
                  selected: currentStatus == null,
                  onTap: () => onStatusChanged(null),
                  activeColor: mainTeal,
                  textColor: textColor,
                  cardColor: cardColor,
                  cardBorder: cardBorder,
                  isHighContrast: isHighContrast,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _FilterOption(
                  label: 'AVAILABLE', // Matching Enum Exact
                  selected: currentStatus == 'AVAILABLE',
                  onTap: () => onStatusChanged('AVAILABLE'),
                  activeColor: mainTeal,
                  textColor: textColor,
                  cardColor: cardColor,
                  cardBorder: cardBorder,
                  isHighContrast: isHighContrast,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _FilterOption(
                  label: 'BOOKED', // Matching Enum Exact
                  selected: currentStatus == 'BOOKED',
                  onTap: () => onStatusChanged('BOOKED'),
                  activeColor: mainTeal,
                  textColor: textColor,
                  cardColor: cardColor,
                  cardBorder: cardBorder,
                  isHighContrast: isHighContrast,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceRangeCard extends StatelessWidget {
  final RangeValues priceRange;
  final ValueChanged<RangeValues> onChanged;
  final Color cardColor;
  final Color cardBorder;
  final Color mainTeal;
  final Color textColor;
  final Color textMuted;
  final bool isHighContrast;

  const _PriceRangeCard({
    required this.priceRange,
    required this.onChanged,
    required this.cardColor,
    required this.cardBorder,
    required this.mainTeal,
    required this.textColor,
    required this.textMuted,
    required this.isHighContrast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.attach_money, color: mainTeal, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'price_range_label'.tr(),
                    style: TextStyle(fontWeight: FontWeight.w900, color: textColor, fontSize: 14),
                  ),
                ],
              ),
              Text(
                '\$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}',
                style: TextStyle(fontWeight: FontWeight.bold, color: mainTeal),
              )
            ],
          ),
          const SizedBox(height: 8),
          RangeSlider(
            values: priceRange,
            min: 0,
            max: 2000, 
            divisions: 40,
            activeColor: mainTeal,
            inactiveColor: cardBorder,
            labels: RangeLabels(
              '\$${priceRange.start.toInt()}',
              '\$${priceRange.end.toInt()}',
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _RoomDetailsCard extends StatelessWidget {
  final int? floor;
  final int bedNumber;
  final ValueChanged<int?> onFloorChanged;
  final ValueChanged<int> onBedsChanged;
  final Color cardColor;
  final Color cardBorder;
  final Color mainTeal;
  final Color textColor;
  final Color textMuted;
  final bool isHighContrast;

  const _RoomDetailsCard({
    required this.floor,
    required this.bedNumber,
    required this.onFloorChanged,
    required this.onBedsChanged,
    required this.cardColor,
    required this.cardBorder,
    required this.mainTeal,
    required this.textColor,
    required this.textMuted,
    required this.isHighContrast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: cardBorder, width: isHighContrast ? 2 : 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _CounterRow(
            label: 'floor_number_label'.tr(),
            value: floor,
            hint: floor == null ? 'any_floor_hint'.tr() : 'exact_floor_hint'.tr(),
            textColor: textColor,
            textMuted: textMuted,
            mainTeal: mainTeal,
            cardColor: cardColor,
            isHighContrast: isHighContrast,
            allowNull: true,
            onChanged: (val) => onFloorChanged(val),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(height: 1, thickness: 1),
          ),
          _CounterRow(
            label: 'beds_number_label'.tr(),
            value: bedNumber,
            hint: 'min_1_bed_hint'.tr(),
            textColor: textColor,
            textMuted: textMuted,
            mainTeal: mainTeal,
            cardColor: cardColor,
            isHighContrast: isHighContrast,
            allowNull: false,
            min: 1,
            onChanged: (val) => onBedsChanged(val ?? 1),
          ),
        ],
      ),
    );
  }
}

class _CounterRow extends StatelessWidget {
  final String label;
  final int? value;
  final String? hint;
  final Color textColor;
  final Color textMuted;
  final Color mainTeal;
  final Color cardColor;
  final bool isHighContrast;
  final bool allowNull;
  final int min;
  final ValueChanged<int?> onChanged;

  const _CounterRow({
    required this.label,
    required this.value,
    this.hint,
    required this.textColor,
    required this.textMuted,
    required this.mainTeal,
    required this.cardColor,
    required this.isHighContrast,
    this.allowNull = false,
    this.min = 0,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w900, color: textColor, fontSize: 13.5),
              ),
              if (hint != null)
                Text(
                  hint!,
                  style: TextStyle(color: textMuted, fontSize: 11.5),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        _PlusMinus(
          value: value,
          onIncrement: () => onChanged((value ?? (min - 1)) + 1),
          onDecrement: () {
            if (value == null) return;
            if (value! <= min) {
              onChanged(allowNull ? null : min);
            } else {
              onChanged(value! - 1);
            }
          },
          activeColor: mainTeal,
          cardColor: cardColor,
          textColor: textColor,
          isHighContrast: isHighContrast,
          allowNull: allowNull,
        ),
      ],
    );
  }
}

class _PlusMinus extends StatelessWidget {
  final int? value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Color activeColor;
  final Color cardColor;
  final Color textColor;
  final bool isHighContrast;
  final bool allowNull;

  const _PlusMinus({
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    required this.activeColor,
    required this.cardColor,
    required this.textColor,
    required this.isHighContrast,
    this.allowNull = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMinLimit = value == null || (!allowNull && value! <= 1);
    final disabledBg = isHighContrast ? Colors.white : (Theme.of(context).brightness == Brightness.dark ? const Color(0xFF2D3748) : const Color(0xFFE9EEF0));
    final disabledIcon = isHighContrast ? Colors.grey : const Color(0xFF99A8AE);

    return Row(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: isMinLimit ? disabledBg : (isHighContrast ? Colors.white : activeColor.withOpacity(0.1)),
            shape: BoxShape.circle,
            border: isHighContrast ? Border.all(color: Colors.black, width: 2) : null,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onDecrement,
            icon: Icon(Icons.remove, color: isMinLimit ? disabledIcon : (isHighContrast ? Colors.black : activeColor), size: 18),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 28,
          child: Center(
            child: Text(
              value == null ? '--' : value.toString().padLeft(2, '0'),
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: textColor),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: activeColor,
            shape: BoxShape.circle,
            border: isHighContrast ? Border.all(color: Colors.black, width: 2) : null,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onIncrement,
            icon: Icon(Icons.add, color: isHighContrast ? Colors.black : Colors.white, size: 18),
          ),
        ),
      ],
    );
  }
}

class _FilterOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color activeColor;
  final Color textColor;
  final Color cardBorder;
  final Color cardColor;
  final bool isHighContrast;

  const _FilterOption({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.activeColor,
    required this.textColor,
    required this.cardBorder,
    required this.cardColor,
    required this.isHighContrast,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: selected ? activeColor : cardColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? (isHighContrast ? Colors.black : Colors.transparent) : cardBorder,
            width: isHighContrast ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: selected ? (isHighContrast ? Colors.black : Colors.white) : activeColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}