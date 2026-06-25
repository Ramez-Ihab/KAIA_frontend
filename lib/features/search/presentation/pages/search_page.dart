import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/constants/kaia_text_styles.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/features/home/presentation/widgets/style_card.dart';
import 'package:kaia/features/home/presentation/widgets/horizontal_card_section.dart';
import 'package:kaia/features/search/presentation/widgets/photo_search.dart';
import 'package:kaia/core/pages/see_all_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  final List<String> _recentSearches = [
    'Spring florals',
    'Minimalist',
    'Night out',
    'Cairo inspo',
    'Boho',
  ];

  // Brands for popular looks
  final _okhtein = Brand(
    name: 'Okhtein',
    initials: 'OK',
    country: Country.egypt,
    categories: [BrandCategory.bags, BrandCategory.jewellery],
    websiteUrl: 'https://example.com',
    shipsTo: [Country.egypt],
    isFavorited: true,
  );

  final _reemami = Brand(
    name: 'Reemami',
    initials: 'RE',
    country: Country.egypt,
    categories: [BrandCategory.womenswear],
    websiteUrl: 'https://example.com',
    shipsTo: [Country.egypt],
    isFavorited: false,
  );

  final _emergencyRoom = Brand(
    name: 'Emergency Room Beirut',
    initials: 'ER',
    country: Country.lebanon,
    categories: [BrandCategory.womenswear],
    websiteUrl: 'https://example.com',
    shipsTo: [Country.lebanon],
    isFavorited: false,
  );

  final _dalya = Brand(
    name: 'Dalya',
    initials: 'DA',
    country: Country.egypt,
    categories: [BrandCategory.womenswear],
    websiteUrl: 'https://example.com',
    shipsTo: [Country.egypt],
    isFavorited: false,
  );

  // Brands for search results
  final List<Brand> _searchableBrands = [
    Brand(
      name: '6901 Cairo',
      initials: '6C',
      country: Country.egypt,
      categories: [BrandCategory.womenswear, BrandCategory.menswear],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    ),
    Brand(
      name: 'Anut Cairo',
      initials: 'AC',
      country: Country.egypt,
      categories: [BrandCategory.homeAccessories],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    ),
    Brand(
      name: 'Rebel Cairo',
      initials: 'RC',
      country: Country.egypt,
      categories: [BrandCategory.womenswear],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchText = value;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchText = '';
    });
  }

  void _removeRecentSearch(String search) {
    setState(() {
      _recentSearches.remove(search);
    });
  }

  void _clearAllRecent() {
    setState(() {
      _recentSearches.clear();
    });
  }

  List<String> _getMatchingRecent() {
    if (_searchText.isEmpty) return [];
    return _recentSearches
        .where((s) => s.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  List<Brand> _getMatchingBrands() {
    if (_searchText.isEmpty) return [];
    return _searchableBrands
        .where((b) => b.name.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  List<StyleCard> _buildPopularCards() {
    final popularLooks = [
      Look(imageUrl: '', styleTag: 'Night Out', brand: _okhtein, color: const Color.fromARGB(255, 255, 255, 255)),
      Look(imageUrl: '', styleTag: 'Birthday', brand: _reemami, color: Colors.brown),
      Look(imageUrl: '', styleTag: 'Casual', brand: _emergencyRoom, color: Colors.green),
      Look(imageUrl: '', styleTag: 'Romantic', brand: _dalya, color: Colors.deepPurple),
    ];
    return popularLooks.map((look) => StyleCard(look: look)).toList();
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Image.asset('assets/images/KAIA.png', width: 200, height: 48, alignment: Alignment.topLeft),
        ),
        const SizedBox(height: 10),
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
                    autofocus: true,
                    controller: _searchController,
                    onChanged: _onSearchChanged,
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
                if (_searchText.isNotEmpty)
                  GestureDetector(
                    onTap: _clearSearch,
                    child: Icon(Icons.close, color: darkgreyColor, size: 18),
                  ),
                SizedBox(width:8),
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
        Expanded(
          child: _searchText.isEmpty
              ? _buildDefaultContent()
              : _buildSearchResults(),
        ),
      ],
    );
  }

  Widget _buildDefaultContent() {
    return _recentSearches.isEmpty
        ? _buildNoRecent()
        : _buildRecent();
  }

  Widget _buildSearchResults() {
    final matchingRecent = _getMatchingRecent();
    final matchingBrands = _getMatchingBrands();

    if (matchingRecent.isEmpty && matchingBrands.isEmpty) {
      return _buildNoResults();
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(7.0, 0, 7.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (matchingRecent.isNotEmpty) ...[
              Text('MATCHING RECENT', style: sectionLabel),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: matchingRecent.map((search) {
                  return InputChip(
                    label: Text(
                      search,
                      style: const TextStyle(
                        fontFamily: 'GlacialIndifference',
                        fontSize: 13,
                      ),
                    ),
                    onDeleted: () => _removeRecentSearch(search),
                    deleteIcon: const Icon(Icons.close, size: 14),
                    shape: const StadiumBorder(),
                    backgroundColor: greyColor,
                    side: BorderSide.none,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
            if (matchingBrands.isNotEmpty) ...[
              Text('BRANDS (${matchingBrands.length})', style: sectionLabel),
              const SizedBox(height: 10),
              ...matchingBrands.map((brand) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
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
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Icon(Icons.search, color: darkgreyColor.withValues(alpha: 0.3), size: 50),
          const SizedBox(height: 16),
          Text(
            'No results for "$_searchText"',
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

  Widget _buildRecent() {
    final popularLooks = [
      Look(imageUrl: '', styleTag: 'Night Out', brand: _okhtein, color: const Color.fromARGB(255, 255, 255, 255)),
      Look(imageUrl: '', styleTag: 'Birthday', brand: _reemami, color: Colors.brown),
      Look(imageUrl: '', styleTag: 'Casual', brand: _emergencyRoom, color: Colors.green),
      Look(imageUrl: '', styleTag: 'Romantic', brand: _dalya, color: Colors.deepPurple),
    ];
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
                  onTap: _clearAllRecent,
                  child: Text('Clear all', style: linkText),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _recentSearches.map((search) {
                return InputChip(
                  label: Text(
                    search,
                    style: const TextStyle(
                      fontFamily: 'GlacialIndifference',
                      fontSize: 16,
                    ),
                  ),
                  onDeleted: () => _removeRecentSearch(search),
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
              onSeeAllTap: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => SeeAllPage(title: 'Browse styles', looks:popularLooks)))
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildNoRecent() {
    final popularLooks = [
      Look(imageUrl: '', styleTag: 'Night Out', brand: _okhtein, color: const Color.fromARGB(255, 255, 255, 255)),
      Look(imageUrl: '', styleTag: 'Birthday', brand: _reemami, color: Colors.brown),
      Look(imageUrl: '', styleTag: 'Casual', brand: _emergencyRoom, color: Colors.green),
      Look(imageUrl: '', styleTag: 'Romantic', brand: _dalya, color: Colors.deepPurple),
    ];
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
          cards: _buildPopularCards(),onSeeAllTap: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => SeeAllPage(title: 'Browse styles', looks: popularLooks)))
        ),
        const SizedBox(height: 10),
      ]),
    );
  }
}