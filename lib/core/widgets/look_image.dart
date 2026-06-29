import 'package:flutter/material.dart';
import 'package:kaia/core/entities/look.dart';

/// Renders look.color as a background, then layers Image.network on top.
/// While loading or on error the color shows through — no broken widgets.
class LookImage extends StatelessWidget {
  final Look look;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius borderRadius;

  static const _fallback = Color(0xFFE0D5C8);

  const LookImage({
    super.key,
    required this.look,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    final url = look.imageUrl;
    final bg = look.color ?? _fallback;

    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: width,
        height: height,
        color: bg,
        child: (url != null && url.isNotEmpty)
            ? Image.network(
                url,
                width: width,
                height: height,
                fit: fit,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                loadingBuilder: (_, child, progress) =>
                    progress == null ? child : const SizedBox.shrink(),
              )
            : null,
      ),
    );
  }
}
