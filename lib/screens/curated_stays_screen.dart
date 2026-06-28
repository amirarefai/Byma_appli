import 'package:flutter/material.dart';

class CuratedStaysScreen extends StatelessWidget {
  final String location;
  final dynamic dateRange; // أو غير النوع حسب الـ Type لـ selectedDateRange عندك

  const CuratedStaysScreen({
    Key? key,
    required this.location,
    required this.dateRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curated Stays'),
      ),
      body: Center(
        child: Text('Location: $location'),
      ),
    );
  }
}