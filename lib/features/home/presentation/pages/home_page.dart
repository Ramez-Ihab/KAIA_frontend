import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/features/home/presentation/bloc/home_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/home_event.dart';
import 'package:kaia/features/home/presentation/bloc/home_state.dart';
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

    // Sync swipe gestures back to HomeBloc
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        final currentBlocIndex = context.read<HomeBloc>().state.activeTabIndex;
        if (_tabController.index != currentBlocIndex) {
          context.read<HomeBloc>().add(SetActiveTab(_tabController.index));
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Can be called externally or via HomeBloc.add(SetActiveTab(1))
  void switchToDiscoverTab() {
    context.read<HomeBloc>().add(SetActiveTab(1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      // Programmatic tab switches drive the TabController
      listenWhen: (prev, curr) => prev.activeTabIndex != curr.activeTabIndex,
      listener: (context, state) {
        if (_tabController.index != state.activeTabIndex) {
          _tabController.animateTo(state.activeTabIndex);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Image.asset('assets/images/KAIA.png', width: 200, height: 48, alignment: Alignment.topLeft),
          ),

          // Location banner
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (prev, curr) => prev.showBanner != curr.showBanner,
            builder: (context, homeState) {
              if (!homeState.showBanner) return const SizedBox.shrink();
              return BlocBuilder<LocationBloc, LocationState>(
                builder: (context, locationState) {
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
                                  context.read<HomeBloc>().add(LocationConfirmed());
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
                              onTap: () => context.read<HomeBloc>().add(DismissBanner()),
                              child: const Icon(Icons.close, color: primaryColor, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (prev, curr) => prev.shipsToMeEnabled != curr.shipsToMeEnabled,
            builder: (context, homeState) {
              return BlocBuilder<LocationBloc, LocationState>(
                builder: (context, locationState) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: greyColor, width: 1.5)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TabBar(
                            padding: const EdgeInsets.fromLTRB(7.0, 0, 0, 0),
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                            indicatorWeight: 1,
                            dividerColor: Colors.transparent,
                            labelColor: primaryColor,
                            unselectedLabelColor: darkgreyColor,
                            labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, fontFamily: 'GlacialIndifference'),
                            unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'GlacialIndifference'),
                            controller: _tabController,
                            tabs: const [
                              Tab(text: 'For you'),
                              Tab(text: 'Discover'),
                              Tab(text: 'Brands'),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Ships to me',
                              style: TextStyle(
                                color: homeState.shipsToMeEnabled ? primaryColor : darkgreyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'GlacialIndifference',
                              ),
                            ),
                            const SizedBox(width: 5),
                            Switch(
                              value: homeState.shipsToMeEnabled,
                              onChanged: (value) {
                                if (value && !locationState.isLocationSet) {
                                  showLocationBottomSheet(
                                    context: context,
                                    selectedCountry: locationState.selectedCountry ?? Country.all,
                                    onSelected: (country) {
                                      context.read<LocationBloc>().add(SetLocation(country));
                                      context.read<HomeBloc>().add(LocationConfirmed());
                                    },
                                  );
                                } else {
                                  context.read<HomeBloc>().add(ToggleShipsToMe());
                                }
                              },
                              activeThumbColor: primaryColor,
                              inactiveThumbColor: darkgreyColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ForYouContent(),
                DiscoverContent(),
                BrandsContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
