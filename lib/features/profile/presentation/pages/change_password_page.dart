import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showNewPassword = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSave() {
    // TODO: wire to update password domain use case
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Image.asset('assets/images/KAIA.png',
                width: 200, height: 48, alignment: Alignment.topLeft),
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
                    'Change password',
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
            const SizedBox(height: 28),

            // Fields
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('CURRENT PASSWORD'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _currentPasswordController,
                      hint: 'Enter current password',
                      obscure: true,
                    ),
                    const SizedBox(height: 20),
                    _buildLabel('NEW PASSWORD'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _newPasswordController,
                      hint: 'At least 8 characters',
                      obscure: !_showNewPassword,
                      suffix: GestureDetector(
                        onTap: () =>
                            setState(() => _showNewPassword = !_showNewPassword),
                        child: Icon(
                          _showNewPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                          color: darkgreyColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildLabel('CONFIRM NEW PASSWORD'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _confirmPasswordController,
                      hint: 'Re-enter new password',
                      obscure: true,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Use at least 8 characters with a mix of letters, numbers, and symbols.',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'GlacialIndifference',
                        color: darkgreyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Save button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: GestureDetector(
                onTap: _onSave,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Save changes',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GlacialIndifference',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: greyColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          fontSize: 15,
          fontFamily: 'GlacialIndifference',
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 15,
            fontFamily: 'GlacialIndifference',
            color: darkgreyColor.withValues(alpha: 0.5),
          ),
          suffixIcon: suffix != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: suffix,
                )
              : null,
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
