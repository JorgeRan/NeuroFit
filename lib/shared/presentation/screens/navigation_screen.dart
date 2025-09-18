import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/nutrition/presentation/screens/nutrition_screen.dart';
import 'package:neurofit_app/features/workout/presentation/screens/exercise_screen.dart';
import 'package:neurofit_app/features/home/presentation/screens/home_screens.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);
final logWorkoutProvider = StateProvider<String>((ref) => '');
final intensityProvider = StateProvider<String>((ref) => 'Moderate');

final List<String> items = ['Low', 'Moderate', 'High'];
final List<String> muscleGroups = [
  'Chest',
  'Back',
  'Shoulders',
  'Biceps',
  'Triceps',
  'Abs',
  'Quads',
  'Hamstrings',
  'Glutes',
  'Calves',
];

class NavigationScreen extends ConsumerWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    final selectedValue = ref.watch(intensityProvider);

    return Scaffold(
      backgroundColor: currentIndex == 1 ? kWorkoutPageColor : currentIndex == 2 ? kNutriitonPageColor : null,
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
                builder: (_) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10)),
                    insetPadding:
                        EdgeInsets.zero, 
                    backgroundColor: kWhite,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.80,
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Log Workout', style: kTitleCard),
                                        GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: Icon(Icons.close),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  QuestionTextWidget(
                                    question: 'Workout Type',
                                  ),
                                  CustomTextField(
                                    logWorkoutProvider,
                                    'e.g., Running, Weight Training',
                                    false,
                                    '',
                                    false,
                                    'Workout Type',
                                    0,
                                  ),
                                  QuestionTextWidget(
                                      question: "Duration (minutes)"),
                                  CustomTextField(
                                    logWorkoutProvider,
                                    'e.g., 45',
                                    false,
                                    '',
                                    true,
                                    'Duration',
                                    1,
                                  ),
                                  QuestionTextWidget(question: 'Intensity'),
                                  DropdownButtonFormField(
                                    borderRadius: BorderRadius.circular(10),
                                    dropdownColor: kWhite,
                                    value: selectedValue,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color:
                                                kFieldBorder), // Normal border color
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: kFieldBorder,
                                        ), // On focus
                                      ),

                                      border:
                                          OutlineInputBorder(), // Default border
                                    ),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        ref
                                            .read(intensityProvider.notifier)
                                            .state = newValue;
                                      }
                                    },
                                    items: items.map((String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  QuestionTextWidget(
                                      question: 'Muscle Groups Worked'),
                                  Wrap(
                                    spacing: 2,
                                    runSpacing: 2,
                                    children: muscleGroups.map((muscle) {
                                      return SelectableMuscleFilterChip(
                                        label: muscle,
                                        isSelected: false,
                                        questionIndex: 3,
                                      );
                                    }).toList(),
                                  ),
                                  QuestionTextWidget(question: 'Notes'),
                                  TextField(
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Any additional notes...',
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: kFieldBorder),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: kFieldBorder),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      ref
                                          .read(logWorkoutProvider.notifier)
                                          .state = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Text(
                                          'Cancel',
                                          style: kQuestionsText,
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: kBlue,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusGeometry
                                                          .circular(10))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.save,
                                                  color: kWhite,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  'Save Workout',
                                                  style: TextStyle(
                                                      color: kWhite,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
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
        return ExerciseScreen();
      case 2:
        return NutritionPage();
      default:
        return Center(child: Text('Unknown page'));
    }
  }
}
