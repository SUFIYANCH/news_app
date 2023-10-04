import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/provider.dart';
import 'package:news_app/screens/discovery_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/profile_screen.dart';
import 'package:news_app/screens/saved_screen.dart';
import 'package:news_app/utils/colors.dart';

class CommonNav extends ConsumerWidget {
  const CommonNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: ref.watch(pageControllerProvider),
        children: const [
          HomeScreen(),
          DiscoveryScreen(),
          SavedScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(currentTabProvider),
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          ref.read(currentTabProvider.notifier).state = value;
          ref.watch(pageControllerProvider).jumpToPage(value);
        },
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: "Discovery"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), label: "Saved"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Profile"),
        ],
      ),
    );
  }
}
