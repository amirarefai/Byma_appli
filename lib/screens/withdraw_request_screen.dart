import 'package:byma_app/business_logic/create_withdraw/cubit/create_withdraw_cubit.dart';
import 'package:byma_app/business_logic/create_withdraw/cubit/create_withdraw_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WithdrawRequestScreen extends StatefulWidget {
  const WithdrawRequestScreen({super.key});

  @override
  State<WithdrawRequestScreen> createState() => _WithdrawRequestScreenState();
}

class _WithdrawRequestScreenState extends State<WithdrawRequestScreen> {
  final TextEditingController _amountController = TextEditingController(text: "0.00");

  @override
  void dispose() {
    _amountController.dispose(); // Best practice: always dispose controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryDarkTeal = Color(0xFF0A5870);
    const currencyBlue = Color(0xFF005B7F);
    const textDark = Color(0xFF1E282C);
    const buttonCyanLight = Color(0xFF67CEF5);
    
    const bgGradientStart = Color(0xFFF7FCFE);
    const bgGradientEnd = Color(0xFFEAF4F8);

    return Scaffold(
      // 1. Wrap the body in a BlocConsumer
      body: BlocConsumer<CreateWithdrawCubit, CreateWithdrawState>(
        listener: (context, state) {
          // 2. Handle side-effects (Snackbars, Navigation)
          state.whenOrNull(
            success: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Withdraw request submitted successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              // Pop the screen after a successful request
              Navigator.of(context).pop(); 
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
          // 3. Determine if the UI should be in a loading state
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- App Bar ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: primaryDarkTeal),
                          onPressed: () {
                            // Prevent back navigation while loading
                            if (!isLoading && Navigator.canPop(context)) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                        const Text(
                          'Withdraw Request',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryDarkTeal,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.help_outline, color: primaryDarkTeal, size: 26),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // --- Subtitle ---
                    const Text(
                      'Enter the amount you wish to withdraw from your wallet. Funds will be transferred to your linked bank account.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF62727D),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- Amount Input Card ---
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                          const Text(
                            'Withdrawal Amount',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A5A64),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '\$',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: currencyBlue,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _amountController,
                                  textAlign: TextAlign.right,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  enabled: !isLoading, // Disable input while loading
                                  style: const TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: textDark,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // --- Submit Request Button ---
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: const LinearGradient(
                          colors: [primaryDarkTeal, buttonCyanLight],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: buttonCyanLight.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        // 4. Validate input and trigger Cubit
                        onPressed: isLoading
                            ? null
                            : () {
                                final inputText = _amountController.text.trim();
                                // Parse to num since the Cubit expects a num
                                final amount = num.tryParse(inputText);

                                if (amount != null && amount > 0) {
                                  context
                                      .read<CreateWithdrawCubit>()
                                      .createWithdraw(amount);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please enter a valid withdrawal amount.'),
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
                        // 5. Swap child based on loading state
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
                                    'Submit Request',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward, color: Colors.white),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
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