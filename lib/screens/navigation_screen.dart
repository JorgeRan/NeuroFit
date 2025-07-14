import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/constants.dart';
import 'package:neurofit_app/screens/navigation/nutrition_page.dart';
import 'package:neurofit_app/screens/navigation/workout_page.dart';
import 'package:neurofit_app/screens/navigation/home_page.dart';
import 'package:neurofit_app/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

final currentIndexProvider = StateProvider<int>((ref) => 0);
final logWorkoutProvider = StateProvider<String>((ref) => '');
final intensityProvider = StateProvider<String>((ref) => 'Moderate');

final List<String> items = ['Low', 'Moderate', 'High'];

class NavigationScreen extends ConsumerWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    final selectedValue = ref.watch(intensityProvider);

    return Scaffold(
      floatingActionButton: currentIndex == 1
          ? FloatingActionButton.extended(
              icon: Icon(
                Icons.add,
                color: kWhite,
              ),
              label: Text(
                'Log Workout',
                style: kTitleCard.copyWith(
                    color: kWhite, fontWeight: FontWeight.bold),
              ),
              backgroundColor: kBlue,
              onPressed: () => showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext) => Dialog(
                        backgroundColor: kWhite,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Log Workout',
                                      style: kTitleCard,
                                    ),
                                    GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Icon(Icons.close)),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Workout Type',
                                      style: kQuestionsText,
                                    ),
                                    CustomTextField(
                                        logWorkoutProvider,
                                        'e.g., Running, Weight Training',
                                        false,
                                        '',
                                        false,
                                        'Workout Type',
                                        0),
                                    Text(
                                      'Duration (minutes)',
                                      style: kQuestionsText,
                                    ),
                                    CustomTextField(
                                        logWorkoutProvider,
                                        'e.g., 45',
                                        false,
                                        '',
                                        true,
                                        'Duration',
                                        1),
                                    Text(
                                      'Duration (minutes)',
                                      style: kQuestionsText,
                                    ),
                                    Platform.isIOS
                                        ? GestureDetector(
                                            onTap: () {
                                              showCupertinoModalPopup(
                                                context: context,
                                                builder: (_) => Container(
                                                  height: 250,
                                                  color: CupertinoColors
                                                      .systemBackground
                                                      .resolveFrom(context),
                                                  child: CupertinoPicker(
                                                    backgroundColor:
                                                        Colors.white,
                                                    itemExtent: 40,
                                                    scrollController:
                                                        FixedExtentScrollController(
                                                      initialItem:
                                                          items.indexOf(
                                                              selectedValue),
                                                    ),
                                                    onSelectedItemChanged:
                                                        (index) {
                                                      ref
                                                          .read(
                                                              intensityProvider
                                                                  .notifier)
                                                          .state = items[index];
                                                    },
                                                    children: items
                                                        .map((e) => Text(e))
                                                        .toList(),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: InputDecorator(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                              child: Text(selectedValue),
                                            ),
                                          )
                                        : DropdownButtonFormField<String>(
                                            value: selectedValue,
                                            decoration: InputDecoration(
                                              labelText: 'Intensity',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                ref
                                                    .read(intensityProvider
                                                        .notifier)
                                                    .state = newValue;
                                              }
                                            },
                                            items: items.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kWhite,
        selectedItemColor: kBlue,
        unselectedItemColor: Colors.grey[500],
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentIndexProvider.notifier).state = index;
        },
        items: [
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
