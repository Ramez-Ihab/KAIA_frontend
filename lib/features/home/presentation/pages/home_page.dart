import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/features/home/presentation/widgets/brands_content.dart';
import 'package:kaia/features/home/presentation/widgets/for_you_content.dart';
import 'package:kaia/features/home/presentation/widgets/discover_content.dart';
import 'package:kaia/features/profile/presentation/widgets/location_bottom_sheet.dart';
import 'package:kaia/features/search/presentation/widgets/photo_search.dart';
import 'package:kaia/features/location/presentation/bloc/location_bloc.dart';
import 'package:kaia/features/location/presentation/bloc/location_event.dart';
import 'package:kaia/features/location/presentation/bloc/location_state.dart';
import 'package:kaia/core/constants/country.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onSearchTap;

  const HomePage({super.key, required this.onSearchTap});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void switchToDiscoverTab() {
    _tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Image.asset('assets/images/KAIA.png', width: 200, height: 48, alignment: Alignment.topLeft),
        ),

        // Location banner
        BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
            if (!locationState.showBanner) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.fromLTRB(7.0, 0, 7.0, 0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                      child: Icon(Icons.location_pin, color: primaryColor, size: 16),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 40,
                        color: secondaryColor,
                        child: Text(
                          'Set your location to see brands that ship to you',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'GlacialIndifference',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        showLocationBottomSheet(
                          context: context,
                          selectedCountry: locationState.selectedCountry ?? Country.all,
                          onSelected: (country) {
                            context.read<LocationBloc>().add(SetLocation(country));
                          },
                        );
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 0),
                        padding: const EdgeInsets.symmetric(horizontal: 10.5, vertical: 5.5),
                        backgroundColor: const Color(0xFFEADDCF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'Set',
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'GlacialIndifference',
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<LocationBloc>().add(DismissBanner());
                        },
                        child: const Icon(Icons.close, color: primaryColor, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 10),

        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(7.0, 0, 7.0, 0),
          child: GestureDetector(
            onTap: widget.onSearchTap,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(11.0, 0, 0, 0),
                    child: Icon(Icons.search_outlined, color: darkgreyColor, size: 20),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Search or scan a photo...',
                      style: TextStyle(
                        color: darkgreyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'GlacialIndifference',
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: darkgreyColor,
                    thickness: 1,
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
        ),
        const SizedBox(height: 10),

        // Tabs + Ships to me
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: greyColor, width: 1.5)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TabBar(
                  padding: EdgeInsets.fromLTRB(7.0, 0, 0, 0),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  indicatorWeight: 1,
                  dividerColor: Colors.transparent,
                  labelColor: primaryColor,
                  unselectedLabelColor: darkgreyColor,
                  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, fontFamily: 'GlacialIndifference'),
                  unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'GlacialIndifference'),
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'For you'),
                    Tab(text: 'Discover'),
                    Tab(text: 'Brands'),
                  ],
                ),
              ),
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, locationState) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Ships to me",
                        style: TextStyle(
                          color: locationState.shipsToMeEnabled ? primaryColor : darkgreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'GlacialIndifference',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Switch(value: locationState.shipsToMeEnabled,
  onChanged: (value) {
    if (value && !locationState.isLocationSet) {
      showLocationBottomSheet(
        context: context,
        selectedCountry: locationState.selectedCountry ?? Country.all,
        onSelected: (country) {
          context.read<LocationBloc>().add(SetLocation(country));
        },
      );
    } else {
      context.read<LocationBloc>().add(ToggleShipsToMe());
    }
  },
  activeThumbColor: primaryColor,
  inactiveThumbColor: darkgreyColor,),
                    ],
                  );
                },
              ),
            ],
          ),
        ),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ForYouContent(),
              DiscoverContent(),
              BrandsContent(),
            ],
          ),
        ),
      ],
    );
  }
}