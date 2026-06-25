import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
class KaiaBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabTapped;
  const KaiaBottomNav({super.key
  , required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: const TextStyle(
  fontFamily: 'GlacialIndifference',
  fontSize: 12,
),
unselectedLabelStyle: const TextStyle(
  fontFamily: 'GlacialIndifference',
  fontSize: 12,
),
      currentIndex: currentIndex,
      onTap: onTabTapped,
      type:BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      unselectedItemColor: darkgreyColor,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          activeIcon: Icon(Icons.bookmark),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}