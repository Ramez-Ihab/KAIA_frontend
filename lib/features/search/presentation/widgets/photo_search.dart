import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';

class PhotoSearchPage extends StatelessWidget {
  const PhotoSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Row(
                children: [
                  const Text(
                    'Search by image',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'GlacialIndifference',
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 22, color: darkgreyColor),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Upload area
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                      decoration: BoxDecoration(
                        color: greyColor.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: darkgreyColor.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: darkgreyColor.withValues(alpha: 0.12),
                            ),
                            child: Icon(
                              Icons.image_outlined,
                              size: 28,
                              color: darkgreyColor.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Upload a photo',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'GlacialIndifference',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'or take one with your camera',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'GlacialIndifference',
                              color: darkgreyColor,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Choose photo button
                          GestureDetector(
                            onTap: () {
                              // TODO: open photo picker
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                'Choose photo',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'GlacialIndifference',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Open camera button
                          GestureDetector(
                            onTap: () {
                              // TODO: open camera
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: darkgreyColor.withValues(alpha: 0.4),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.camera_alt_outlined,
                                      size: 16, color: Colors.black),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Open camera',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'GlacialIndifference',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // "or try an example" divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: darkgreyColor.withValues(alpha: 0.2),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'or try an example',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'GlacialIndifference',
                              color: darkgreyColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: darkgreyColor.withValues(alpha: 0.2),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Example image thumbnails
                    Row(
                      children: [
                        _buildExampleTile(
                          context,
                          color: const Color(0xFFD4C4A8),
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(width: 10),
                        _buildExampleTile(
                          context,
                          color: const Color(0xFFE8D5C4),
                          icon: Icons.person_outline,
                          hasBorder: true,
                        ),
                        const SizedBox(width: 10),
                        _buildExampleTile(
                          context,
                          color: const Color(0xFFB5956A),
                          icon: Icons.person_outline,
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

  Widget _buildExampleTile(
    BuildContext context, {
    required Color color,
    required IconData icon,
    bool hasBorder = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // TODO: wire example image to search
        },
        child: AspectRatio(
          aspectRatio: 0.75,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
              border: hasBorder
                  ? Border.all(
                      color: darkgreyColor.withValues(alpha: 0.2), width: 1.5)
                  : null,
            ),
            child: Icon(icon, size: 36, color: Colors.white.withValues(alpha: 0.5)),
          ),
        ),
      ),
    );
  }
}
