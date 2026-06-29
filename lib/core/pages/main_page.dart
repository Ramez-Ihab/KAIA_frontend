import 'package:flutter/material.dart';
import 'package:kaia/features/home/presentation/pages/home_page.dart';
import 'package:kaia/features/search/presentation/pages/search_page.dart';
import 'package:kaia/features/profile/presentation/pages/profile_page.dart';
import 'package:kaia/features/saved/presentation/pages/saved_page.dart';
import 'package:kaia/core/widgets/kaia_bottom_nav.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int tabIndex = 0;
  final GlobalKey<HomePageState> _homeKey = GlobalKey<HomePageState>();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _switchToTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: KaiaBottomNav(currentIndex: tabIndex, onTabTapped: onTabTapped),
      body: SafeArea(
        child: IndexedStack(
          index: tabIndex,
          children: [
            HomePage(
              key: _homeKey,
              onSearchTap: () {
                _switchToTab(1);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _searchFocusNode.requestFocus();
                });
              },
              onLocationSet: () => _switchToTab(3),
            ),
            SearchPage(focusNode: _searchFocusNode),
            SavedPage(onBrowseDiscoverTap: () {
              _switchToTab(0);
              _homeKey.currentState?.switchToDiscoverTab();
            }),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}