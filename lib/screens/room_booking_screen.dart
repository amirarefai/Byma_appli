import 'package:byma_app/business_logic/create_booking/cubit/create_booking_cubit.dart';
import 'package:byma_app/business_logic/create_booking/cubit/create_booking_state.dart';
import 'package:byma_app/business_logic/special_services/cubit/special_services_cubit.dart';
import 'package:byma_app/business_logic/special_services/cubit/special_services_state.dart';
import 'package:byma_app/data/models/create_booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RoomBookingScreen extends StatefulWidget {
  final int roomId;

  const RoomBookingScreen({
    super.key,
    required this.roomId,
  });

  @override
  State<RoomBookingScreen> createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  final Set<int> _selectedServiceIds = <int>{};

  @override
  void initState() {
    super.initState();
    context.read<SpecialServicesCubit>().fetchAllSpecialServices(widget.roomId);
  }

  Future<void> _pickDate({required bool isStartDate}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );

    if (pickedDate == null) return;

    setState(() {
      if (isStartDate) {
        _startDate = pickedDate;
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = null;
        }
      } else {
        _endDate = pickedDate;
      }
    });
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  void _submitBooking() {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose the booking start and end dates.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final model = CreateBookingModel(
      roomId: widget.roomId,
      startDate: _formatDate(_startDate!),
      endDate: _formatDate(_endDate!),
      specialServiceIds: _selectedServiceIds.toList(),
    );

    context.read<CreateBookingCubit>().createBooking(model);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;
    final surfaceColor = theme.cardColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Booking'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<CreateBookingCubit, CreateBookingState>(
        listener: (context, state) {
          state.whenOrNull(
            success: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking created successfully.'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop();
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        builder: (context, createBookingState) {
          final isSubmitting = createBookingState.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return BlocBuilder<SpecialServicesCubit, SpecialServicesState>(
            builder: (context, specialServicesState) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking Details',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Pick your stay dates and optional services for room $widget.roomId.',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: _DateSelectorCard(
                                label: 'Start Date',
                                value: _startDate == null
                                    ? 'Select date'
                                    : _formatDate(_startDate!),
                                onTap: () => _pickDate(isStartDate: true),
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _DateSelectorCard(
                                label: 'End Date',
                                value: _endDate == null
                                    ? 'Select date'
                                    : _formatDate(_endDate!),
                                onTap: () => _pickDate(isStartDate: false),
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        Text(
                          'Special Services',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: surfaceColor,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: theme.dividerColor,
                              width: 1,
                            ),
                          ),
                          child: specialServicesState.when(
                            initial: () => const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            loading: () => const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            success: (items) => items.isEmpty
                                ? const Text('No special services available for this room.')
                                : Column(
                                    children: items.map((service) {
                                      final isSelected = _selectedServiceIds.contains(service.id);

                                      return Material(
                                        color: Colors.transparent,
                                        child: CheckboxListTile(
                                          value: isSelected,
                                          onChanged: isSubmitting
                                              ? null
                                              : (value) {
                                                  setState(() {
                                                    if (value == true) {
                                                      _selectedServiceIds.add(service.id);
                                                    } else {
                                                      _selectedServiceIds.remove(service.id);
                                                    }
                                                  });
                                                },
                                          title: Text(service.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          contentPadding: EdgeInsets.zero,
                                          activeColor: primaryColor,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                            error: (message) => Text(
                              message,
                              style: TextStyle(color: theme.colorScheme.error),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isSubmitting ? null : _submitBooking,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: isSubmitting
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Confirm Booking',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _DateSelectorCard extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;
  final Color color;

  const _DateSelectorCard({
    required this.label,
    required this.value,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                Icon(Icons.calendar_today_outlined, color: color, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}