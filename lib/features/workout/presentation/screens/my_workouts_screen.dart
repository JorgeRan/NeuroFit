import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/presentation/screens/exercise_screen.dart';
import 'package:neurofit_app/features/workout/presentation/screens/start_workout_screen.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/screens/create_workout_screen.dart';
import 'package:neurofit_app/shared/presentation/interactive_body.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/features/workout/presentation/screens/workout_screen.dart';

final filterProvider = StateProvider<bool>((ref) => false);

class MyWorkoutsScreen extends ConsumerWidget {
  const MyWorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allWorkouts = ref.watch(allWorkoutsProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            ref.read(createWorkoutCounterProvider.notifier).state = 0;
            ref.read(selectedMuscleGroupsProvider.notifier).state = [];
            ref.read(isFrontProvider.notifier).state = true;

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const CreateWorkoutScreen();
            }));
          },
          icon: Icon(
            Icons.add,
            color: kWhite,
          ),
          label: Text(
            'Create Workout',
            style:
                kTitleCard.copyWith(color: kWhite, fontWeight: FontWeight.bold),
          ),
          backgroundColor: kBlue,
        ),
        backgroundColor: kWorkoutPageColor,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: kWhite,
          elevation: 1,
          shadowColor: kBlack,
          actions: [
            Material(
              color: Colors.transparent,
              child: Text(
                'My Workouts',
                style: kPageTitle.copyWith(color: kBlack),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
          leading: IconButton(
            color: kBlack,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 220,
                  width: double.infinity,
                  child: Card(
                    color: kBlue,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 3),
                              decoration: BoxDecoration(
                                color: kCardBlue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text('WORKOUT OF THE DAY',
                                  style: TextStyle(color: kWhite)),
                            ),
                          ),
                          Text(
                            'Chest & Triceps Workout',
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '45 mins  •  6 excercises',
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: kWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow_outlined,
                                  color: kBlue,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Start Workout',
                                  style: TextStyle(
                                    color: kBlue,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SearchBar(
                  trailing: <Widget>[
                    Tooltip(
                      message: 'Change brightness mode',
                      child: IconButton(
                        onPressed: () {
                          if (ref.watch(filterProvider) == false) {
                            ref.read(filterProvider.notifier).state = true;
                          } else {
                            ref.read(filterProvider.notifier).state = false;
                          }
                        },
                        icon: const Icon(Icons.tune_rounded),
                        selectedIcon: const Icon(Icons.brightness_2_outlined),
                      ),
                    ),
                  ],
                  hintStyle:
                      WidgetStateProperty.all(TextStyle(color: Colors.grey)),
                  hintText: 'Search workout, muscles or equipment',
                  side: WidgetStateProperty.all(BorderSide(
                    color: kFieldBorder,
                    width: 1,
                  )),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  elevation: WidgetStateProperty.all(0),
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  onChanged: (value) => print('Search: $value'),
                ),
                if (ref.watch(filterProvider))
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: kBlack,
                  ),
                WorkoutSuggestion(
                    label: 'Based on your last session',
                    text:
                        'You\'ve been focusing on upper body. How about trying some leg exercises today?',
                    emogi: '🧠'),
                Text(
                  'All Workouts',
                  style: kTitleCard,
                ),
                Column(
                  children: allWorkouts
                      .map((workout) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            child: Card(
                              color: kWhite,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WorkoutScreen(
                                                workout: workout,
                                              )),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.16,
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                  ),
                                                  child: SizedBox(
                                                    width: 120,
                                                    height: 120,
                                                    child: Image.asset(
                                                      'assets/images/Upper Body.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Spacer()
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(workout.name,
                                                    style: kTitleCard),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  child: Wrap(
                                                    spacing: 6,
                                                    runSpacing: 6,
                                                    children: [
                                                      WorkoutCardChip(
                                                          label: 'Strength'),
                                                      Wrap(
                                                        spacing: 6,
                                                        runSpacing: 6,
                                                        children: [
                                                          ...workout
                                                              .targetMuscle
                                                              .take(2)
                                                              .map((muscle) =>
                                                                  WorkoutCardChip(
                                                                      label:
                                                                          muscle)),
                                                          if (workout
                                                                  .targetMuscle
                                                                  .length >
                                                              2)
                                                            Text(
                                                              '+${workout.targetMuscle.length - 2} more',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${workout.duration} mins  •  ${workout.exercises.length} exercises',
                                                      style: const TextStyle(
                                                        color: kTextGrey,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      WorkoutCardButtons(
                                        label: 'Start Now',
                                        icon: Icons.play_arrow_outlined,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StartWorkoutScreen(
                                                        workout: workout)),
                                          );
                                        },
                                      ),
                                      WorkoutCardButtons(
                                        label: 'Add to Routine',
                                        icon: Icons.add,
                                        onTap: () {
                                          print('Add to routine tapped');
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
