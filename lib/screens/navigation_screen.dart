import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/constants.dart';
import 'package:neurofit_app/screens/navigation/nutrition_page.dart';
import 'package:neurofit_app/screens/navigation/workout_page.dart';
import 'package:neurofit_app/screens/navigation/home_page.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class NavigationScreen extends ConsumerWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kWhite,
        selectedItemColor: kBlue,
        unselectedItemColor: Colors.grey[500],
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentIndexProvider.notifier).state = index;
        },
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: 'Nutrition'),
        ],
      ),
      body: SafeArea(child: NavigationBarItems()),
    );
  }
}

class NavigationBarItems extends ConsumerWidget {
  const NavigationBarItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    switch (currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return WorkoutPage();
      case 2:
        return NutritionPage();
      default:
        return Center(child: Text('Unknown page'));
    }
  }
}



