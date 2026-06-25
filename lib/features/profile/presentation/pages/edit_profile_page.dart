import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';

class EditProfilePage extends StatefulWidget {
  final String initialName;
  final String initialUsername;
  final void Function(String name, String username) onSaved;

  const EditProfilePage({
    super.key,
    required this.initialName,
    required this.initialUsername,
    required this.onSaved,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _usernameController = TextEditingController(text: widget.initialUsername);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _onSave() {
    // TODO: wire to update profile domain use case
    widget.onSaved(
      _nameController.text.trim(),
      _usernameController.text.trim(),
    );
    Navigator.pop(context);
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Image.asset(
                'assets/images/KAIA.png',
                width: 200,
                height: 48,
                alignment: Alignment.topLeft,
              ),
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
                    'Edit profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'GlacialIndifference',
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _onSave,
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'GlacialIndifference',
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 0.5),
            const SizedBox(height: 32),

            // Profile photo
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkgreyColor.withValues(alpha: 0.15),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: darkgreyColor.withValues(alpha: 0.4),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.55),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),

            // Name field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NAME',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'GlacialIndifference',
                      fontWeight: FontWeight.w700,
                      color: darkgreyColor,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(_nameController, 'Your Name'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Username field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'USERNAME',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'GlacialIndifference',
                      fontWeight: FontWeight.w700,
                      color: darkgreyColor,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    _usernameController,
                    'username',
                    prefix: Text(
                      '@ ',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'GlacialIndifference',
                        color: darkgreyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    Widget? prefix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: greyColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
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
          prefixIcon: prefix != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  child: prefix,
                )
              : null,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
