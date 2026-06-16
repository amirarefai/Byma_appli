import 'package:flutter/material.dart';

class ProfileSecurityUpdated extends StatefulWidget {
  const ProfileSecurityUpdated({super.key});

  @override
  State<ProfileSecurityUpdated> createState() =>
      _ProfileSecurityUpdatedState();
}

class _ProfileSecurityUpdatedState extends State<ProfileSecurityUpdated> {
  bool _themeOn = false;

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF2F6F7);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF072332)),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Account Settings',
          style: TextStyle(
            color: Color(0xFF072332),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),

              // Account / avatar header (approx. matching the provided design)
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
                        border: Border.all(
                          color: const Color(0xFF0E7E8A),
                          width: 4,
                        ),
                      ),
                      child: ClipOval(
                        child: Container(
                          color: const Color(0xFFF2F6F7),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 8,
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF0E7E8A),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0E7E8A).withOpacity(0.28),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              const Center(
                child: Text(
                  'Alex Curator',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF000000),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Profile card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: const Color(0xFFE5EEF1),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Section header row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD7F0F6),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            color: Color(0xFF0F4B61),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Personal\nInformation',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF072332),
                              fontSize: 22,
                              height: 1.05,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFD0E3E7),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: Color(0xFF94A3B8),
                            size: 22,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // Fields
                    _Field(
                      label: 'FULL NAME',
                      value: 'Alex Curator',
                    ),
                    _Field(
                      label: 'EMAIL ADDRESS',
                      value: 'alex.c@bymatravel.com',
                    ),
                    _Field(
                      label: 'PHONE NUMBER',
                      value: '+1 (555) 0123 4567',
                    ),
                    _Field(
                      label: 'DATE OF BIRTH',
                      value: 'March 24, 1988',
                    ),
                    _Field(
                      label: 'GENDER',
                      value: 'Male',
                    ),

                    const SizedBox(height: 10),

                    // Password row with "Change"
                    Row(
                      children: [
                        const Expanded(
                          child: _Field(
                            label: 'PASSWORD',
                            value: '••••••••••',
                            asPassword: true,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.refresh,
                            color: Color(0xFF0E7E8A),
                          ),
                        ),
                        const Text(
                          'Change',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0E7E8A),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Edit profile button
                    SizedBox(
                      height: 56,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF66D0FF),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                        ),
                        label: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String value;
  final bool asPassword;

  const _Field({
    required this.label,
    required this.value,
    this.asPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF52AAB5),
              letterSpacing: 1.2,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF072332),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
