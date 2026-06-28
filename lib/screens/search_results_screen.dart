import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchResultsScreen extends StatelessWidget {
  final String location;
  final DateTimeRange dateRange;

  const SearchResultsScreen({
    super.key,
    required this.location,
    required this.dateRange,
  });

  @override
  Widget build(BuildContext context) {
    // تنسيق التاريخ بشكل مبسط يناسب لغة التطبيق الحالية
    final startDate = DateFormat('MMM dd', context.locale.toString()).format(dateRange.start);
    final endDate = DateFormat('MMM dd', context.locale.toString()).format(dateRange.end);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'search_results_title'.tr(), 
          style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // كرت يعرض تفاصيل البحث التي تم تمريرها بالترجمة الديناميكية
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.teal),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'search_destination_label'.tr(namedArgs: {'location': location}),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'search_stay_label'.tr(namedArgs: {'start': startDate, 'end': endDate}),
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Text(
                  'coming_soon_text'.tr(),
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}