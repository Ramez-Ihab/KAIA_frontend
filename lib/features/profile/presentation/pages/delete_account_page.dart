import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final _confirmController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _deleteUnlocked = false;

  @override
  void initState() {
    super.initState();
    _confirmController.addListener(() {
      final unlocked = _confirmController.text == 'DELETE';
      if (unlocked != _deleteUnlocked) setState(() => _deleteUnlocked = unlocked);
    });
  }

  @override
  void dispose() {
    _confirmController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onDelete() {
    // TODO: wire to delete account domain use case
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 22),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Delete account',
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

                    // Warning card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.warning_amber_rounded,
                              color: Colors.red, size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "This can't be undone.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'GlacialIndifference',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Your account, saved items, collections, brand favourites, and history will be permanently deleted.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'GlacialIndifference',
                                    color: Colors.red.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Account
                    _buildLabel('ACCOUNT'),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: greyColor.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'you@example.com',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'GlacialIndifference',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Type DELETE
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'GlacialIndifference',
                          fontWeight: FontWeight.w700,
                          color: darkgreyColor,
                          letterSpacing: 1,
                        ),
                        children: const [
                          TextSpan(text: 'TYPE '),
                          TextSpan(
                            text: 'DELETE',
                            style: TextStyle(color: Colors.red),
                          ),
                          TextSpan(text: ' TO CONFIRM'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: greyColor.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _confirmController,
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'GlacialIndifference',
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          hintText: 'DELETE',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontFamily: 'GlacialIndifference',
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            color: darkgreyColor.withValues(alpha: 0.4),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Confirm with password
                    _buildLabel('CONFIRM WITH PASSWORD'),
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
                    const SizedBox(height: 32),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
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
                            onTap: _deleteUnlocked ? _onDelete : null,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: _deleteUnlocked
                                    ? Colors.red
                                    : Colors.red.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Delete account',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'GlacialIndifference',
                                  fontWeight: FontWeight.w600,
                                  color: _deleteUnlocked
                                      ? Colors.white
                                      : Colors.red.withValues(alpha: 0.5),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'GlacialIndifference',
        fontWeight: FontWeight.w700,
        color: darkgreyColor,
        letterSpacing: 1,
      ),
    );
  }
}
