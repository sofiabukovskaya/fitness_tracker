import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'workout_list_screen.dart';
import 'profile_screen.dart';

class MainScreen extends HookWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    final screens = useMemoized(() => [
      const WorkoutListScreen(),
      const ProfileScreen(),
    ],);

    return Scaffold(
      body: screens[selectedIndex.value],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex.value,
        onDestinationSelected: (index) {
          selectedIndex.value = index;
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
