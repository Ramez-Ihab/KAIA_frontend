import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/constants/kaia_text_styles.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/core/widgets/brand_bottom_sheet.dart';
import 'package:kaia/features/home/presentation/widgets/style_card.dart';
import 'package:kaia/features/home/presentation/widgets/horizontal_card_section.dart';
import 'package:kaia/features/search/presentation/widgets/photo_search.dart';
import 'package:kaia/features/search/presentation/bloc/search_bloc.dart';
import 'package:kaia/features/search/presentation/bloc/search_event.dart';
import 'package:kaia/features/search/presentation/bloc/search_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<StyleCard> _buildPopularCards() {
    final okhtein = Brand(
      name: 'Okhtein', initials: 'OK', country: Country.egypt,
      categories: [BrandCategory.bags, BrandCategory.jewellery],
      websiteUrl: 'https://example.com', shipsTo: [Country.egypt], isFavorited: true,
    );
    final reemami = Brand(
      name: 'Reemami', initials: 'RE', country: Country.egypt,
      categories: [BrandCategory.womenswear],
      websiteUrl: 'https://example.com', shipsTo: [Country.egypt], isFavorited: false,
    );
    final emergencyRoom = Brand(
      name: 'Emergency Room Beirut', initials: 'ER', country: Country.lebanon,
      categories: [BrandCategory.womenswear],
      websiteUrl: 'https://example.com', shipsTo: [Country.lebanon], isFavorited: false,
    );
    final dalya = Brand(
      name: 'Dalya', initials: 'DA', country: Country.egypt,
      categories: [BrandCategory.womenswear],
      websiteUrl: 'https://example.com', shipsTo: [Country.egypt], isFavorited: false,
    );

    final popularLooks = [
      Look(imageUrl: '', styleTag: 'Night Out', brand: okhtein, color: const Color.fromARGB(255, 255, 255, 255)),
      Look(imageUrl: '', styleTag: 'Birthday', brand: reemami, color: Colors.brown),
      Look(imageUrl: '', styleTag: 'Casual', brand: emergencyRoom, color: Colors.green),
      Look(imageUrl: '', styleTag: 'Romantic', brand: dalya, color: Colors.deepPurple),
    ];
    return popularLooks.map((look) => StyleCard(look: look)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Image.asset('assets/images/KAIA.png', width: 200, height: 48, alignment: Alignment.topLeft),
            ),
            const SizedBox(height: 10),

            // Search bar
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(7.0, 0, 7.0, 0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(Icons.search, color: darkgreyColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          context.read<SearchBloc>().add(SearchTextChanged(value));
                        },
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'GlacialIndifference',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search or scan a photo...',
                          hintStyle: TextStyle(
                            color: darkgreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'GlacialIndifference',
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (state.isSearching)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          context.read<SearchBloc>().add(ClearSearch());
                        },
                        child: Icon(Icons.close, color: darkgreyColor, size: 18),
                      ),
                    const SizedBox(width: 8),
                    VerticalDivider(
                      color: darkgreyColor,
                      thickness: 0.5,
                      width: 2,
                      indent: 15,
                      endIndent: 15,
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt_outlined, color: primaryColor, size: 20),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PhotoSearchPage()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Content
            Expanded(
              child: state.isSearching
                  ? state.hasResults
                      ? _buildSearchResults(context, state)
                      : _buildNoResults(state)
                  : state.hasRecentSearches
                      ? _buildRecent(context, state)
                      : _buildNoRecent(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecent(BuildContext context, SearchState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(7.0, 0, 7.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RECENT', style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 184, 184, 184),
                  letterSpacing: 1,
                  fontFamily: 'GlacialIndifference',
                )),
                GestureDetector(
                  onTap: () {
                    context.read<SearchBloc>().add(ClearAllRecentSearches());
                  },
                  child: Text('Clear all', style: linkText),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: state.recentSearches.map((search) {
                return InputChip(
                  label: Text(
                    search,
                    style: const TextStyle(
                      fontFamily: 'GlacialIndifference',
                      fontSize: 16,
                    ),
                  ),
                  onDeleted: () {
                    context.read<SearchBloc>().add(RemoveRecentSearchEvent(search));
                  },
                  deleteIcon: const Icon(Icons.close, size: 14),
                  shape: const StadiumBorder(),
                  backgroundColor: greyColor,
                  side: BorderSide.none,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            HorizontalCardSection(
              title: 'POPULAR RIGHT NOW',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 184, 184, 184),
                letterSpacing: 1,
                fontFamily: 'GlacialIndifference',
              ),
              cards: _buildPopularCards(),
              onSeeAllTap: null,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildNoRecent() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(7.0, 0, 7.0, 0),
      child: Column(children: [
        HorizontalCardSection(
          title: 'POPULAR RIGHT NOW',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 184, 184, 184),
            letterSpacing: 1,
            fontFamily: 'GlacialIndifference',
          ),
          cards: _buildPopularCards(),
          onSeeAllTap: null,
        ),
        const SizedBox(height: 10),
      ]),
    );
  }

  Widget _buildSearchResults(BuildContext context, SearchState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(7.0, 0, 7.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.matchingRecent.isNotEmpty) ...[
              Text('MATCHING RECENT', style: sectionLabel),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.matchingRecent.map((search) {
                  return InputChip(
                    label: Text(
                      search,
                      style: const TextStyle(
                        fontFamily: 'GlacialIndifference',
                        fontSize: 13,
                      ),
                    ),
                    onDeleted: () {
                      context.read<SearchBloc>().add(RemoveRecentSearchEvent(search));
                    },
                    deleteIcon: const Icon(Icons.close, size: 14),
                    shape: const StadiumBorder(),
                    backgroundColor: greyColor,
                    side: BorderSide.none,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
            if (state.matchingBrands.isNotEmpty) ...[
              Text('BRANDS (${state.matchingBrands.length})', style: sectionLabel),
              const SizedBox(height: 10),
              ...state.matchingBrands.map((brand) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () => BrandBottomSheet.show(context, brand),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEADBD5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                brand.initials,
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'GlacialIndifference',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  brand.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    fontFamily: 'GlacialIndifference',
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  '${brand.categories.map((c) => c.label).join(', ')} · ${brand.country.label}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'GlacialIndifference',
                                    color: darkgreyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(0, 0),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Visit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'GlacialIndifference',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNoResults(SearchState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Icon(Icons.search, color: darkgreyColor.withValues(alpha:0.3), size: 50),
          const SizedBox(height: 16),
          Text(
            'No results for "${state.searchText}"',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'GlacialIndifference',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different style, mood, or brand name',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'GlacialIndifference',
              color: darkgreyColor,
            ),
          ),
        ],
      ),
    );
  }
}