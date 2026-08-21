import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; 
import 'package:byma_app/business_logic/bookings_transactions/cubit/bookings_transactions_cubit.dart';
import 'package:byma_app/data/models/bookings_transactions_model.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the screen initializes
    context.read<BookingsTransactionsCubit>().fetchBookingsTransactions();
  }

  // Method to allow manual pull-to-refresh
  Future<void> _onRefresh() async {
    await context.read<BookingsTransactionsCubit>().fetchBookingsTransactions();
  }

  @override
  Widget build(BuildContext context) {
    const primaryDarkTeal = Color(0xFF0F5B78);
    const bgGradientStart = Color(0xFFF7FCFE);
    const bgGradientEnd = Color(0xFFEAF4F8);

    return Scaffold(
      body: Container(
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
              // App Bar
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: primaryDarkTeal, size: 22),
                          onPressed: () => Navigator.maybePop(context),
                        ),
                        const Expanded(
                          child: Text(
                            'Reservations',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryDarkTeal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48), // To balance the menu icon
                      ],
                    ),
                  ),
                  const Divider(color: Color(0xFFE5EAEF), height: 1, thickness: 1),
                ],
              ),

              // Dynamic List View with State Management
              Expanded(
                child: BlocBuilder<BookingsTransactionsCubit, BookingsTransactionsState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(child: CircularProgressIndicator(color: primaryDarkTeal)),
                      loading: () => const Center(child: CircularProgressIndicator(color: primaryDarkTeal)),
                      error: (message) => _buildErrorState(message, primaryDarkTeal),
                      success: (transactions) {
                        if (transactions.isEmpty) {
                          return _buildEmptyState(primaryDarkTeal);
                        }

                        // Pull to refresh implemented here
                        return RefreshIndicator(
                          onRefresh: _onRefresh,
                          color: primaryDarkTeal,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final item = transactions[index];
                              return _buildReservationCard(item);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 64, color: color.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            'No reservations found.',
            style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message, Color color) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
              ),
              onPressed: () => context.read<BookingsTransactionsCubit>().fetchBookingsTransactions(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  // Updated to accept BookingsTransactionsModel instead of static model
  Widget _buildReservationCard(BookingsTransactionsModel item) {
    // Determine colors based on the backend API enum ('booking', 'update', 'cancel')
    Color statusBgColor;
    Color statusTextColor;
    
    // Using .toLowerCase() ensures safety against unexpected backend capitalization
    final transactionType = item.type.toLowerCase();

    switch (transactionType) {
      case 'booking':
        statusBgColor = const Color(0xFFBCEEE1);
        statusTextColor = const Color(0xFF0F7263);
        break;
      case 'update':
        statusBgColor = const Color(0xFFFDECDA);
        statusTextColor = const Color(0xFFC86E1B);
        break;
      case 'cancel':
      default:
        statusBgColor = const Color(0xFFFCD8DA);
        statusTextColor = const Color(0xFFD33947);
        break;
    }

    // Capitalize the first letter for UI display (e.g., 'booking' -> 'Booking')
    final displayStatus = transactionType.isNotEmpty 
        ? '${transactionType[0].toUpperCase()}${transactionType.substring(1)}'
        : 'Unknown';

    // Format Date using intl package: 'Oct 25, 2023 - 11:00 AM'
    final formattedDate = DateFormat(
      'MMM dd, yyyy - hh:mm a',
      'en',
    ).format(item.createdAt);
    
    // Format Price to 2 decimal places
    final formattedPrice = item.amount.toStringAsFixed(2);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  item.hotelName.isNotEmpty ? item.hotelName : 'Unknown Hotel',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E282C),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  displayStatus,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusTextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          Row(
            children: [
              const Icon(
                Icons.meeting_room_outlined,
                size: 18,
                color: Color(0xFF62727D),
              ),
              const SizedBox(width: 6),
              Text(
                item.roomNumber.isNotEmpty ? item.roomNumber : 'TBD',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF62727D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    '\$ ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F5B78),
                    ),
                  ),
                  Text(
                    formattedPrice,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F5B78),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 15,
                    color: Color(0xFF7D8C97),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7D8C97),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}