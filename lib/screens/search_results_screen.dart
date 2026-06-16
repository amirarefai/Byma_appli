import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final startDate = DateFormat('MMM dd').format(dateRange.start);
    final endDate = DateFormat('MMM dd').format(dateRange.end);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // كرت يعرض تفاصيل البحث التي تم تمريرها
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Destination: $location',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Stay: $startDate - $endDate',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Expanded(
              child: Center(
                child: Text(
                  'Available Hotels List Coming Soon...',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}