import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';

class ArchiveAccountPage extends StatefulWidget {
  const ArchiveAccountPage({super.key});

  @override
  State<ArchiveAccountPage> createState() => _ArchiveAccountPageState();
}

class _ArchiveAccountPageState extends State<ArchiveAccountPage> {
  final _passwordController = TextEditingController();
  String? _selectedReason;
  bool _understood = false;

  static const _reasons = [
    'Taking a break',
    'Too many notifications',
    'Privacy reasons',
    'Not using it right now',
    'Other',
  ];

  static const _whatHappens = [
    ('Your profile is hidden', 'Others won\'t see your name, photo or activity'),
    ('Notifications pause', 'No emails or push alerts while you\'re away'),
    ('Saved items are kept', 'Saves, categories and brand favourites stay put'),
    ('Reactivate any time', 'Sign in to restore your account instantly'),
  ];

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onArchive() {
    // TODO: wire to archive account domain use case
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Logo
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/images/KAIA.png',
                  width: 200, height: 48, alignment: Alignment.topLeft),
            ),
            // Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 22),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Archive account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'GlacialIndifference',
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 0.5),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Info card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.archive_outlined,
                              color: oliveColor, size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Taking a break? No problem.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'GlacialIndifference',
                                    fontWeight: FontWeight.w700,
                                    color: oliveColor,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Archiving hides your profile and pauses notifications. Your saved items, collections and brand favourites are kept safe — sign back in any time to restore everything.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'GlacialIndifference',
                                    color: oliveColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // What happens
                    Text(
                      'WHAT HAPPENS',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'GlacialIndifference',
                        fontWeight: FontWeight.w700,
                        color: darkgreyColor,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._whatHappens.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check, size: 18, color: oliveColor),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.$1,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'GlacialIndifference',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      item.$2,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'GlacialIndifference',
                                        color: darkgreyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 8),

                    // Reason
                    Text(
                      'REASON (OPTIONAL)',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'GlacialIndifference',
                        fontWeight: FontWeight.w700,
                        color: darkgreyColor,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _reasons.map((reason) {
                        final isSelected = _selectedReason == reason;
                        return GestureDetector(
                          onTap: () => setState(() =>
                              _selectedReason =
                                  isSelected ? null : reason),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? primaryColor.withValues(alpha: 0.08)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? primaryColor.withValues(alpha: 0.4)
                                    : darkgreyColor.withValues(alpha: 0.35),
                              ),
                            ),
                            child: Text(
                              reason,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'GlacialIndifference',
                                color: isSelected ? primaryColor : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Account display
                    Text(
                      'ACCOUNT',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'GlacialIndifference',
                        fontWeight: FontWeight.w700,
                        color: darkgreyColor,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: greyColor.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'you@example.com',
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'GlacialIndifference',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Confirm with password
                    Text(
                      'CONFIRM WITH PASSWORD',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'GlacialIndifference',
                        fontWeight: FontWeight.w700,
                        color: darkgreyColor,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: greyColor.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'GlacialIndifference',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Your current password',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontFamily: 'GlacialIndifference',
                            color: darkgreyColor.withValues(alpha: 0.5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Checkbox
                    GestureDetector(
                      onTap: () =>
                          setState(() => _understood = !_understood),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: _understood,
                              onChanged: (v) =>
                                  setState(() => _understood = v ?? false),
                              activeColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'I understand my account will be hidden until I sign back in to reactivate it.',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'GlacialIndifference',
                                color: darkgreyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: greyColor.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'GlacialIndifference',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: _understood ? _onArchive : null,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: _understood
                                    ? primaryColor
                                    : secondaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Archive account',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'GlacialIndifference',
                                  fontWeight: FontWeight.w600,
                                  color: _understood
                                      ? Colors.white
                                      : primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
