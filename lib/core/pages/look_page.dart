import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/core/widgets/brand_bottom_sheet.dart';
import 'package:kaia/core/widgets/look_image.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_event.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_state.dart';

class LookPage extends StatefulWidget {
  final Look look;

  const LookPage({super.key, required this.look});

  static void show(BuildContext context, Look look) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LookPage(look: look)),
    );
  }

  @override
  State<LookPage> createState() => _LookPageState();
}

class _LookPageState extends State<LookPage> {
  int _currentImage = 0;
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<String> get _activeImages {
    final look = widget.look;
    if (look.colors.isEmpty) return look.imageUrls;
    final colorImages = look.colors[_selectedColorIndex].imageUrls;
    return colorImages.isNotEmpty ? colorImages : look.imageUrls;
  }

  void _selectColor(int index) {
    setState(() {
      _selectedColorIndex = index;
      _currentImage = 0;
    });
    _pageController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    final look = widget.look;
    final images = _activeImages;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image carousel ──────────────────────────────────────────
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.58,
              child: Stack(
                children: [
                  // PageView
                  PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (i) => setState(() => _currentImage = i),
                    itemBuilder: (_, i) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          opaque: false,
                          barrierColor: Colors.black,
                          pageBuilder: (_, __, ___) =>
                              _FullScreenImagePage(url: images[i]),
                          transitionsBuilder: (_, anim, __, child) =>
                              FadeTransition(opacity: anim, child: child),
                        ),
                      ),
                      child: LookImage(
                        look: look.copyWithUrl(images[i]),
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),

                  // Back button
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.35),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ),

                  // Bookmark button
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: BlocBuilder<SavedBloc, SavedState>(
                          builder: (context, state) {
                            final isSaved =
                                context.read<SavedBloc>().isLookSaved(look);
                            return GestureDetector(
                              onTap: () => context
                                  .read<SavedBloc>()
                                  .add(ToggleSaveItemEvent(look)),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isSaved
                                      ? primaryColor
                                      : Colors.black.withValues(alpha: 0.35),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isSaved
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Dot indicators
                  if (images.length > 1)
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(images.length, (i) {
                          final active = i == _currentImage;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: active ? 20 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: active
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          );
                        }),
                      ),
                    ),
                ],
              ),
            ),

            // ── Product info ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => BrandBottomSheet.show(context, look.brand),
                    child: Text(
                      look.brand.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontFamily: 'GlacialIndifference',
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationThickness: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    look.styleTag,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GlacialIndifference',
                      color: darkgreyColor,
                    ),
                  ),
                  if (look.price != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      '\$${look.price!.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'GlacialIndifference',
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                  ],

                  // Color swatches
                  if (look.colors.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      'Color: ${look.colors[_selectedColorIndex].name}',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'GlacialIndifference',
                        fontWeight: FontWeight.w500,
                        color: darkgreyColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: look.colors.asMap().entries.map((e) {
                        final selected = e.key == _selectedColorIndex;
                        return GestureDetector(
                          onTap: () => _selectColor(e.key),
                          child: Container(
                            width: 32,
                            height: 32,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: e.value.color,
                              border: Border.all(
                                color: selected ? primaryColor : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  // Size dropdown
                  if (look.sizes.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      'Size',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'GlacialIndifference',
                        fontWeight: FontWeight.w500,
                        color: darkgreyColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: darkgreyColor.withValues(alpha: 0.3)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: look.sizes[_selectedSizeIndex],
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: darkgreyColor),
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'GlacialIndifference',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedSizeIndex =
                                  look.sizes.indexOf(val));
                            }
                          },
                          items: look.sizes
                              .map((s) => DropdownMenuItem(
                                    value: s,
                                    child: Text('$s'),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),

                  // Available at
                  Text(
                    'AVAILABLE AT',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'GlacialIndifference',
                      fontWeight: FontWeight.w700,
                      color: darkgreyColor,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            look.brand.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'GlacialIndifference',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '·',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                          if (look.price != null)
                            Text(
                              '\$${look.price!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'GlacialIndifference',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          const Spacer(),
                          const Icon(Icons.open_in_new,
                              size: 16, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Shop similar ─────────────────────────────────────────────
            if (look.similarLooks.isNotEmpty) ...[
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Shop similar',
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'GlacialIndifference',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _MasonryGrid(looks: look.similarLooks),
              ),
              const SizedBox(height: 24),
            ],
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

// ── Inline masonry grid (same visual style as SeeAllPage) ────────────────────
class _MasonryGrid extends StatelessWidget {
  final List<Look> looks;

  const _MasonryGrid({required this.looks});

  @override
  Widget build(BuildContext context) {
    final left = <Look>[];
    final right = <Look>[];
    for (int i = 0; i < looks.length; i++) {
      if (i % 2 == 0) left.add(looks[i]); else right.add(looks[i]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: left.asMap().entries.map((e) {
              return Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 10),
                child: SizedBox(
                  height: e.key % 2 == 0 ? 240 : 180,
                  child: _SimilarCard(look: e.value),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: right.asMap().entries.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 10),
                  child: SizedBox(
                    height: e.key % 2 == 0 ? 180 : 240,
                    child: _SimilarCard(look: e.value),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _SimilarCard extends StatelessWidget {
  final Look look;

  const _SimilarCard({required this.look});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => LookPage.show(context, look),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(child: LookImage(look: look)),
            Positioned(
              bottom: 0, left: 0, right: 0, height: 80,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8, right: 8,
              child: BlocBuilder<SavedBloc, SavedState>(
                builder: (context, state) {
                  final isSaved =
                      context.read<SavedBloc>().isLookSaved(look);
                  return GestureDetector(
                    onTap: () => context
                        .read<SavedBloc>()
                        .add(ToggleSaveItemEvent(look)),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 12, left: 12, right: 40,
              child: Text(
                look.styleTag,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'GlacialIndifference',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Positioned(
              bottom: 28, left: 12, right: 40,
              child: Text(
                look.brand.name,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'GlacialIndifference',
                  color: Colors.white.withValues(alpha: 0.8),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Full-screen image viewer ──────────────────────────────────────────────────
class _FullScreenImagePage extends StatelessWidget {
  final String url;

  const _FullScreenImagePage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              minScale: 0.8,
              maxScale: 4.0,
              child: Image.network(
                url,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
